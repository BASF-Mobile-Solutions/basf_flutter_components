import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  late final TextEditingController _enabledController;
  late final TextEditingController _disabledController;
  late final TextEditingController _errorController;
  late final TextEditingController _obscureController;
  late final TextEditingController _iconsController;
  late final GlobalKey<FormState> _formKey;
  final ValueNotifier<bool> saveTriggerNotifier = ValueNotifier(false);

  @override
  void initState() {
    _enabledController = TextEditingController();
    _disabledController = TextEditingController();
    _errorController = TextEditingController();
    _obscureController = TextEditingController();
    _obscureController.text = 'obscured';
    _iconsController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

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
            const SizedBox(height: 15),
            BasfTextField(
              decoration: const InputDecoration(hintText: 'Enabled'),
              controller: _enabledController,
            ),
            const SizedBox(height: 15),
            BasfTextField(
              enabled: false,
              decoration: const InputDecoration(hintText: 'Disabled'),
              controller: _disabledController,
            ),
            const SizedBox(height: 15),
            BasfTextField(
              formKey: _formKey,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Error'),
              controller: _errorController,
            ),
            const SizedBox(height: 15),
            PersistedTextField(
              uniqueId: 'uniqueId',
              saveTriggerNotifier: saveTriggerNotifier,
              controller: TextEditingController(),
              onEditingComplete: () {
                saveTriggerNotifier.value = !saveTriggerNotifier.value;
              },
              decoration: const InputDecoration(hintText: 'Persistent input'),
            ),
            const SizedBox(height: 15),
            BasfTextField(
              decoration: const InputDecoration(labelText: 'Obscured'),
              obscureText: true,
              controller: _obscureController,
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BasfTextField(
                    controller: TextEditingController(),
                    autovalidateMode: AutovalidateMode.always,
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
            const SizedBox(height: 10),
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
                      isLoading: true,
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
                        if (value == 'PC') return Colors.red;
                        if (value == 'PK') return Colors.green;
                        return null;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
