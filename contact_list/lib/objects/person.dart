class Person {
  Person({required this.name, required this.phoneNumber, required this.favorite});

  final String name;
  final String phoneNumber;
  bool favorite;

  String abbrev() {
    return name.split(' ').map((part) => part[0]).join('').toUpperCase();
  }
}