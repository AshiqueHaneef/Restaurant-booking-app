import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/restraunt_cubit/restraunt_cubit.dart';
import 'package:restaurant_app/models/category_dish.dart';
import 'package:restaurant_app/widgets/cart_icon.dart';
import 'package:restaurant_app/widgets/drawer.dart';
import 'package:restaurant_app/widgets/item_card.dart';

import '../models/table_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final restCubit = context.watch<RestrauntCubit>().state;
    if (restCubit is RestaurantLoading) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        )),
      );
    } else if (restCubit is RestaurantLoaded) {
      List<TableMenuList> tableList = restCubit.restList?.tableMenuList ?? [];
      return DefaultTabController(
        length: tableList.length,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              foregroundColor: Colors.grey,
              backgroundColor: Colors.white,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: CartIcon(),
                )
              ],
              bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicatorColor: Colors.red,
                  indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 5, color: Colors.red)),
                  tabs: tableList
                      .map(
                        (e) => Tab(
                          text: e.menuCategory,
                        ),
                      )
                      .toList()),
            ),
            drawer: const DrawerWidget(),
            body: TabBarView(
                children: tableList.map((e) {
              int listIndex = tableList.indexOf(e);
              List<CategoryDish> cateList =
                  tableList[listIndex].categoryDishes ?? [];
              return ListView.builder(
                itemCount: cateList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCard(
                    category: cateList[index],
                  );
                },
              );
            }).toList())),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("No Data Found"),
        ),
      );
    }
  }
}

List<int> intLis = [1, 2, 3, 4, 5];
