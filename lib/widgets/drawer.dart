import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/blocs/auth_cubit/authentication_cubit.dart';
import 'package:restaurant_app/common/alignment_utils.dart';
import 'package:restaurant_app/screens/login_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final authCubit = context.watch<AuthenticationCubit>();
    return SafeArea(
        child: Drawer(
      width: context.screenSize().width - 40,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: context.screenSize().height / 3.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.yellow.withOpacity(0.5)],
                  begin: Alignment.bottomLeft,
                  end: const Alignment(4, 0.1),
                  tileMode: TileMode.repeated,
                ),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: (_auth.currentUser?.photoURL ?? "").isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              _auth.currentUser?.photoURL ?? "",
                              height: 70,
                            ),
                          )
                        : Image.asset(
                            "assets/avatar.png",
                            fit: BoxFit.contain,
                            height: 70,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _auth.currentUser?.displayName ??
                      _auth.currentUser?.phoneNumber.toString() ??
                      "",
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "ID : ${_auth.currentUser?.uid}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () async {
              await _auth.signOut();
              authCubit.reset();
              Fluttertoast.showToast(
                  msg: "Your account signed out succesfully");
              navTologin(context);
            },
            leading: const Icon(
              Icons.logout,
              size: 40,
            ),
            title: const Text(
              "Log out",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            horizontalTitleGap: context.screenSize().width / 7,
          )
        ],
      ),
    ));
  }

  navTologin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }
}
