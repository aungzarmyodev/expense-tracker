import 'package:expense_tracker_app/core/theme/app_colors.dart';
import 'package:expense_tracker_app/features/add_expense/presentation/pages/add_new_expense.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_event.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) {
        final repository = blocContext.read<ExpenseRepository>();

        return ExpenseBloc(repository: repository)..add(FetchExpenses());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            'Expense Tracker',
            style: TextStyle(color: AppColors.surface),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.settings_outlined, color: AppColors.surface),
            ),
          ],
        ),
        body: const HomeWidget(),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: AppColors.secondary,
              onPressed: () {
                final bloc = context.read<ExpenseBloc>();

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return BlocProvider.value(
                      value: bloc,
                      child: const AddNewExpense(),
                    );
                  },
                );
              },
              child: const Icon(Icons.add, color: AppColors.surface),
            );
          },
        ),
      ),
    );
  }
}
