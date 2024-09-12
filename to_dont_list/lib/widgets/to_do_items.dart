import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/dog.dart';

typedef ToDoListChangedCallback = Function(Dog item, bool completed);
typedef ToDoListRemovedCallback = Function(Dog item);

class ToDoListItem extends StatelessWidget {
  ToDoListItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Dog item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed
        // color adjusted from black to black 54
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(item);
            }
          : null,
      //circle avatar can be replaced by button or icon, if onPressed is used for button call setState() (must be stateful widget)
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        //switched item.name with .abbrev
        child: Text(item.name),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
