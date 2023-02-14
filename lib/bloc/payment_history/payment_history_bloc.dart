import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetingme/bloc/payment_history/payment_history_event.dart';
import 'package:meetingme/bloc/payment_history/payment_history_state.dart';

// class PaymentHistoryBloc
//     extends Bloc<PaymentHistoryEvents, PaymentHistoryStates> {
//   //     RestaurantRepository restaurantRepository;

//   // RestaurantBloc({@required this.restaurantRepository}) : super(RestaurantLoadingState());

//   // RestaurantState get initialState => RestaurantLoadingState();

//   // @override
//   // Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
//   //   if (event is FetchRestaurantEvent) {
//   //     yield RestaurantLoadingState();
//   //     try {
//   //       RestaurantModel restaurantModel = await restaurantRepository.getRestaurantData();
//   //       print("Bloc Success");
//   //       yield RestaurantSuccessState(restaurantModel: restaurantModel);
//   //     } catch (e) {
//   //       print(  await restaurantRepository.getRestaurantData());
//   //       yield RestaurantFailState(message: "???");
//   //     }
//   //   }
//   // }
// }
