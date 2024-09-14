import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';

typedef ToDoListChangedCallback = Function(Dog dog, bool completed);
typedef ToDoListRemovedCallback = Function(Dog dog);

class DogListItem extends StatefulWidget {
  DogListItem(
      {required this.dog,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(dog));

  final Dog dog;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<DogListItem> createState() => _DogListItemState();
}

class _DogListItemState extends State<DogListItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed
        // color adjusted from black to black 54
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onListChanged(widget.dog, widget.completed);
      },
      onLongPress: widget.completed
          ? () {
              widget.onDeleteItem(widget.dog);
            }
          : null,
      //circle avatar can be replaced by button or icon, if onPressed is used for button call setState() (must be stateful widget)
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
              255, 76, 244, 54), //user input determine collar color
        ),
        onPressed: () {
          setState(() {
            widget.dog.encounter();
          });
        },
        child: Text(widget.dog.count.toString()),
      ),
      title: Text(
        widget.dog.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
