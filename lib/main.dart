import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/expenseList.dart';
import 'package:flutter/cupertino.dart';
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
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa 1',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'Despesa TESTE',
    //   value: 100,
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   id: '2',
    //   description: 'ultima despesa XD',
    //   value: 180.50,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function fn) {
      return Platform.isIOS
          ? GestureDetector(
              child: Icon(icon),
              onTap: fn,
            )
          : IconButton(
              icon: Icon(icon),
              onPressed: fn,
            );
    }

    final iconList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.format_list_bulleted;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.insert_chart;

    final actions = <Widget>[
      if (isLandScape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () => setState(() => _showChart = !_showChart),
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openExpenseFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text('Despesas pessoais'),
            actions: actions,
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_showChart || !isLandScape)
            Container(
              height: availableHeight * (isLandScape ? 0.70 : 0.30),
              child: Chart(_recentExpenses),
            ),
          if (!_showChart || !isLandScape)
            Container(
              height: availableHeight * (isLandScape ? 1 : 0.7),
              child: ExpenseList(_expenses, _removeExpense),
            ),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openExpenseFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
