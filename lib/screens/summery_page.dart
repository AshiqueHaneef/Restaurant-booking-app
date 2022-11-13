import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/cart_cubit/cart_cubit.dart';
import 'package:restaurant_app/blocs/loading_cubit.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/widgets/cart_item_card.dart';
import 'package:restaurant_app/common/alignment_utils.dart';

class OrderSummery extends StatefulWidget {
  const OrderSummery({Key? key}) : super(key: key);

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final isLoading = context.watch<LoadingCubit>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.white,
        title: const Text("Order Summary"),
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade400, blurRadius: 2)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "${cartCubit.state.length} Dishes - ${cartCubit.totalQty} Items",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: cartCubit.state
                            .map((e) => CartItemCard(categoryDish: e))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "INR ${cartCubit.totalAmount}",
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                                color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLoading.state
          ? SizedBox(
              height: 60,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.green.shade900,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(context.screenSize().width / 25),
                    elevation: 2,
                    shadowColor: Colors.grey.shade400,
                  ),
                  onPressed: () async {
                    isLoading.changeState(true);
                    await Future.delayed(const Duration(seconds: 3), () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => const AlertDialog(
                                content: Text(
                                  "Order successfully placed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.green),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                      await Future.delayed(const Duration(seconds: 3));
                      isLoading.changeState(false);
                      cartCubit.resetQty();
                      cartCubit.clear();
                      navToHome();
                    });
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                  )),
            ),
    );
  }

  void navToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
