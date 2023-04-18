import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  List<String> values = [
    'Option1',
    'Option2',
  ];
  String selectedValue = 'Option1';
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Options')),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: [
            BasfDropDownInput(
              controller: TextEditingController(),
              values: const ['Option1', 'Option2', 'Option3'],
            ),
            RadioOptions(
              title: 'BASF Radio',
              selectedValue: selectedValue,
              labelGenerator: (o) => o,
              values: values,
              onSelected: (value) {
                setState(() => selectedValue = value);
              },
            ),
            const Text('CheckBox'),
            BasfCheckbox(value: selected, onChanged: change),
            BasfCheckbox(value: selected, text: 'Label', onChanged: change),
            BasfCheckbox(
              value: selected,
              text: 'Reversed Label',
              reverse: true,
              onChanged: change,
            ),
          ],
        ),
      ),
    );
  }

  void change(_) => setState(() => selected = !selected);
}
