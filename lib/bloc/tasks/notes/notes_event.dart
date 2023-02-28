import 'package:equatable/equatable.dart';

class NotesEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends NotesEvents {}

class FetchNotesEvent extends NotesEvents {
  final String roomId;

  FetchNotesEvent({required this.roomId});
}
