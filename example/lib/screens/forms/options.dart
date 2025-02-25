import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  List<String> values = ['Option1', 'Option2'];
  String selectedValue = 'Option1';
  bool selected = true;
  double sliderValue = 0.5;

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
              labelText: 'BASF Dropdown',
              controller: TextEditingController(),
              values: const ['Option1', 'Option2', 'Option3'],
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledWidget(
                    labelText: 'Text Field',
                    child: BasfTextField(controller: TextEditingController()),
                  ),
                ),
                BasfDropDownInput(
                  labelText: 'BASF Dropdown',
                  controller: TextEditingController(),
                  maxWidth: 120,
                  values: const ['Long Text in dropdown', 'Option2', 'Option3'],
                ),
              ].joinWithSeparator(HorizontalSpacer.normal()),
            ),
            RadioOptions(
              title: 'BASF Radio',
              selectedValue: selectedValue,
              labelGenerator: (o) => o,
              values: values,
              onSelected: (value) => setState(() => selectedValue = value),
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
            const Center(child: CircularProgressIndicator(value: 0.4)),
            const LinearProgressIndicator(value: 0.2),
            Slider(
              value: sliderValue,
              onChanged: (val) => setState(() => sliderValue = val),
            ),
          ].joinWithSeparator(const VerticalSpacer(height: 20)),
        ),
      ),
    );
  }

  void change(_) => setState(() => selected = !selected);
}
