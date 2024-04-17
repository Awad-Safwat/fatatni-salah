part of 'main_cubit.dart';

@immutable
sealed class MainCubitState {}

final class MainCubitInitial extends MainCubitState {}

final class MainCubitLoading extends MainCubitState {}

final class MainCubitFailer extends MainCubitState {
  final String errorMasseg;

  MainCubitFailer({required this.errorMasseg});
}

final class MainCubitSucsses extends MainCubitState {}
