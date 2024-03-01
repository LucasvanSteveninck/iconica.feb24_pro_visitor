import 'package:feb24_pro_visitor/src/service/user_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserService userService = UserService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    if (await userService.login(email, password)) {
      Navigator.pushReplacementNamed(context, '/qr-code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 60.0, right: 60.0, bottom: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Log in',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Color(0xFFFAF9F6),
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),
            Container(
              height: 40, 
              child: TextFormField(
                controller: _emailController,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Color(0xFFFAF9F6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                decoration: const InputDecoration(
                  
                  hintText: 'Email address',
                  hintStyle: TextStyle(color: Color(0xFFFAF9F6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFAF9F6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFAF9F6)),
                  ),
                  
                  contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10), 
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 40, 
              child: TextFormField(
                controller: _passwordController,
                                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Color(0xFFFAF9F6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xFFFAF9F6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFAF9F6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFAF9F6)),
                  ),
                  suffixIcon: Icon(Icons.visibility_off,
                      color: Color(0xFFFAF9F6)),
                  contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10), 
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFFFAF9F6),
                    backgroundColor: const Color(0xFFC57CFF)),
                onPressed: _login,
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
