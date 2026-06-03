import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';

import '../../domain/repository/expense_repository.dart';
import '../datasource/expense_datasource.dart';


class ExpenseRepositoryImpl
    implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<ExpenseModel>> getExpenses() {
    return localDataSource.getExpenses();
  }

  @override
  Future<void> addExpense(
    ExpenseModel expense,
  ) {
    return localDataSource.addExpense(expense);
  }
}