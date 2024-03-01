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
            children: [
              Text('Hello ${snapshot.data!['fullname']}', style: const TextStyle(color: Colors.white)),
              Text('Your score is ${snapshot.data!['score']}', style: const TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () =>
                    navigatorState.pushReplacementNamed('/overview'),
                child: const Text('Go to overview >'),
              ), //TODO update route once overview page exists
              QrImageView(data: user.uid, size: 800),
              ElevatedButton(
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
            ],
          );
        }
      },
    ));
  }
}
