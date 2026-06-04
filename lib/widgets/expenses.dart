import "package:flutter/material.dart";
import "package:tracker/widgets/chart/chart.dart";
import "package:tracker/widgets/expences_list/expenses_list.dart";
import "package:tracker/models/expense.dart";
import "package:tracker/widgets/new_expense.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter',
      amount: 20.5,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'cinema',
      amount: 20.5,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'travel',
      amount: 20.5,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'leisure',
      amount: 20.5,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];
  void _openAddExpenseOverlay() {
    //.....
    showModalBottomSheet(
      isScrollControlled: true, //the modal overlay use full available height
      context: context,
      builder: (ctx) => NewExpense(addExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // ScaffoldMessenger.of(
    //   context,
    // ).clearSnackBars(); // Clear any existing snack bars
    //making snuck bar to show the user that the expense is removed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Expense removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                _registeredExpenses.indexOf(expense),
                expense,
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = Center(child: Text('No expenses found.'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          //Tool bar with the add button
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
