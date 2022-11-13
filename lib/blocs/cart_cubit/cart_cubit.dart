import 'package:bloc/bloc.dart';
import 'package:restaurant_app/models/category_dish.dart';

class CartCubit extends Cubit<List<CategoryDish>> {
  CartCubit() : super([]);

  void addItem(CategoryDish categoryDish) {
    var newState = List<CategoryDish>.from(state);
    if (state.contains(categoryDish)) {
      int index = newState.indexOf(categoryDish);
      int qty = categoryDish.qty + 1;
      newState[index].qty = qty;
    } else {
      int qty = categoryDish.qty + 1;
      categoryDish.qty = qty;
      newState.add(categoryDish);
    }
    emit(newState);
  }

  void removeItem(CategoryDish categoryDish) {
    final newState = List<CategoryDish>.from(state);
    int index = newState.indexOf(categoryDish);
    if (newState.contains(categoryDish)) {
      if (categoryDish.qty == 1) {
        newState[index].qty = 0;
        newState.remove(categoryDish);
      } else {
        int qty = categoryDish.qty - 1;
        newState[index].qty = qty;
      }
    }
    emit(newState);
  }

  void resetQty() {
    state.forEach((element) {
      element.qty = 0;
    });
  }

  void clear() {
    emit([]);
  }

  double get totalAmount => state.fold(0, (p, e) => p + e.itemTotal);

  int get totalQty => state.fold(0, (p, e) => p + e.qty);
}
