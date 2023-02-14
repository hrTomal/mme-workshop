import 'package:equatable/equatable.dart';

class AllSubjectEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends AllSubjectEvents {}

class FetchSubjectsEvent extends AllSubjectEvents {}
