
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feb24_pro_visitor/src/service/location_service.dart';
import 'package:feb24_pro_visitor/src/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  final userService = UserService();
  final locationService = LocationService();

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
                    fontFamily: 'Avenir',
                    color: Color.fromRGBO(250, 249, 246, 1),
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                ),
                const Spacer(flex: 1),
                Row(
                  children: [
                    const Spacer(flex: 80),
                    const Text(
                      'Your score is',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromRGBO(250, 249, 246, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
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
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w800,
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    Map<String, dynamic>? information = snapshot.data?.data();
                    if (information?['current-location'] == null) {
                      return QrImageView(
                        backgroundColor: Colors.white,
                        data: user.uid,
                        size: 350,
                      );
                    } else {
                      return FutureBuilder(
                        future: locationService
                            .getLocation(information?['current-location']),
                        builder: (context, snapshot) {
                          Map<String, dynamic>? location = snapshot.data;
                          return Container(
                              width: 334,
                              height: 235,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromRGBO(
                                    250,
                                    249,
                                    246,
                                    1,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "You're in!",
                                    style: TextStyle(
                                      color: Color.fromRGBO(
                                        250,
                                        249,
                                        246,
                                        1,
                                      ),
                                      fontFamily: 'Avenir',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    location?['name'] ?? '',
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontFamily: 'Avenir',
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ));
                        },
                      );
                    }
                  },
                ),
                const Spacer(flex: 8),
                SizedBox(
                  width: 150,
                  child: TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        navigatorState.pushReplacementNamed('/login');
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Color.fromRGBO(250, 249, 246, 1),
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(
                                color: Color.fromRGBO(250, 249, 246, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Avenir'),
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
