class ServerModel {
  String? domain;
  String? port;
  String? username;
  String? password;

  ServerModel({
    this.domain,
    this.port,
    this.username,
    this.password,
  });

  ServerModel.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    port = json['port'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domain'] = domain;
    data['port'] = port;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

}
