class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;

  UserManager._internal();

  String _username = "";
  String _password = "";

  String getUsername() {
    return _username;
  }

  void setUsername(String newUsername) {
    _username = newUsername;
  }

  String getPassword() {
    return _password;
  }

  void setPassword(String newPassword) {
    _password = newPassword;
  }
}