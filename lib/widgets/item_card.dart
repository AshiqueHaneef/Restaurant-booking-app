import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/cart_cubit/cart_cubit.dart';
import 'package:restaurant_app/common/alignment_utils.dart';
import 'package:restaurant_app/models/category_dish.dart';

class ItemCard extends StatefulWidget {
  final CategoryDish category;
  const ItemCard({Key? key, required this.category}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late CategoryDish category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 2))),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      category.dishType == 1
                          ? Image.asset(
                              "assets/Non_veg_symbol.png",
                              width: 25,
                            )
                          : Image.asset(
                              "assets/Veg_symbol.png",
                              width: 25,
                            )
                    ],
                  )),
              Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.dishName ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "INR ${category.dishPrice}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${category.dishCalories} Calories",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        category.dishDescription ?? "",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width: context.screenSize().width / 2.9,
                        height: 38,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  cartCubit.removeItem(category);
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                            Text(
                              category.qty.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {
                                  cartCubit.addItem(category);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (category.addonCat!.isNotEmpty)
                        const Text(
                          "Customization Available",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image from api doesn't working
                        Image.network(
                          // category.dishImage ?? "",
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvHxvSc4InG-dJWmC7NA_rgnUW_sm0ew7mVg&usqp=CAU",
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
