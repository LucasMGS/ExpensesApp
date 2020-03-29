import '../models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(String) onRemoveExpense;

  ExpenseList(this.expenses, this.onRemoveExpense);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: expenses.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'Nenhuma despesa cadastrada!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 50),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                final expense = expenses[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('R\$${expense.value}'),
                        ),
                      ),
                    ),
                    title: Text(expense.description,
                        style: Theme.of(context).textTheme.title),
                    subtitle: Text(DateFormat('d MMM y').format(expense.date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => onRemoveExpense(expense.id),
                    ),
                  ),
                );
              }),
    );
  }
}
