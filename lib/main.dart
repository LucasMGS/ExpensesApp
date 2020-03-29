import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/expenseList.dart';
import 'package:flutter/material.dart';
import './components/expenseForm.dart';
import 'models/expense.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> _expenses = [
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa TESTE',
      value: 100,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      description: 'Despesa 1',
      value: 180.50,
      date: DateTime.now(),
    ),
  ];

  List<Expense> get _recentExpenses {
    return _expenses.where((exp) {
      return exp.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addExpense(String description, double value, DateTime date) {
    setState(() {
      _expenses.add(new Expense(
        id: Random().nextDouble().toString(),
        description: description,
        value: value,
        date: date,
      ));
    });

    Navigator.of(context).pop();
  }

  _removeExpense(String id) {
    setState(() {
      _expenses.removeWhere((expense) => expense.id == id);
    });
  }

  _openExpenseFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ExpenseForm(_addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openExpenseFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentExpenses),
            ExpenseList(_expenses, _removeExpense),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openExpenseFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
