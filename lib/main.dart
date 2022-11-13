import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/auth_cubit/authentication_cubit.dart';
import 'package:restaurant_app/blocs/cart_cubit/cart_cubit.dart';
import 'package:restaurant_app/blocs/loading_cubit.dart';
import 'package:restaurant_app/blocs/restraunt_cubit/restraunt_cubit.dart';
import 'package:restaurant_app/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => RestrauntCubit()..getRestaurant(),
      ),
      BlocProvider(
        create: (context) => CartCubit(),
      ),
      BlocProvider(
        create: (context) => LoadingCubit(),
      ),
      BlocProvider(
        create: (context) => AuthenticationCubit(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        home: LoginPage());
  }
}
