import '../../../app_link.dart';
import '../../../core/class/crud.dart';

class InitData {
  Crud crud;
  InitData(this.crud);

  postData(Map data) async {
    var response = await crud.postData(ApiLinks.authUsr, data);
    return response.fold((l) => l, (r) => r);
  }

  getServerData(Map data) async {
    var serverData = await crud.postData(ApiLinks.serverData, data);
    return serverData.fold((l) => l, (r) => r);
  }

  getServerAuth() async {
    var serverAuth = await crud.postData(ApiLinks.getServerAuth, {});
    return serverAuth.fold((l) => l, (r) => r);
  }

  getLiveCats(String link) async {
    var liveCats = await crud.getListData(link);
    return liveCats.fold((l) => l, (r) => r);
  }

  getLiveCatChilds(String link) async {
    var liveCatChilds = await crud.getListData(link);
    return liveCatChilds.fold((l) => l, (r) => r);
  }

  getMovies(String link) async {
    var liveCats = await crud.getListData(link);
    return liveCats.fold((l) => l, (r) => r);
  }

  getSeries(String link) async {
    var liveCats = await crud.getListData(link);
    return liveCats.fold((l) => l, (r) => r);
  }

  getMovieDetails(String link) async {
    var movieDetails = await crud.getData(link);
    return movieDetails.fold((l) => l, (r) => r);
  }

  getSeriesDetails(String link) async {
    var seriesDetails = await crud.getData(link);
    return seriesDetails.fold((l) => l, (r) => r);
  }

}