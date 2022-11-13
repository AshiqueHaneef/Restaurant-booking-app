import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:restaurant_app/blocs/auth_cubit/authentication_cubit.dart';
import 'package:restaurant_app/screens/home_page.dart';

class PhoneAuthDialogue extends StatefulWidget {
  const PhoneAuthDialogue({Key? key}) : super(key: key);

  @override
  State<PhoneAuthDialogue> createState() => _PhoneAuthDialogueState();
}

class _PhoneAuthDialogueState extends State<PhoneAuthDialogue> {
  TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  late bool _isOtp;
  late bool _isLoading;
  String otp = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isOtp = false;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthenticationCubit>();
    return Scaffold(
      body: Center(
        child: _isOtp
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter your otp",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    style: const TextStyle(fontSize: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    onChanged: (value) {},
                    onCompleted: (value) async {
                      setState(() {
                        otp = value;
                        _isLoading = true;
                      });
                      await authCubit.verifyOtp(value);
                      if (authCubit.state) {
                        authCubit.reset();
                        Fluttertoast.showToast(msg: "Succesfully signed in");
                        navTOHome();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.green.shade900,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 12),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () async {
                            await authCubit.verifyOtp(otp);
                            if (authCubit.state) {
                              Fluttertoast.showToast(
                                  msg: "Succesfully signed in");
                              navTOHome();
                              authCubit.reset();
                            }
                          },
                          child: const Text("Validate"))
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter your phone number",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber value) {
                      number = value;
                    },
                    initialValue: number,
                    textFieldController: controller,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        if (number.phoneNumber != null) {
                          setState(() {
                            _isOtp = true;
                          });
                          await authCubit
                              .phoneAuth(number.phoneNumber.toString());
                        }
                      },
                      child: const Text("Sign In"))
                ],
              ),
      ),
    );
  }

  navTOHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => true);
  }
}
