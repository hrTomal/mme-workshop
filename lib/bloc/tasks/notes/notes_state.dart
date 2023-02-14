import 'package:equatable/equatable.dart';
import 'package:meetingme/models/tasks/notes.dart';

class NotesStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotesInitState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class SuccessFetchingNotesState extends NotesStates {
  final Note notes;

  SuccessFetchingNotesState(this.notes);

  @override
  List<Object> get props => [notes];
}

class FailedFetchingNotesState extends NotesStates {
  final String message;

  FailedFetchingNotesState({required this.message});

  @override
  List<Object> get props => [message];
}
