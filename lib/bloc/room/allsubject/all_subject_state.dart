import 'package:equatable/equatable.dart';
import 'package:meetingme/models/tasks/notes.dart';

class AllSubjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllSubjectsInitState extends AllSubjectsState {}

class AllSubjectsLoadingState extends AllSubjectsState {}

class SuccessFetchingAllSubjectsState extends AllSubjectsState {
  final Note notes;

  SuccessFetchingAllSubjectsState(this.notes);

  @override
  List<Object> get props => [notes];
}

class FailedFetchingAllSubjectsState extends AllSubjectsState {
  final String message;

  FailedFetchingAllSubjectsState({required this.message});

  @override
  List<Object> get props => [message];
}
