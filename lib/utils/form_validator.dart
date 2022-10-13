String? simpleTextValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Необходимо заполнить поле";
  }
  return null;
}

String? emailTextValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Необходимо заполнить поле";
  }
  final bool format = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(value);
  if (!format) {
    return "Необходио указать email";
  }
  return null;
}
