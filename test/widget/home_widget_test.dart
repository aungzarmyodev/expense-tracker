import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app/features/home/data/model/expense_model.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/home_widget.dart';
import 'package:expense_tracker_app/core/language/language_service.dart';
import 'package:expense_tracker_app/features/home/domain/repository/expense_repository.dart';
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

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageService()..loadLanguage('en'),
        ),
        RepositoryProvider<ExpenseRepository>.value(value: repository),
        BlocProvider<ExpenseBloc>.value(value: bloc),
      ],
      child: const MaterialApp(
        home: Scaffold(body: HomeWidget()),
      ),
    );
  }

  group('HomeWidget UI Tests', () {

    testWidgets('shows loading indicator', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable([LoadingState()]),
        initialState: LoadingState(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows empty widget', (tester) async {
      when(() => bloc.state).thenReturn(EmptyState());
      when(() => bloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No Expenses Yet'), findsOneWidget);
    });

    testWidgets('shows item list widget', (tester) async {
      final fakeExpenses = [
        ExpenseModel(
          id: 1,
          category: 'Food',
          amount: 500,
          date: DateTime.now(),
        ),
      ];

      whenListen(
        bloc,
        Stream.fromIterable([
          SuccessState(expenses: fakeExpenses),
        ]),
        initialState: SuccessState(expenses: const []),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Food'), findsOneWidget);
      expect(find.textContaining('500'), findsOneWidget);
    });
  });
}