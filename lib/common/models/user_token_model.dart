class UserTokenModel {
  String? token;

  UserTokenModel({this.token});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    print("++++++++++++++++++++++++++++++++++++++" + json.toString());
    print("+++++++++++++++++++" + json.containsKey('token').toString());
    return UserTokenModel(
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
