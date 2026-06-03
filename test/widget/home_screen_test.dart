import 'package:expense_tracker_app/features/home/presentation/pages/home_screen.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
import 'package:expense_tracker_app/core/language/language_service.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_bloc.dart';
import 'package:expense_tracker_app/features/home/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}
class MockExpenseBloc extends Mock implements ExpenseBloc {}

void main() {
  late MockExpenseRepository repository;
  late MockExpenseBloc bloc;

  setUp(() {
    repository = MockExpenseRepository();
    bloc = MockExpenseBloc();
  });

  Widget createScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageService()..loadLanguage('en'),
        ),
        RepositoryProvider<ExpenseRepository>.value(value: repository),
        BlocProvider<ExpenseBloc>.value(value: bloc),
      ],
      child: const MaterialApp(home: Homescreen()),
    );
  }

  group('HomeScreen UI Tests', () {

    setUp(() {
      when(() => repository.getExpenses())
          .thenAnswer((_) async => []);

      when(() => bloc.state).thenReturn(EmptyState());
      when(() => bloc.stream)
          .thenAnswer((_) => const Stream.empty());
    });

    testWidgets('shows app bar title and FAB', (tester) async {
      await tester.pumpWidget(createScreen());
      await tester.pumpAndSettle();

      expect(find.text('Expense Tracker'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('opens language dialog', (tester) async {
      await tester.pumpWidget(createScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      expect(find.text('English'), findsOneWidget);
      expect(find.text('မြန်မာ'), findsOneWidget);
    });
  });
}