class UserTokenModel {
  int statusCode;
  String? token;

  UserTokenModel({this.token, this.statusCode = 0});

  factory UserTokenModel.fromResponse(dynamic jsonResponse) {
    return UserTokenModel(
      statusCode: jsonResponse['statusCode'] as int,
      token: jsonResponse['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'token': token,
  };
}
