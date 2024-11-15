// Data class to keep the string and have an abbreviation function

class Person {
  Person({required this.name, required this.phoneNumber, required this.favorite});

  final String name;
  final int phoneNumber;
  bool favorite;

  String abbrev() {
    return name.substring(0, 1);
  }
}
