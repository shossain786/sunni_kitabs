import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication_bloc.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username")),
            TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true),
            const SizedBox(height: 20),
            BlocConsumer<AuthenticationBloc, bool>(
              listener: (context, state) {
                if (state) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Failed")));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().login(
                          usernameController.text,
                          passwordController.text,
                        );
                  },
                  child: const Text("Login"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
