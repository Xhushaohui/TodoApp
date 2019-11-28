import 'dart:async';
import 'api.dart';
import '../models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String firstname, String lastname,
          String password, String email) =>
      apiProvider.registerUser(username, firstname, lastname, password, email);

  Future signinUser(String username, String password, String apiKey) =>
      apiProvider.signinUser(username, password, apiKey);

  Future getUserTasks(String apiKey) => apiProvider.getUserTasks(apiKey);

  Future addUserTask(String apiKey, String taskName, String deadline) =>
      apiProvider.addUserTask(apiKey, taskName, deadline);
}
