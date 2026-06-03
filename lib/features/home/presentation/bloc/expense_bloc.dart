import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(LoadingState()) {
    on<FetchExpenses>(_onFetchExpenses);
  }

  Future<void> _onFetchExpenses(
    FetchExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    try {

       emit(LoadingState());
      await Future.delayed(const Duration(seconds: 1));

      final expenses = [
        ExpenseModel(
          id: '1',
          category: 'Groceries',
          amount: 50.0,
          date: DateTime.now(),
        ),
        ExpenseModel(
          id: '2',
          category: 'Rent',
          amount: 1000.0,
          date: DateTime.now(),
        ),
        ExpenseModel(
          id: '3',
          category: 'Utilities',
          amount: 100.0,
          date: DateTime.now(),
        ),
      ];

      if (expenses.isEmpty) {
        emit(EmptyState());
      } else {
        emit(SuccessState(expenses));
      }
    } catch (_) {
      emit(ErrorState('Failed to load expenses.'));
    }
  }
}