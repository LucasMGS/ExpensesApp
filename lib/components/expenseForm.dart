import 'package:expenses/components/adaptatives/adaptativeDatePicker.dart';
import 'package:expenses/components/adaptatives/adaptativeTextField.dart';
import 'package:expenses/components/adaptatives/adaptativeButton.dart';
import 'package:flutter/material.dart';

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
              AdaptativeTextField(
                controller: _descriptionController,
                onSubmit: (_) => _onSubmit(),
                label: 'Título',
              ),
              AdaptativeTextField(
                controller: _valueController,
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onSubmit: (_) => _onSubmit(),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Despesa',
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
