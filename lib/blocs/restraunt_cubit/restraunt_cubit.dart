import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/repositories/repository.dart';
import 'package:restaurant_app/models/restaurant.dart';

part 'restraunt_state.dart';

class RestrauntCubit extends Cubit<RestrauntState> {
  RestrauntCubit() : super(RestrauntInitial());

  Future<void> getRestaurant() async {
    try {
      emit(RestaurantLoading());
      final data = await Repositories.fetchData();
      emit(RestaurantLoaded(data));
    } catch (e) {
      emit(RestaurantFailed());
    }
  }
}
