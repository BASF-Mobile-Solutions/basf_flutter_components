import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Modal layout for search criteria.
class SearchCriteriaModalLayout extends StatefulWidget {
  /// Creates a modal layout for search criteria.
  const SearchCriteriaModalLayout({
    required this.title,
    required this.textFieldItems,
    this.relatedControllers = const [],
    this.inputFormatters,
    super.key,
    this.searchLocalization = 'Search',
    this.saveCriteriaLocalization = 'Save Criteria',
  });

  /// Modal title
  final String title;

  /// List of [TextFieldData]
  final List<TextFieldData> textFieldItems;

  /// List of related [TextEditingController]s
  /// that will be controlled based on other fields
  final List<TextEditingController> relatedControllers;

  /// A list of [TextInputFormatter] that formats the input.
  /// Will apply to all text fields on this modal
  final List<TextInputFormatter>? inputFormatters;

  /// Translation
  final String searchLocalization;
  /// Translation
  final String saveCriteriaLocalization;

  @override
  State<SearchCriteriaModalLayout> createState() =>
      _SearchCriteriaModalLayoutState();
}

class _SearchCriteriaModalLayoutState extends State<SearchCriteriaModalLayout> {
  late final List<TextFieldData> tempTextFieldItems;
  final List<ValueNotifier<bool>> textFieldNotifiers = [];
  final List<TextFieldUpdateData> enabledControllers = [];
  final ValueNotifier<bool> saveTriggerNotifier = ValueNotifier(false);
  late final ValueNotifier<bool> buttonNotifier;

  @override
  void initState() {
    initControllers();
    buttonNotifier = ValueNotifier(
      tempTextFieldItems.any((e) => e.controller.text.trim().isNotEmpty),
    );

    super.initState();
  }

  void initControllers() {
    tempTextFieldItems = List.generate(widget.textFieldItems.length, (index) {
      textFieldNotifiers.add(
        ValueNotifier(widget.textFieldItems[index].controller.text.isEmpty),
      );

      final controller = TextEditingController()
        ..text = widget.textFieldItems[index].controller.text;

      if (widget.relatedControllers
          .contains(widget.textFieldItems[index].controller)) {
        enabledControllers.add(TextFieldUpdateData(
          controller: controller,
          notifier: ValueNotifier(controllerEnabled(controller)),
        ));

        controller.addListener(() {
          for (final controller in enabledControllers) {
            controller.notifier.value =
                controllerEnabled(controller.controller);
          }
        });
      }

      final textField = widget.textFieldItems[index];
      return TextFieldData(
        persistenceId: textField.persistenceId,
        labelText: textField.labelText,
        controller: controller,
        autovalidateMode: textField.autovalidateMode,
        inputFormatters: textField.inputFormatters,
        keyboardType: textField.keyboardType,
        textCapitalization: textField.textCapitalization,
        validator: textField.validator,
      );
    });

    for (final data in tempTextFieldItems) {
      data.controller.addListener(() {
        buttonNotifier.value = tempTextFieldItems
            .any((e) => e.controller.text.trim().isNotEmpty);
      });
    }
  }

  bool controllerEnabled(TextEditingController controller) {
    if (enabledControllers.isEmpty) {
      return true;
    } else if (enabledControllers.every((c) => c.controller.text.isEmpty)) {
      return true;
    } else if (controller.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    for (final data in tempTextFieldItems) {
      data.controller.dispose();
    }
    saveTriggerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalBody(
      title: widget.title,
      bodyWidgets: textFields(),
      bottomButton: saveButton(),
    );
  }

  Widget saveButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: buttonNotifier,
      builder: (context, filled, _) {
        return BasfTextButton.contained(
          expanded: true,
          text: filled
              ? widget.searchLocalization
              : widget.saveCriteriaLocalization,
          onPressed: saveCriteria,
        );
      },
    );
  }

  List<Widget> textFields() {
    return List.generate(tempTextFieldItems.length, (index) {
      return enabledControllers.any(
              (k) => k.controller == tempTextFieldItems[index].controller)
          ? switchableTextField(index)
          : textField(index: index);
    }).joinWithSeparator(VerticalSpacer.medium());
  }

  Widget switchableTextField(int index) {
    return ValueListenableBuilder<bool>(
        valueListenable: enabledControllers.firstWhere(
                (e) => e.controller == tempTextFieldItems[index].controller)
            .notifier,
        builder: (context, enabled, _) {
          return textField(index: index, enabled: enabled);
        });
  }

  Widget textField({required int index, bool enabled = true}) {
    return PersistedTextField(
      persistenceId: tempTextFieldItems[index].labelText,
      saveTriggerNotifier: saveTriggerNotifier,
      enabled: enabled,
      controller: tempTextFieldItems[index].controller,
      decoration: InputDecoration(
        labelText: tempTextFieldItems[index].labelText,
      ),
      validator: tempTextFieldItems[index].validator,
      keyboardType: tempTextFieldItems[index].keyboardType
          ?? TextInputType.text,
      scrollPadding: const EdgeInsets.only(bottom: 70),
      inputFormatters: [
        ...?tempTextFieldItems[index].inputFormatters,
      ],
      textCapitalization: tempTextFieldItems[index].textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  void saveCriteria() {
    for (final data in widget.textFieldItems) {
      final item = tempTextFieldItems
          .firstWhere((d) => d.labelText == data.labelText);
      data.controller.text = item.controller.text.trim();
    }

    saveTriggerNotifier.value = !saveTriggerNotifier.value;

    Navigator.pop(context, tempTextFieldItems
        .any((i) => i.controller.text.trim().isNotEmpty));
  }
}
