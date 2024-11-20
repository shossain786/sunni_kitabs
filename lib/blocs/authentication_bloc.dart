import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthenticationBloc extends Cubit<bool> {
  AuthenticationBloc() : super(false);

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://yourserver.com/login.php'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        emit(true); // Logged in successfully
      } else {
        emit(false); // Login failed
      }
    }
  }
}
