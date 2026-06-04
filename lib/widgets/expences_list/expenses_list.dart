import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/expences_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });
  //is put here to determine the
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  //its resopnsible for displaying
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      //Yes, index automatically knows where to start and finish because it is entirely managed by Flutter's ListView.builder.
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
