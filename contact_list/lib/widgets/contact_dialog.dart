import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ListAddedCallback = Function(String name, String phoneNumber);

class ContactDialog extends StatefulWidget {
  const ContactDialog({
    super.key,
    required this.onListAdded,
  });

  final ListAddedCallback onListAdded;

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String nameText = "";
  String phoneText = "";

  String _formatPhoneNumber(String text) {
    // Remove all non-digit characters
    final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');
    
    // Format as XXX-XXX-XXXX
    if (digitsOnly.length >= 10) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, 10)}';
    } else if (digitsOnly.length >= 6) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else if (digitsOnly.length >= 3) {
      return '${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    }
    return digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                nameText = value;
              });
            },
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Name (First and Last)"),
          ),
          TextField(
            onChanged: (value) {
              final formatted = _formatPhoneNumber(value);
              setState(() {
                phoneText = formatted;
                if (formatted != value) {
                  _phoneController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(offset: formatted.length),
                  );
                }
              });
            },
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 12, // XXX-XXX-XXXX
            decoration: const InputDecoration(
              hintText: "Phone Number",
              counterText: "",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameController,
          builder: (context, nameValue, child) {
            return ValueListenableBuilder<TextEditingValue>(
              valueListenable: _phoneController,
              builder: (context, phoneValue, child) {
                final isValid = nameValue.text.isNotEmpty && 
                              phoneValue.text.replaceAll(RegExp(r'[^\d]'), '').length == 10;
                return ElevatedButton(
                  key: const Key("OKButton"),
                  style: yesStyle,
                  onPressed: isValid
                      ? () {
                          setState(() {
                            widget.onListAdded(nameText, phoneText);
                            Navigator.pop(context);
                          });
                        }
                      : null,
                  child: const Text('OK'),
                );
              },
            );
          },
        ),
      ],
    );
  }
}