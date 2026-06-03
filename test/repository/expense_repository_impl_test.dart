import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expense_tracker_app/features/home/data/repository/expense_repository_impl.dart';
import 'package:expense_tracker_app/features/home/data/datasource/expense_datasource.dart';
import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';

class MockDataSource extends Mock implements ExpenseLocalDataSource {}

void main() {
  late ExpenseRepositoryImpl repository;
  late MockDataSource dataSource;

  setUp(() {
    dataSource = MockDataSource();
    repository = ExpenseRepositoryImpl(localDataSource: dataSource);
  });

  group('ExpenseRepositoryImpl', () {

    test('should return list of expenses', () async {
      final mockData = [
        ExpenseModel(
          category: 'Food',
          amount: 100,
          date: DateTime.now(),
        )
      ];

      when(() => dataSource.getExpenses())
          .thenAnswer((_) async => mockData);

      final result = await repository.getExpenses();

      expect(result.length, 1);
      expect(result.first.category, 'Food');
    });

    test('should return empty list when no data', () async {
      when(() => dataSource.getExpenses())
          .thenAnswer((_) async => []);

      final result = await repository.getExpenses();

      expect(result, []);
    });

  });
}