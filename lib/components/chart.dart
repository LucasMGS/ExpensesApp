import 'package:expenses/components/chartBar.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentExpense;

  Chart(this.recentExpense);

  List<Map<String, Object>> get _groupedExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      final firstLetter = DateFormat.E().format(weekDay)[0];

      double totalSum = 0.0;

      for (var i = 0; i < recentExpense.length; i++) {
        var sameDay = recentExpense[i].date.day == weekDay.day;
        var sameMonth = recentExpense[i].date.month == weekDay.month;
        var sameYear = recentExpense[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentExpense[i].value;
        }
      }

      return {
        'day': firstLetter,
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return _groupedExpenses.fold(0.0, (sum, exp) {
      return sum + exp['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    _groupedExpenses;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedExpenses.map((exp) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: exp['day'],
                value: exp['value'],
                percentage: _weekTotalValue == 0 ? 0 : (exp['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
