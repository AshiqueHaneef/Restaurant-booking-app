import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/cart_cubit/cart_cubit.dart';
import 'package:restaurant_app/common/alignment_utils.dart';
import 'package:restaurant_app/models/category_dish.dart';

class CartItemCard extends StatelessWidget {
  final CategoryDish categoryDish;
  const CartItemCard({Key? key, required this.categoryDish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return Container(
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    categoryDish.dishType == 1
                        ? Image.asset(
                            "assets/Non_veg_symbol.png",
                            width: 25,
                          )
                        : Image.asset(
                            "assets/Veg_symbol.png",
                            width: 25,
                          )
                  ],
                ),
              )),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryDish.dishName ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "INR ${categoryDish.dishPrice}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${categoryDish.dishCalories} Calories",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              width: context.screenSize().width / 4,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        cartCubit.removeItem(categoryDish);
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      )),
                  Text(
                    categoryDish.qty.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        cartCubit.addItem(categoryDish);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "INR ${categoryDish.itemTotal}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
