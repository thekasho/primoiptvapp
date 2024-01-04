class AuthModel {
  String? macAddress;
  String? regId;
  String? regStatue;

  AuthModel({
    this.macAddress,
    this.regId,
    this.regStatue,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    macAddress = json['macAddress'];
    regId = json['regId'];
    regStatue = json['regStatue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['macAddress'] = macAddress;
    data['regId'] = regId;
    data['regStatue'] = regStatue;
    return data;
  }
  
}
