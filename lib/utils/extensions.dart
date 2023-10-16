// This extension is used for convert string to int and string to double etc.
extension NumberParsing on String {
  /// Convert string to int.
  int parseInt() {
    return int.parse(this);
  }

  /// Convert string to double.
  double parseDouble() {
    return double.parse(this);
  }

  /// Split space from string.
  List splitSpaceString() {
    return split(' ');
  }

  /// Capitalize first character of the string.
  String capitalizeFirst() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
