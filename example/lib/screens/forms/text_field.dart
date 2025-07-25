import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  late final _enabledController = TextEditingController();
  late final _scanFieldController = TextEditingController();
  late final _disabledController = TextEditingController();
  late final _errorController = TextEditingController();
  late final _obscureController = TextEditingController(text: 'obscured');
  late final _iconsController = TextEditingController();

  final ValueNotifier<bool> saveTriggerNotifier = ValueNotifier(false);

  final textFieldData = TextFieldData(
    labelText: 'Persisted from TextFieldData',
    controller: TextEditingController(),
    validator: (value) {
      if (value.isNullOrEmpty) return 'Please enter some numbers';
      return null;
    },
    inputFormatters: InputFormatter.onlyDigits,
    autovalidateMode: AutovalidateMode.always,
    keyboardType: TextInputType.emailAddress,
    textCapitalization: TextCapitalization.words,
  );

  @override
  void dispose() {
    _enabledController.dispose();
    _disabledController.dispose();
    _errorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BASF Text Fields')),
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: [
            BasfTextField(
              decoration: const InputDecoration(hintText: 'Enabled'),
              controller: _enabledController,
            ),
            BasfTextField(
              decoration: const InputDecoration(hintText: 'Scanned'),
              controller: _scanFieldController,
              onScanPressed: () {
                _enabledController.text = 'Scan button pressed';
              },
            ),
            BasfTextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.ac_unit),
                hintText: 'Max 4 characters',
              ),
              validator: (value) {
                if ((value?.length ?? 0) > 4) return 'Max 4 characters';
                return null;
              },
              controller: _errorController,
            ),
            BasfTextField(
              enabled: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.warning),
                hintText: 'Always error and disabled hint',
              ),
              validator: (value) => '',
              controller: _errorController,
            ),
            BasfTextField(
              enabled: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.warning),
                hintText: 'disabled hint',
              ),
              controller: TextEditingController(),
            ),
            BasfTextField(
              enabled: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.warning),
                hintText: 'disabled filled',
              ),
              controller: TextEditingController(text: 'disabled filled'),
            ),
            PersistedTextField(
              persistenceId: 'uniqueId',
              saveTriggerNotifier: saveTriggerNotifier,
              controller: TextEditingController(),
              onEditingComplete: () {
                saveTriggerNotifier.value = !saveTriggerNotifier.value;
              },
              decoration: const InputDecoration(hintText: 'Persistent input'),
            ),
            PersistedTextField.fromTextFieldData(
              textFieldData: textFieldData,
              saveTriggerNotifier: saveTriggerNotifier,
            ),
            BasfOutlinedButton(
              text: 'Save persistent fields',
              onPressed: () =>
                  saveTriggerNotifier.value = !saveTriggerNotifier.value,
            ),
            BasfTextField.fromTextFieldData(
              textFieldData: textFieldData,
              labelText: 'BasfTextField from TextFieldData',
              controller: TextEditingController(),
            ),
            BasfTextField(
              decoration: const InputDecoration(labelText: 'Obscured'),
              obscureText: true,
              controller: _obscureController,
            ),
            BasfTextField(
              controller: _iconsController,
              decoration: InputDecoration(
                hintText: 'Icons',
                prefixIcon: const Icon(Icons.person),
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: _iconsController.clear,
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BasfTextField(
                    controller: TextEditingController(),
                    validator: (text) {
                      if (text?.isEmpty ?? true) return 'Must not be empty';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                BasfDropDownInput(
                  controller: TextEditingController(text: 'PC'),
                  values: const ['PC', 'PK', 'TM'],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'Dropdown examples',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Column(
                  children: [
                    BasfDropDownInput(
                      controller: TextEditingController(text: 'PC'),
                      isLoading: true,
                      values: const ['PC'],
                    ),
                    const SizedBox(height: 10),
                    BasfDropDownInput(
                      controller: TextEditingController(text: 'PK'),
                      isMandatory: true,
                      unselectedText: 'Select now!',
                      // initialValue: 'PK',
                      values: const ['PC', 'PK'],
                    ),
                    const SizedBox(height: 10),
                    BasfDropDownInput(
                      labelText: 'Label',
                      controller: TextEditingController(text: 'PC'),
                      values: const ['PC'],
                    ),
                    const SizedBox(height: 10),
                    BasfDropDownInput(
                      labelText: 'Label',
                      controller: TextEditingController(text: 'PC'),
                      values: const ['PC', 'PK', 'TM'],
                      unselectedText: 'Select a value',
                      allowUnselected: true,
                      itemColor: (value) {
                        if (value == 'PC') return BasfColors.red;
                        if (value == 'PK') return Colors.green;
                        return null;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ].joinWithSeparator(const SizedBox(height: 15)),
        ),
      ),
    );
  }
}
