import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseModel>> getExpenses();

  Future<void> addExpense(
    ExpenseModel expense,
  );
}