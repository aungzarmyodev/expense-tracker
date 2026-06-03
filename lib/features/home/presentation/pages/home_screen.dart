import 'package:expense_tracker_app/core/language/language_service.dart';
import 'package:expense_tracker_app/core/theme/app_colors.dart';
import 'package:expense_tracker_app/features/add_expense/presentation/pages/add_new_expense.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_event.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/home_widget.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          title: Consumer<LanguageService>(
            builder: (context, lang, _) {
              return Text(
                lang.text('app_title'),
                style: const TextStyle(color: AppColors.surface),
              );
            },
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: IconButton(
                icon: Icon(Icons.settings_outlined, color: AppColors.surface),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const LanguageDialog(),
                  );
                },
              ),
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
