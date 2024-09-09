// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name});

  final String name;

  String abbrev() {
    //adjusted to spit out just one character
    return name.substring(0, 1);
  }
}
