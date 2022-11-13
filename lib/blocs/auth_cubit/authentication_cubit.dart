import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationCubit extends Cubit<bool> {
  AuthenticationCubit() : super(false);

  int? forceResendingTocken;
  String verificationIdValue = "";

  Future<void> phoneAuth(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      forceResendingToken: forceResendingTocken,
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: '${e.message} Login Failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        forceResendingTocken = resendToken;
        verificationIdValue = verificationId;
        Fluttertoast.showToast(msg: "OTP sent to mobile");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // phoneAuth(phoneNumber);
      },
    );
  }

  Future<UserCredential?> verifyOtp(String otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdValue, smsCode: otp);
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        emit(true);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid otp");
    }

    return userCredential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user != null) {
      emit(true);
    }
    return userCredential;
  }

  void reset() {
    emit(false);
  }
}
