import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/blocs/auth_cubit/authentication_cubit.dart';
import 'package:restaurant_app/common/alignment_utils.dart';
import 'package:restaurant_app/widgets/phone_auth_widget.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthenticationCubit>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/firebase.png",
                  height: context.screenSize().height / 5,
                ),
                SizedBox(
                  height: context.screenSize().height / 4,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await authCubit.signInWithGoogle();
                    if (authCubit.state) {
                      Fluttertoast.showToast(msg: "Succesfully signed in");
                      authCubit.reset();
                      navToHome(context);
                    } else {
                      Fluttertoast.showToast(msg: "Sign in failed");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: context.screenSize().width / 25,
                          horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          "assets/google.png",
                          height: 22,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Google",
                        style: TextStyle(fontSize: 22),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneAuthDialogue()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          vertical: context.screenSize().width / 25,
                          horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                      Spacer(),
                      Text(
                        "Phone",
                        style: TextStyle(fontSize: 22),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
