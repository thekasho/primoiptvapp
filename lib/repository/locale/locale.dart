part of '../api/api.dart';

class LocaleApi {

  static Future<bool> saveAuthData(Map authData) async {
    try {
      // await locale.remove("auth_data");
      await locale.write("auth_data", authData);
      print("Success Save Auth Data");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<AuthModel?> getAuthData() async {
    try {
      final authData = await locale.read("auth_data");

      if (authData != null) {
        print("Success Get Auth Data");
        return AuthModel.fromJson(authData);
      } else {
        debugPrint("Error Get Auth Data");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Auth Data: $e");
      return null;
    }
  }
  
  //---------------------------------------------

  static Future<bool> saveServerData(Map serverData) async {
    try {
      await locale.write("server_data", serverData);
      print("Success Save Server Data");
      return true;
    } catch (e) {
      print("Error Save Server Data: $e");
      return false;
    }
  }

  static Future<ServerModel?> getServerData() async {
    try {
      // await locale.remove("server_data");
      final serverData = await locale.read("server_data");
      
      if (serverData != null) {
        print("Success Get Server Data");
        return ServerModel.fromJson(serverData);
      } else {
        debugPrint("Error Get Server Data");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Server Data: $e");
      return null;
    }
  }

  static Future<bool> removeServerData() async {
    try {
      await locale.remove("server_data");
      print("Success Delete Server Data");
      return true;
    } catch (e) {
      print("Error Delete Server Data: $e");
      return false;
    }
  }

  //---------------------------------------------

  static Future<bool> saveUser(UserModel user) async {

    try {
      await locale.write("user", user.toJson());
      return true;
    } catch (e) {
      debugPrint("Error save User: $e");
      return false;
    }
  }

  static Future<UserModel?> getUser() async {
    try {
      final user = await locale.read("user");
      
      if (user != null) {
        return UserModel.fromJson(user);
      }
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }
  //---------------------------------------------

  static Future<bool> logOut() async {
    try {
      await locale.remove("loginData");
      await locale.remove("user");

      return true;
    } catch (e) {
      debugPrint("Error LogOut User: $e");
      return false;
    }
  }
  
  static Future<bool> saveLoginData(Map loginData) async {
    try {
      await locale.write("loginData", loginData);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  static Future<LoginModel?> getLoginInfo() async {
    try {
      final user = await locale.read("loginData");

      if (user != null) {
        return LoginModel.fromJson(user);
      }
      debugPrint('local user data null');
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<bool> saveAccount(Map? account) async {
    try {
      // await locale.remove("user_accounts");
      await locale.write("user_accounts", account);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  static Future<Map?> getAccounts() async {
    try {
      final users = await locale.read("user_accounts");

      if (users != null) {
        return users;
      }
      debugPrint('local user data null');
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<List?> getSeriesList() async {
    try {
      final series = await locale.read("series_list");

      if(series != null){
        debugPrint("Success Get Series List");
        return series;
      } else {
        debugPrint("Error Get Series List");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Series List: $e");
      return null;
    }
  }

  static Future<bool> saveSeriesList(List? series) async {
    try {
      await locale.write("series_list", series);
      debugPrint("Success Save Series");
      return true;
    } catch (e) {
      debugPrint("Error save Series: $e");
      return false;
    }
  }

  //---------------------------------------------

  static Future<bool> saveMoviesList(List? movies) async {
    try {
      await locale.write("movies_list", movies);
      debugPrint("Success Save Movies");
      return true;
    } catch (e) {
      debugPrint("Error Save Movies: $e");
      return false;
    }
  }

  static Future<List?> getMoviesList() async {
    try {
      final movies = await locale.read("movies_list");
      
      if(movies != null){
        debugPrint("Success Get Movies List");
        return movies;
      } else {
        debugPrint("Error Get Movies List");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Movies List: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<bool> saveMoviesCats(List? movies) async {
    try {
      await locale.write("movies_cats", movies);
      return true;
    } catch (e) {
      debugPrint("Error Save Movies Cats: $e");
      return false;
    }
  }

  static Future<List?> getMoviesCats() async {
    try {
      final movies = await locale.read("movies_cats");
      
      if(movies != null){
        debugPrint("Success Get Movies Cats");
        return movies;
      } else {
        debugPrint("Error Get Movies Cats");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Movies Cats: $e");
      return null;
    }
  }

  //---------------------------------------------

  static Future<List?> getLiveCats() async {
    try {
      final movies = await locale.read("live_cats");

      // await locale.remove("live_cats");

      if(movies != null){
        debugPrint("Success Get Live Cats");
        return movies;
      } else {
        debugPrint("Error Get Live Cats");
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Live Cats: $e");
      return null;
    }
  }
  
  static Future<bool> saveLiveCats(List? liveCats) async {
    try {
      await locale.write("live_cats", liveCats);
      debugPrint("Success Save Live Cats");
      return true;
    } catch (e) {
      debugPrint("Error Save Live Cats: $e");
      return false;
    }
  }
  //---------------------------------------------
  
  static Future<Map?> getFavourite() async {
    try {
      final favourites = await locale.read("fav_channels");

      if(favourites != null){
        debugPrint("Success Get Live Fav");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error Get Live Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavourite(Map? fav) async {
    try {
      await locale.write("fav_channels", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }
  
  //---------------------------------------------

  static Future<Map?> getFavouriteMovies() async {
    try {
      // await locale.remove("fav_movies");

      final favourites = await locale.read("fav_movies");

      if(favourites != null){
        debugPrint("Success Get Fav Movies");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavouriteMovies(Map? fav) async {
    try {
      await locale.write("fav_movies", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  //---------------------------------------------

  static Future<Map?> getFavouriteSeries() async {
    try {
      // await locale.remove("fav_series");

      final favourites = await locale.read("fav_series");

      if(favourites != null){
        debugPrint("Success Get Fav Series");
        return favourites;
      }
      return null;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return null;
    }
  }

  static Future<bool> saveFavouriteSeries(Map? fav) async {
    try {
      await locale.write("fav_series", fav);
      return true;
    } catch (e) {
      debugPrint("Error save Fav: $e");
      return false;
    }
  }

  //---------------------------------------------
  
  static Future<bool> saveServer(Map server) async {
    try {
      await locale.write("servers_data", server);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<Map?> getServers() async {
    try {
      final servers = await locale.read("servers_data");

      if (servers != null) {
        return servers;
      }
      else {
        print('no data');
      }
      return null;
    } catch (e) {
      debugPrint("Error save User: $e");
      return null;
    }
  }

  static Future<bool?> removeAllServers() async {
    try {
      await locale.remove("servers_data");
      return true;
    } catch (e) {
      debugPrint("Error LogOut User: $e");
      return false;
    }
  }
}
