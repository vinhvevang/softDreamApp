import 'package:hive/hive.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box box;

  AuthRepositoryImpl(this.box);

  @override
  bool get isLoggedIn => box.get('isLogin', defaultValue: false) as bool;

  @override
  String get savedTax => box.get('tax', defaultValue: '') as String;

  @override
  String get savedUserName => box.get('userName', defaultValue: '') as String;

  @override
  String get savedPassword => box.get('passWord', defaultValue: '') as String;

  @override
  Future<void> saveSession({
    required String tax,
    required String userName,
    required String password,
  }) async {
    await box.put('tax', tax);
    await box.put('userName', userName);
    await box.put('passWord', password);
    await box.put('isLogin', true);
  }

  @override
  Future<void> logout() async {
    await box.put('isLogin', false);
  }
}