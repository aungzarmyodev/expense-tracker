import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_event.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseBloc()..add(FetchExpenses()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title:  Text('Expense Tracker', style: TextStyle(color: AppColors.surface)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined, color: AppColors.surface),
            ),
          ],
        ),
        body: const HomeWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
