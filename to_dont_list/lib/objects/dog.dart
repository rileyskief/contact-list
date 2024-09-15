import 'package:flutter/material.dart';

enum CollarColor {
  red(Color.fromARGB(255, 222, 78, 68)),
  orange(Color.fromARGB(255, 247, 155, 17)),
  yellow(Color.fromARGB(255, 255, 235, 59)),
  green(Color.fromARGB(255, 15, 128, 19)),
  blue(Color.fromARGB(255, 38, 114, 177)),
  purple(Color.fromARGB(255, 200, 92, 219)),
  pink(Color.fromARGB(255, 240, 104, 149)),
  colorChoice(Color.fromARGB(255, 255, 255, 255));

  const CollarColor(this.color);
  final Color color;
}

class Dog {
  Dog({required this.name, required this.collar});

  final String name;
  final CollarColor collar;
  int count = 1;

  void encounter() {
    count++;
  }
}
