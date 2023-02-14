import 'package:equatable/equatable.dart';

class PaymentHistoryEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialEvent extends PaymentHistoryEvents {}

class FetchPaymentHistory extends PaymentHistoryEvents {}
