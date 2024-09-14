class Dog {
  Dog({required this.name});

  final String name;
  int count = 1;

  void encounter() {
    count++;
  }
}
