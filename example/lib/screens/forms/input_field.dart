import 'package:flutter/material.dart';
import 'package:basf_flutter_components/basf_flutter_components.dart';

class InputFieldPage extends StatelessWidget {
  const InputFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Input Field')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            BasfTextField(
              labelText: 'False Input',
              hintText: 'Max. 4 Characters',
              validation: (text) {
                if (text.length > 4) return 'Max. 4 Characters';
              },
            ),
            BasfTextField(
              labelText: 'Delayed Error',
              hintText: 'Min. 1 Character',
              initialValidation: false,
              validation: (text) {
                if (text.isEmpty) return 'Must not be empty!';
              },
            ),
            BasfTextField(
              labelText: 'Initial Error',
              hintText: 'Min. 1 Character',
              validation: (text) {
                if (text.isEmpty) return 'Must not be empty!';
              },
            ),
            const BasfTextField(
              disabled: true,
              labelText: 'Disabled Hint',
              hintText: 'Hint text',
            ),
            const BasfTextField(
              disabled: true,
              labelText: 'Disabled Text',
              hintText: 'Disabled',
              initialText: 'Default Text',
            ),
            const BasfTextField(
              labelText: 'Number Input',
              hintText: '0123456789',
              inputType: TextInputType.number,
            ),
            const BasfTextField(
              labelText: 'Initial Text',
              hintText: 'This was filled initially',
              initialText: 'Default Text',
            ),
            BasfTextField(
              prefixIcon: BasfIcons.check_circle,
              // labelText: 'Icon Text',
              hintText: 'This was filled initially',
              initialText: 'I need no label',
              onChanged: (text) {
                debugPrint(text);
              },
            ),
            const BasfTextField(
              labelText: 'Obscure Text',
              hintText: 'This was filled initially',
              obscureText: true,
              initialText: 'Default Text',
            ),
          ],
        ),
      ),
    );
  }
}
