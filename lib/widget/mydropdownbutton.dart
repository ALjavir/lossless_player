import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  final List<String> items;
  final String name;
  final Function(String?) selctvalue;

  const MyDropDownButton({
    super.key,
    required this.items,
    required this.name,
    required this.selctvalue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyDropDownButtonState createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: DropdownButtonHideUnderline(
        child: Column(
          children: [
            //Text(widget.name),
            DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                textAlign: TextAlign.center,
                selectedItem ?? widget.name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              items: widget.items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
              value: selectedItem,
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                  widget.selctvalue(value);
                });
              },
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_forward_ios_sharp,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.white,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.black,
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 16, right: 8),
                height: 40,
                width: 100,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
