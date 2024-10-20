// Data class to keep the string and have an abbreviation function

class Person {
  const Person({required this.name, required this.phoneNumber});

  final String name;
  final int phoneNumber;

  String abbrev() {
    return name.substring(0, 1);
  }
}
