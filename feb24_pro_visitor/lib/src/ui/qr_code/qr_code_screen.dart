import 'package:feb24_pro_visitor/src/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  final userService = UserService();

  QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception(); //TODO REROUTE
    NavigatorState navigatorState = Navigator.of(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
        body: FutureBuilder(
      future: userService.getUser(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data == null) throw Exception();
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Hi ${snapshot.data!['fullname']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your score is',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${snapshot.data!['score']}',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () =>
                        navigatorState.pushReplacementNamed('/overview'),
                    child: Text(
                      'Go to overview >',
                      style: TextStyle(
                          color: Colors.grey[700],
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey[700]),
                    ),
                  ), //TODO update route once overview page exists
                ],
              ),
              QrImageView(
                data: user.uid,
                size: 400,
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.logout,
                        ),
                        Text('Log out')
                      ],
                    )),
              ),
            ],
          );
        }
      },
    ));
  }
}
