import 'dart:io';

void main(List<String> arguments) {
  print('Welcome to GD Modul Dart!');
  print('=========================');
  print('----------Login----------');
  stdout.write('Username: ');
  String? username = stdin.readLineSync();
  stdout.write('Password: ');
  String? password = stdin.readLineSync();

  LoginController loginController = LoginController();
  loginController.login(username: username ?? '', password: password ?? '');
}

class LoginController {
  final LoginRepository loginRepository = LoginRepository();
  User userLogined = User();

  Future<void> login(
      {required String username, required String password}) async {
    try {
      userLogined = await loginRepository.login(username, password);
      print("Login Success... Here your User data ${userLogined.toString()}");
    } on FailedLogin catch (e) {
      print(e.errorMessage());
    } on String catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      print("Login process has been completed");
    }
  }
}

class User {
  final String? name;
  final String? password;
  final String? token;

  User({this.name, this.password, this.token});

  @override
  String toString() {
    return 'User{name: $name, password: $password, token: $token}';
  }
}

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  String username = "User";
  String password = "123";

  Future<User> login(String username, String password) async {
    print("Logining...");
    User userData = User();
    await Future.delayed(Duration(seconds: 3), () {
      if (this.username == username && this.password == password) {
        userData = User(name: username, password: password, token: "12345");
      } else if (username == '' || password == '') {
        throw 'Username or password cannot be empty';
      } else {
        throw FailedLogin();
      }
    });
    return userData;
  }
}
