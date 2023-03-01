import 'package:flutter/material.dart';

import 'package:dhis2_demo_app/core/models/input_field.dart';

class TextInputFieldContainer extends StatefulWidget {
  const TextInputFieldContainer({
    super.key,
    required this.inputField,
    this.inputValue,
    this.onInputValueChange,
  });

  final InputField inputField;
  final Function? onInputValueChange;
  final String? inputValue;

  @override
  State<TextInputFieldContainer> createState() =>
      _TextInputFieldContainerState();
}

class _TextInputFieldContainerState extends State<TextInputFieldContainer> {
  TextEditingController? textController;
  String? _value;
  String? _lastInputValue = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.inputValue;
    });
    updateTextValue(value: widget.inputValue);
  }

  updateTextValue({String? value = ''}) {
    _value = value;
    setState(() {});
    textController = TextEditingController(text: value);
  }

  onValueChange(String value) {
    if (_lastInputValue != value) {
      _value = value;
      _lastInputValue = _value;
      setState(() {});
      widget.onInputValueChange!(value.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: widget.inputField.isReadOnly
            ? TextEditingController(
                text: widget.inputValue,
              )
            : textController,
        onChanged: (String value) => onValueChange(value),
        readOnly: widget.inputField.isReadOnly,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.white,
          labelText: widget.inputField.label,
        ),
      ),
    );
  }
}
