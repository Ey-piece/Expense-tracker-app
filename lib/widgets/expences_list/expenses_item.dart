import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  //Expense is the (class)list the we created in the model
  final Expense expense;
  //we have just given it what to display
  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 4),
            Row(
              children: [
                //12.3434=>12.34
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                //this row is included because it has two elements
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
