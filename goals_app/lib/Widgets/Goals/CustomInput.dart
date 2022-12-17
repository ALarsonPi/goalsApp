import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final String? label;
  final InputBorder? inputBorder;
  final TextEditingController? controller;
  final int? minlines;
  const CustomInput({
    Key? key,
    this.onChanged,
    this.hint,
    this.inputBorder,
    this.controller,
    this.minlines,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: 3,
        minLines: (minlines == null) ? 1 : minlines,
        decoration: InputDecoration(
          hintText: (hint == null) ? "" : hint,
          labelText: (label == null) ? "" : label,
          border: inputBorder,
        ),
      ),
    );
  }
}
