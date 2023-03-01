import 'package:dhis2_demo_app/core/models/input_field.dart';
import 'package:flutter/material.dart';

class PasswordInputFieldContainer extends StatefulWidget {
  const PasswordInputFieldContainer({
    super.key,
    required this.inputField,
    this.inputValue,
    this.onInputValueChange,
  });

  final InputField inputField;
  final Function? onInputValueChange;
  final String? inputValue;

  @override
  State<PasswordInputFieldContainer> createState() =>
      _PasswordInputFieldContainerState();
}

class _PasswordInputFieldContainerState
    extends State<PasswordInputFieldContainer> {
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
        controller: textController,
        obscureText: true,
        obscuringCharacter: '*',
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
