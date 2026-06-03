import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback? onAddExpense;

  const EmptyWidget({super.key, this.onAddExpense});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No Expenses Yet',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Start tracking your spending by adding your first expense.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onAddExpense != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAddExpense,
                icon: const Icon(Icons.add),
                label: const Text('Add Expense'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
