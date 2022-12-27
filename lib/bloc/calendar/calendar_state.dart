import 'package:equatable/equatable.dart';

class CalendarStates extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CalendarInitState extends CalendarStates {}

class CalendarLoadingState extends CalendarStates {}

class CalendarLoadedState extends CalendarStates {}
