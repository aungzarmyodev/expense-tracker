import 'package:expense_tracker_app/core/security/encryption_helper.dart';
import 'package:expense_tracker_app/features/home/data/datasource/expense_datasource.dart';
import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Database database;

  ExpenseLocalDataSourceImpl({required this.database});

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final List<Map<String, dynamic>> result = await database.query(
      'expenses',
      orderBy: 'date DESC',
    );

    print('Raw data from DB: $result');

    return result.map((item) {
      final category = EncryptionHelper.decryptText(item['category'] ?? '');

      final decryptedAmount = EncryptionHelper.decryptText(
        item['amount'] ?? '',
      );

      return ExpenseModel(
        category: category,
        amount: double.tryParse(decryptedAmount) ?? 0.0,
        date: DateTime.parse(item['date']),
      );
    }).toList();
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await database.insert('expenses', {
      'category': EncryptionHelper.encryptText(expense.category),
      'amount': EncryptionHelper.encryptText(expense.amount.toString()),
      'date': expense.date.toIso8601String(),
    });
  }
}
