import 'package:expense_tracker_app/features/home/data/datasource/expense_datasource.dart';
import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Database database;

  ExpenseLocalDataSourceImpl({required this.database});

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final result = await database.query('expenses', orderBy: 'date DESC');

    return result.map(ExpenseModel.fromMap).toList();
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await database.insert('expenses', expense.toMap());
  }
}
