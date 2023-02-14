import 'package:equatable/equatable.dart';

import '../../models/user.dart';

class PaymentHistoryStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaymentHistoryLoadingState extends PaymentHistoryStates {}

class SuccessFetchingState extends PaymentHistoryStates {
  // final RestaurantModel restaurantModel;

  // RestaurantSuccessState({@required this.restaurantModel});

  // @override
  // // TODO: implement props
  // List<Object> get props => [restaurantModel];
}

class FailedFetchingState extends PaymentHistoryStates {
  // final String message;

  // RestaurantFailState({@required this.message});

  // @override
  // // TODO: implement props
  // List<Object> get props => [message];
}
