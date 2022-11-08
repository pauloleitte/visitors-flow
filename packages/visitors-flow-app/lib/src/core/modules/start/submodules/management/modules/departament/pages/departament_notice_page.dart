import 'package:flutter/material.dart';
import 'package:visitors_flow_app/src/shared/utils/mutiselect-params.dart';

class DepartamentNoticePage<T> extends StatefulWidget {
  final MultiSelectParams params;
  const DepartamentNoticePage({
    required this.params,
    Key? key,
  }) : super(key: key);

  @override
  State<DepartamentNoticePage> createState() => _DepartamentNoticePageState();
}

class _DepartamentNoticePageState extends State<DepartamentNoticePage> {
  // this variable holds the selected items
  final List<dynamic> _selectedItems = [];
  final List<dynamic> _values = [];

  @override
  void initState() {
    addInitalValueInSelectedItems();
    super.initState();
  }

  void addInitalValueInSelectedItems() {
    setState(() {
      for (var element in widget.params.initialValue) {
        if (!_selectedItems.contains(element.sId)) {
          _selectedItems.add(element.sId);
        }
        if (!_values.contains(element)) {
          _values.add(element);
        }
      }
    });
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(dynamic itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _values.add(itemValue);
        _selectedItems.add(itemValue.sId);
      } else {
        _values.removeWhere((model) => model.sId == itemValue.sId);
        _selectedItems.remove(itemValue.sId);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.title),
        leading: IconButton(
          onPressed: _cancel,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: widget.params.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item.sId),
                    title: Text(item.name),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
