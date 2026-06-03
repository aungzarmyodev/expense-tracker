import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';

abstract class ExpenseState {}

class LoadingState extends ExpenseState {}

class EmptyState extends ExpenseState {}

class SuccessState extends ExpenseState {
  final List<ExpenseModel> expenses;

  SuccessState(this.expenses);
}

class ErrorState extends ExpenseState {
  final String message;

  ErrorState(this.message);
}
