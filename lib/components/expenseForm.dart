import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(String, double, DateTime) addExpense;

  ExpenseForm(this.addExpense);

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate;

  _onSubmit() {
    final description = _descriptionController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (description.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.addExpense(description, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _descriptionController,
                onSubmitted: (_) => _onSubmit(),
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _valueController,
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmit(),
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                    ),
                    FlatButton(
                        onPressed: _showDatePicker,
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Selecionar data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    elevation: 4,
                    child: Text('Nova Despesa'),
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _onSubmit,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
