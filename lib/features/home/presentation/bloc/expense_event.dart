import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';

abstract class ExpenseEvent {}

class FetchExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final ExpenseModel expense;

  AddExpense(this.expense);
}