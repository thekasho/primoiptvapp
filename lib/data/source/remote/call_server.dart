import '../../../core/class/crud.dart';

class CallServer {
  Crud crud;
  CallServer(this.crud);

  fetchServer(String? serverLink, String? serverPort, String? serverUsername, String? serverPassword) async {
    var link = "$serverLink:$serverPort/player_api.php?username=$serverUsername&password=$serverPassword";
    var response = await crud.getData(link);
    return response.fold((l) => l, (r) => r);
  }
}