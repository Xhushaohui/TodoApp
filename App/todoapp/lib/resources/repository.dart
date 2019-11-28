import 'dart:async';
import 'api.dart';
import '../models/classes/user.dart';

class Repository {
  final userApiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname,
          String password, String email) =>
      userApiProvider.registerUser(
          username, firstname, lastname, password, email);

  Future signinUser(String username, String password, String apiKey) =>
      userApiProvider.signinUser(username, password, apiKey);

  Future getUserTasks(String apiKey) => userApiProvider.getUserTasks(apiKey);
}
