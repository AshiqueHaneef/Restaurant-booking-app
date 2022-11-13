part of 'restraunt_cubit.dart';

abstract class RestrauntState extends Equatable {}

class RestrauntInitial extends RestrauntState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantLoading extends RestrauntState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RestaurantLoaded extends RestrauntState {
  final RestaurantData? restList;
  RestaurantLoaded(this.restList);



  @override
  // TODO: implement props
  List<Object?> get props => [restList?.restaurantId];
}

class RestaurantFailed extends RestrauntState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
