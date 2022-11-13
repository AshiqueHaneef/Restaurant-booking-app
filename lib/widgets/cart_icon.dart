import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/blocs/cart_cubit/cart_cubit.dart';

import '../screens/summery_page.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return Stack(children: [
      Center(
        child: GestureDetector(
          onTap: () {
            if (cartCubit.state.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderSummery()));
            } else {
              Fluttertoast.showToast(msg: "Your cart is empty");
            }
          },
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.grey,
            size: 32,
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: 15,
        child: CircleAvatar(
          backgroundColor: Colors.red,
          radius: 9,
          child: Center(
            child: Text(
              cartCubit.state.length.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 11),
            ),
          ),
        ),
      ),
    ]);
  }
}
