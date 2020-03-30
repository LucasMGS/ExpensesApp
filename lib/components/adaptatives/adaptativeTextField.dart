import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmit;
  final String label;
  final TextInputType textInputType;

  AdaptativeTextField({ this.controller, this.onSubmit, this.textInputType, this.label });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(
            bottom: 10
          ),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: TextInputType.text,
            onSubmitted: onSubmit,
            placeholder: label,
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12,
            ),
          ),
        )
        : TextField(
            controller: controller,
            keyboardType: textInputType,
            onSubmitted: onSubmit,
            decoration: InputDecoration(labelText: label),
          );
  }
}
