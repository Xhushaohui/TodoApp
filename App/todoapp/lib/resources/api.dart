import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/classes/task.dart';
import 'dart:convert';
import '../models/classes/user.dart';

class ApiProvider {
  Client client = Client();

  Future<User> registerUser(String username, String firstname, String lastname,
      String password, String email) async {
    final response = await client.post("http://127.0.0.1:5000/api/register",
        // headers: "",
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "firstname": firstname,
          "lastname": lastname
        }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["registering"]["api_key"]);
      return User.fromJson(result["registering"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future signinUser(String username, String password, String apiKey) async {
    final response = await client.post("http://127.0.0.1:5000/api/signin",
        headers: {"Authorization": apiKey},
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["Signin"]["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future addUserTask(String apiKey, String taskName, String deadline) async {
    final response = await client.post("http://127.0.0.1:5000/api/tasks",
        headers: {"Authorization": apiKey},
        body: jsonEncode({
          "note": "",
          "repeats": "",
          "completed": 0,
          "deadline": deadline,
          "reminder": "",
          "title": taskName,
        }));
    // final Map result = json.decode(response.body);

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      print("Task added !");
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Task>> getUserTasks(String apiKey) async {
    final response = await client.get(
      "http://127.0.0.1:5000/api/tasks",
      headers: {"Authorization": apiKey},
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      List<Task> tasks = [];
      for (Map json_ in result["Tasks"]) {
        try {
          tasks.add(Task.fromJson(json_));
        } catch (Exception) {
          print(Exception);
        }
      }
      return tasks;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('API_Token', api_key);
  }
}
