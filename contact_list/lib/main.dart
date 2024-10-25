// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/person.dart';
import 'package:to_dont_list/widgets/contact_items.dart';
import 'package:to_dont_list/widgets/contact_dialog.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final List<Person> items = [const Person(name: "Riley Skief", phoneNumber: 6187919512)];
  
  final _itemSet = <Person>{};

  void _handleListChanged(Person item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeletePerson(Person item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewPerson(String itemText, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Person item = Person(name: textController.text, phoneNumber: TextField.noMaxLength);
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return ListPerson(
              item: item,
              completed: _itemSet.contains(item),
              onListChanged: _handleListChanged,
              onDeletePerson: _handleDeletePerson,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ContactDialog(onListAdded: _handleNewPerson);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Contacts',
    home: ContactList(),
  ));
}
