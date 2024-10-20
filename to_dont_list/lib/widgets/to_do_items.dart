import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/person.dart';

typedef ToDoListChangedCallback = Function(Person item, bool completed);
typedef ToDoListRemovedCallback = Function(Person item);

class ToDoListPerson extends StatelessWidget {
  ToDoListPerson(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeletePerson})
      : super(key: ObjectKey(item));

  final Person item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeletePerson;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
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
              onDeletePerson(item);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(item.abbrev()),
      ),
      title: Text(
        item.name,
  
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        item.phoneNumber.toString(),

        style: _getTextStyle(context),
      ),
    );
  }
}
