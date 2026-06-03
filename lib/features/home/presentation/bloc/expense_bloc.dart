import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_event.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository;

  ExpenseBloc({required this.repository}) : super(LoadingState()) {
    on<FetchExpenses>(_onFetchExpenses);
    on<AddExpense>(_onAddExpense);
  }

  Future<void> _onFetchExpenses(
    FetchExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    final expenses = await repository.getExpenses();

    if (expenses.isEmpty) {
      emit(EmptyState());
      return;
    }

    emit(SuccessState(expenses));
  }

  Future<void> _onAddExpense(
    AddExpense event,
    Emitter<ExpenseState> emit,
  ) async {
    await repository.addExpense(event.expense);

    add(FetchExpenses());
  }
}
