import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/person.dart';

typedef ListChangedCallback = Function(Person item, bool completed);
typedef ListRemovedCallback = Function(Person item);

class ListPerson extends StatefulWidget {
  ListPerson(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeletePerson})
      : super(key: ObjectKey(item));

  final Person item;
  final bool completed;
  bool favorite = false;

  final ListChangedCallback onListChanged;
  final ListRemovedCallback onDeletePerson;

  @override
  State<ListPerson> createState() => _ListPersonState();
}

  class _ListPersonState extends State<ListPerson> {
    Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed //
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
        widget.onListChanged(widget.item, widget.completed);
      },
      onLongPress: widget.completed
          ? () {
              widget.onDeletePerson(widget.item);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(widget.item.abbrev()),
      ),
      title: Text(
        widget.item.name,
  
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        widget.item.phoneNumber.toString(),

        style: _getTextStyle(context),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            foregroundColor: widget.item.favorite ? Colors.yellow : Colors.grey,
            onPressed: ()=> setState(() => widget.item.favorite = !widget.item.favorite),
            child: const Icon(Icons.star),
          )

        ],),
    );
  }
}
  