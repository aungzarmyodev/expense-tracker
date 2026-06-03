import 'package:expense_tracker_app/core/database/database_helper.dart';
import 'package:expense_tracker_app/features/home/data/datasource/expense_datasource_impl.dart';
import 'package:expense_tracker_app/features/home/data/repository/expense_repository_impl.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:expense_tracker_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseHelper.database;

  final repository = ExpenseRepositoryImpl(
    localDataSource: ExpenseLocalDataSourceImpl(database: db),
  );

  runApp(
    RepositoryProvider<ExpenseRepository>.value(
      value: repository,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Homescreen(),
    );
  }
}
