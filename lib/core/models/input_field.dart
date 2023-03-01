class InputField {
  String id;
  String valueType;
  String label;
  bool isReadOnly;

  InputField({
    required this.id,
    required this.label,
    required this.valueType,
    this.isReadOnly = false,
  });
}
