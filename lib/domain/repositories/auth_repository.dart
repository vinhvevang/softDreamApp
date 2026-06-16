abstract class AuthRepository {
  bool get isLoggedIn;
  String get savedTax;
  String get savedUserName;
  String get savedPassword;

  Future<void> saveSession({
    required String tax,
    required String userName,
    required String password,
  });

  Future<void> logout();
}