import 'dart:async';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../repository/api/api.dart';
import '../../repository/models/channel_movie.dart';
import '../../repository/models/channel_serie.dart';

abstract class HomeController extends GetxController {
  getMoviesCats();
  // LogOut();
  updateLists();
  getLoggedInfo();
}
class HomeControllerImp extends HomeController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  String macAddress = "";
  List movies = [];
  int moviesCount = 5;

  List series = [];
  int seriesCount = 5;
  bool isConnected = false;

  @override
  updateLists() async {
    try {
      final user = await LocaleApi.getUser();
      
      if(user == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_vod_streams";
      var oldMovies = await initData.getMovies(url);
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
      await waitWhile(oldMovies!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesList(oldMovies)).then((value) => print("movies updated"));

      var urls = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_series";
      var oldSeries = await initData.getSeries(urls);
      Future waitWhiles(bool oldSeries, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (oldSeries) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhiles(oldSeries!.isNotEmpty).then((value) async => await LocaleApi.saveSeriesList(oldSeries)).then((value) => print("series updated"));

      var urlv = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_live_categories";
      var oldLiveCats = await initData.getLiveCats(urlv);
      Future waitWhilev(bool oldLiveCats, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (oldLiveCats) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhilev(oldLiveCats!.isNotEmpty).then((value) async => await LocaleApi.saveLiveCats(oldLiveCats)).then((value) => print("live cats updated"));
      update();
      
    } catch (e) {
      print(e);
    }
  }

  @override
  getMoviesCats() async {
    try {
      final user = await LocaleApi.getUser();
      var oldMovies = await LocaleApi.getMoviesList();
      var oldSeries = await LocaleApi.getSeriesList();
      var oldLiveCats = await LocaleApi.getLiveCats();
      
      if(user == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      if(oldMovies == null){
        var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_vod_streams";
        oldMovies = await initData.getMovies(url);
        Future waitWhile(bool oldMovies, [Duration pollInterval = Duration.zero]) {
          var completer = Completer();
          check() {
            if (oldMovies) {
              completer.complete();
            } else {
              Timer(pollInterval, check);
            }
          }
          check();
          return completer.future;
        }
        await waitWhile(oldMovies!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesList(oldMovies));
        update();
      }
      if(oldSeries == null){
        var urls = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_series";
        oldSeries = await initData.getSeries(urls);
        Future waitWhile(bool oldSeries, [Duration pollInterval = Duration.zero]) {
          var completer = Completer();
          check() {
            if (oldSeries) {
              completer.complete();
            } else {
              Timer(pollInterval, check);
            }
          }
          check();
          return completer.future;
        }
        await waitWhile(oldSeries!.isNotEmpty).then((value) async => await LocaleApi.saveSeriesList(oldSeries));
        update();
      }
      if(oldLiveCats == null){
        var urlv = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_live_categories";
        oldLiveCats = await initData.getLiveCats(urlv);
        Future waitWhilev(bool oldLiveCats, [Duration pollInterval = Duration.zero]) {
          var completer = Completer();
          check() {
            if (oldLiveCats) {
              completer.complete();
            } else {
              Timer(pollInterval, check);
            }
          }
          check();
          return completer.future;
        }
        await waitWhilev(oldLiveCats!.isNotEmpty).then((value) async => await LocaleApi.saveLiveCats(oldLiveCats));
        update();
      }

      movies = [];
      final moviesList = oldMovies.map( (e) => ChannelMovie.fromJson(e) ).toList();
      moviesCount = moviesList.length;
      for(var i=0; i<8; i++){
        movies.add(moviesList[i]);
      }
      
      series = [];
      final seriesList = oldSeries.map( (e) => ChannelSerie.fromJson(e) ).toList();
      seriesCount = seriesList.length;
      for(var iv=1; iv<7; iv++){
        series.add(seriesList[seriesCount -iv]);
      }

      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  getLoggedInfo() async {
    final auth = await LocaleApi.getAuthData();
    macAddress = auth!.macAddress!;
    update();
  }

  // @override
  // LogOut() async {
  //   var loginInfo = await LocaleApi.logOut();
  //   if(loginInfo){
  //     Future.delayed(const Duration(seconds: 1)).then((value) {
  //       Get.offAndToNamed(screenLogin);
  //     });
  //   }
  //   update();
  // }

  @override
  void onInit() async {
    getMoviesCats();
    updateLists();
    getLoggedInfo();
    super.onInit();
  }
}