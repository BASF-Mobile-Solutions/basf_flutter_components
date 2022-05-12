import 'package:basf_flutter_components/widgets/inputs/text_field.dart';
import 'package:flutter/material.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(8.0),
          children: [
            BasfTextField(
              decoration: const InputDecoration(
                hintText: 'Enabled',
              ),
              controller: _enabledController,
            ),
            const SizedBox(height: 15),
            BasfTextField(
              enabled: false,
              decoration: const InputDecoration(
                hintText: 'Disabled',
              ),
              controller: _disabledController,
            ),
            const SizedBox(height: 15),
            BasfTextField(
              formKey: _formKey,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Error',
              ),
              controller: _errorController,
            ),
            const SizedBox(height: 15),
            BasfTextField(
              decoration: const InputDecoration(
                labelText: 'Obscured',
              ),
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
                  onPressed: () {
                    _iconsController.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
