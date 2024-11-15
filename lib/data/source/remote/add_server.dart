import 'package:primpiptv/core/class/crud.dart';

class AddServer {
  Crud crud;
  AddServer(this.crud);

  getData(String link, String username, String pass) async {
    var response = await crud.getData("$link/player_api.php?username=$username&password=$pass");
    return response.fold((l) => l, (r) => r);
  }
}