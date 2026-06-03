import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_event.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_state.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

final mockExpenseModel = ExpenseModel(
  id: 1,
  category: 'Food',
  amount: 50,
  date: DateTime.now(),
);

void main() {
  late ExpenseBloc bloc;
  late MockExpenseRepository repository;

  setUp(() {
    repository = MockExpenseRepository();
    bloc = ExpenseBloc(repository: repository);
  });

  group('ExpenseBloc Test', () {
    blocTest<ExpenseBloc, ExpenseState>(
      'emits [EmptyState] when repository returns empty list',
      build: () {
        when(() => repository.getExpenses()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchExpenses()),
      expect: () => [isA<EmptyState>()],
    );

    blocTest<ExpenseBloc, ExpenseState>(
      'emits [SuccessState] when repository returns data',
      build: () {
        when(
          () => repository.getExpenses(),
        ).thenAnswer((_) async => [mockExpenseModel]);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchExpenses()),
      expect: () => [isA<SuccessState>()],
    );
  });
}
