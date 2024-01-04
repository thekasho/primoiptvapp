import 'dart:async';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/category.dart';
import 'movies_channels_cont.dart';

abstract class MoviesCatsController extends GetxController {
  getCats();
  updateMovieCatsList();
}

class MoviesCatsControllerImp extends MoviesCatsController {

  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());
  MovieChannelsControllerImp movieChannelsControllerImp = MovieChannelsControllerImp();

  StatusRequest statusRequest = StatusRequest.none;

  List categories = [];
  List catsCount = [];
  var cats = [];

  var favCat = [{"category_id": "1000000", "category_name": "المفضلة", "parent_id": "0"}];
  int selectedCat = 1;

  @override
  updateMovieCatsList() async {
    try {
      final user = await LocaleApi.getUser();
      
      if(user == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!! -> Movies");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_vod_categories";
      var oldMoviesCats = await initData.getLiveCats(url);
      Future waitWhile(bool liveCats, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (liveCats) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhile(oldMoviesCats!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesCats(oldMoviesCats));
      print("updated");
    } catch (e) {
      print(e);
    }
  }

  @override
  getCats() async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final user = await LocaleApi.getUser();
      var oldMoviesCats = await LocaleApi.getMoviesCats();

      if(user == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!! -> Movies");
        return;
      }

      if(oldMoviesCats == null){
        var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_vod_categories";
        oldMoviesCats = await initData.getLiveCats(url);
        Future waitWhile(bool liveCats, [Duration pollInterval = Duration.zero]) {
          var completer = Completer();
          check() {
            if (liveCats) {
              completer.complete();
            } else {
              Timer(pollInterval, check);
            }
          }
          check();
          return completer.future;
        }
        await waitWhile(oldMoviesCats!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesCats(oldMoviesCats));
        update();
      }
      
      categories = [];
      cats = [];

      cats.addAll(favCat);
      cats.addAll(oldMoviesCats);

      final list = cats.map((e) => CategoryModel.fromJson(e)).toList();
      categories.addAll(list);

      statusRequest = StatusRequest.success;
      update();

    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getCats();
    updateMovieCatsList();
    super.onInit();
  }
  

}