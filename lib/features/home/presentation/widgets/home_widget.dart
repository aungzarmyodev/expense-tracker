import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_state.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/item_list.dart';
import 'package:expense_tracker_app/features/share/common_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'empty_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  void _fetchExpenses() {
    // TODO: Implement the logic to fetch expenses from the database or API
  }

  void _addExpense() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EmptyState) {
          return EmptyWidget(onAddExpense: _addExpense);
        }

        if (state is SuccessState) {
          return ListView.builder(
            itemCount: state.expenses.length,
            itemBuilder: (context, index) {
              final expense = state.expenses[index];
              return ItemList(expense: expense);
            },
          );
        }

        if (state is ErrorState) {
          return CommonErrorScreen(
            message: state.message,
            onRetry: _fetchExpenses,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
