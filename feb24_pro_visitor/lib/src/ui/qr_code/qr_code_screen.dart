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
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 4),
                Text(
                  'Hi ${snapshot.data!['fullname']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Spacer(flex: 1),
                Row(
                  children: [
                    const Spacer(flex: 80),
                    const Text(
                      'Your score is',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 1),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 100),
                      child: Text(
                        '${snapshot.data!['score']}',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(flex: 80),
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
                const Spacer(flex: 3),
                Container(
                  width: 400,
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('qr-outline.png'), fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 350,
                      height: 350,
                      child: QrImageView(
                        backgroundColor: Colors.white,
                        data: user.uid,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 8),
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
                            color: Colors.white,
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
                const Spacer(flex: 1),
              ],
            ),
          );
        }
      },
    ));
  }
}
