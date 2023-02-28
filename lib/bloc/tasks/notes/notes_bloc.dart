import 'package:bloc/bloc.dart';
import 'package:meetingme/bloc/tasks/notes/notes_event.dart';
import 'package:meetingme/bloc/tasks/notes/notes_state.dart';
import 'package:meetingme/models/tasks/notes.dart';
import 'package:meetingme/services/tasks_data_service.dart';

class NotesBloc extends Bloc<NotesEvents, NotesStates> {
  TasksService tasksService;

  NotesBloc(NotesStates initialState, this.tasksService) : super(initialState) {
    on<NotesEvents>((event, emit) async {
      if (event is InitialEvent) {
        emit(NotesLoadingState());
        // Note notes = await tasksService.getRoomNotes(event.roomId);
        // emit(SuccessFetchingNotesState(notes));
      } else if (event is FetchNotesEvent) {
        Note notes = await tasksService.getRoomNotes(event.roomId);
        emit(SuccessFetchingNotesState(notes));
      }
    });
  }
}
