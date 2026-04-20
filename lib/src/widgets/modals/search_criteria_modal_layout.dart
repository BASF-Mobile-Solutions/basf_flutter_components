import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Modal layout for search criteria.
class SearchCriteriaModalLayout extends StatefulWidget {
  /// Creates a modal layout for search criteria.
  const SearchCriteriaModalLayout({
    super.key,
    this.title,
    this.searchText = false,
    required this.items,
    this.searchLocalization = 'Search',
    this.saveCriteriaLocalization = 'Save Criteria',
    this.filtersLocalization = 'Filters',
  });

  /// Modal title.
  final String? title;

  /// Search criteria items.
  final List<SearchCriteriaModalUiModel> items;

  /// Whether the action button should show search text.
  final bool searchText;

  /// Search localization.
  final String searchLocalization;

  /// Save criteria localization.
  final String saveCriteriaLocalization;

  /// Filters localization.
  final String filtersLocalization;

  @override
  State<SearchCriteriaModalLayout> createState() => _SearchCriteriaModalLayoutState();
}

class _SearchCriteriaModalLayoutState extends State<SearchCriteriaModalLayout> {
  final _formKey = GlobalKey<FormState>();
  final _validatedNotifier = ValueNotifier(false);
  final _saveTriggerNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    for (final item in widget.items) {
      switch (item) {
        case SearchCriteriaModalUiModelTextField():
          item.controller.addListener(_validateForm);
        case SearchCriteriaModalUiModelDatePicker():
          item.controller.addListener(_validateForm);
        case SearchCriteriaModalUiModelSwitch():
        case SearchCriteriaModalUiModelInfoTileItem():
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
  }

  void _validateForm() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final areRequiredFieldsFilled = _areAllRequiredFieldsFilled();
    _validatedNotifier.value = isFormValid && areRequiredFieldsFilled;
  }

  bool _areAllRequiredFieldsFilled() {
    return widget.items.every((item) {
      switch (item) {
        case SearchCriteriaModalUiModelDatePicker():
          return !item.isNecessary || item.notifier.value != null;
        case SearchCriteriaModalUiModelTextField():
          final isRequired = item.validator?.call('') != null;
          return !isRequired || item.controller.text.trim().isNotEmpty;
        case SearchCriteriaModalUiModelSwitch():
        case SearchCriteriaModalUiModelInfoTileItem():
          return true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalBody(
      title: widget.title ?? widget.filtersLocalization,
      bodyWidgets: [_dataFields()],
      bottomButton: ValueListenableBuilder<bool>(
        valueListenable: _validatedNotifier,
        builder: (_, isValid, _) => _saveButton(enabled: isValid),
      ),
    );
  }

  Widget _saveButton({required bool enabled}) {
    return BasfTextButton.contained(
      expanded: true,
      text: widget.searchText ? widget.searchLocalization : widget.saveCriteriaLocalization,
      onPressed: enabled ? saveCriteria : null,
    );
  }

  Widget _dataFields() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: _validateForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getWidgets().joinWithSeparator(VerticalSpacer.medium()),
      ),
    );
  }

  List<Widget> _getWidgets() {
    final widgets = <Widget>[];
    final buffer = <Widget>[];
    bool? currentFullWidth;

    void flushRun(List<Widget> run, bool fullWidth) {
      if (fullWidth) {
        widgets.addAll(run);
      } else {
        widgets.addAll(_InfoItemsRow.multipleFromList(run));
      }
    }

    for (final item in widget.items) {
      final itemWidget = switch (item) {
        SearchCriteriaModalUiModelTextField() => _textField(item),
        SearchCriteriaModalUiModelDatePicker() => _buildDatePicker(item),
        SearchCriteriaModalUiModelSwitch() => _buildCheckbox(item),
        SearchCriteriaModalUiModelInfoTileItem() => item.infoItem,
      };

      final isFull = item.fullWidth;

      if (currentFullWidth == null) {
        currentFullWidth = isFull;
      } else if (currentFullWidth != isFull) {
        flushRun(buffer, currentFullWidth);
        buffer.clear();
        currentFullWidth = isFull;
      }

      buffer.add(itemWidget);
    }

    if (buffer.isNotEmpty && currentFullWidth != null) {
      flushRun(buffer, currentFullWidth);
    }

    return widgets;
  }

  Widget _buildCheckbox(SearchCriteriaModalUiModelSwitch item) => BasfCheckbox(
    text: item.title,
    value: item.notifier.value,
    onChanged: (value) {
      setState(() => item.notifier.value = !value);
      _validateForm();
    },
  );

  Widget _buildDatePicker(SearchCriteriaModalUiModelDatePicker item) {
    final dates = widget.items.whereType<SearchCriteriaModalUiModelDatePicker>().toList();
    final startDate = dates.firstWhereOrNull((o) => o.title == item.titleIsAfter)?.notifier.value;
    final endDate = dates.firstWhereOrNull((o) => o.title == item.titleIsBefore)?.notifier.value;

    String? validator(String? _) {
      final thisDate = item.notifier.value;
      return (item.isNecessary && thisDate == null) ||
              (thisDate != null && startDate != null && startDate.isAfter(thisDate)) ||
              (thisDate != null && endDate != null && endDate.isBefore(thisDate))
          ? ''
          : null;
    }

    return FormField<String>(
      validator: validator,
      builder: (state) => _ModalDatePicker(
        validator: validator,
        title: item.title,
        controller: item.controller,
        enabled: item.enabled,
        setDateTime: (dateTime) => setState(() => item.notifier.value = dateTime),
        firstDate: startDate,
        lastDate: endDate,
      ),
    );
  }

  Widget _textField(SearchCriteriaModalUiModelTextField item) {
    if (item.persistenceId != null) {
      return PersistedTextField.fromTextFieldData(
        textFieldData: item.textFieldData,
        saveTriggerNotifier: _saveTriggerNotifier,
        enabled: true,
      );
    }

    return BasfTextField.fromTextFieldData(textFieldData: item.textFieldData);
  }

  void saveCriteria() {
    _saveTriggerNotifier.value = true;
    for (final item in widget.items) {
      switch (item) {
        case SearchCriteriaModalUiModelTextField():
          item.onSaveValue();
        case SearchCriteriaModalUiModelDatePicker():
          item.onSaveValue();
        case SearchCriteriaModalUiModelSwitch():
          item.onSaveValue();
        case SearchCriteriaModalUiModelInfoTileItem():
      }
    }

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    for (final item in widget.items) {
      switch (item) {
        case SearchCriteriaModalUiModelTextField():
          item.controller.removeListener(_validateForm);
          item.controller.dispose();
        case SearchCriteriaModalUiModelDatePicker():
          item.controller.removeListener(_validateForm);
          item.controller.dispose();
        case SearchCriteriaModalUiModelSwitch():
        case SearchCriteriaModalUiModelInfoTileItem():
      }
    }
    _validatedNotifier.dispose();
    _saveTriggerNotifier.dispose();
    super.dispose();
  }
}

sealed class SearchCriteriaModalUiModel {
  const SearchCriteriaModalUiModel({required this.fullWidth});

  final bool fullWidth;
}

final class SearchCriteriaModalUiModelTextField extends SearchCriteriaModalUiModel {
  const SearchCriteriaModalUiModelTextField({
    required this.labelText,
    required this.controller,
    required this.notifier,
    this.persistenceId,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    required this.onSaveValue,
    super.fullWidth = true,
  });

  final String labelText;
  final TextEditingController controller;
  final ValueNotifier<bool> notifier;
  final String? persistenceId;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final VoidCallback onSaveValue;

  TextFieldData get textFieldData {
    return TextFieldData(
      controller: controller,
      labelText: labelText,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      persistenceId: persistenceId,
      textCapitalization: textCapitalization,
      validator: validator,
    );
  }
}

final class SearchCriteriaModalUiModelDatePicker extends SearchCriteriaModalUiModel {
  const SearchCriteriaModalUiModelDatePicker({
    required this.title,
    required this.controller,
    required this.notifier,
    required this.isNecessary,
    this.enabled = true,
    this.titleIsAfter,
    this.titleIsBefore,
    required this.onSaveValue,
    super.fullWidth = false,
  });

  final String title;
  final TextEditingController controller;
  final ValueNotifier<DateTime?> notifier;
  final bool isNecessary;
  final bool enabled;
  final String? titleIsAfter;
  final String? titleIsBefore;
  final VoidCallback onSaveValue;
}

final class SearchCriteriaModalUiModelSwitch extends SearchCriteriaModalUiModel {
  const SearchCriteriaModalUiModelSwitch({
    required this.title,
    required this.notifier,
    required this.onSaveValue,
    super.fullWidth = true,
  });

  final String title;
  final ValueNotifier<bool> notifier;
  final VoidCallback onSaveValue;
}

final class SearchCriteriaModalUiModelInfoTileItem extends SearchCriteriaModalUiModel {
  const SearchCriteriaModalUiModelInfoTileItem({
    required this.infoItem,
    super.fullWidth = true,
  });

  final InfoTileItem infoItem;
}

class _InfoItemsRow extends StatelessWidget {
  const _InfoItemsRow({
    this.leading,
    this.tailing,
    this.spacer,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  static List<Widget> multipleFromList(
    List<Widget> widgets, {
    Widget? spacer,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return widgets.slices(2).map((slice) {
      if (slice.length == 1) return slice.first;

      return _InfoItemsRow(
        leading: slice.first,
        tailing: slice.last,
        spacer: spacer,
        crossAxisAlignment: crossAxisAlignment,
      );
    }).toList();
  }

  final Widget? leading;
  final Widget? tailing;
  final Widget? spacer;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(child: leading ?? const SizedBox.shrink()),
        Expanded(child: tailing ?? const SizedBox.shrink()),
      ].joinWithSeparator(spacer ?? HorizontalSpacer.semi()),
    );
  }
}

class _ModalDatePicker extends StatelessWidget {
  const _ModalDatePicker({
    required this.title,
    required this.controller,
    required this.setDateTime,
    this.enabled = true,
    this.validator,
    this.firstDate,
    this.lastDate,
  });

  final String title;
  final TextEditingController controller;
  final ValueChanged<DateTime?> setDateTime;
  final bool enabled;
  final String? Function(String?)? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return LabeledWidget(
      labelText: title,
      child: InkWell(
        onTap: enabled ? () => _openCalendar(context, appTheme) : null,
        onLongPress: () {
          controller.clear();
          setDateTime(null);
        },
        splashColor: appTheme.primaryColor.withValues(alpha: 0.1),
        highlightColor: appTheme.primaryColor.withValues(alpha: 0.1),
        child: BasfTextField(
          validator: validator,
          controller: controller,
          style: appTheme.textTheme.bodySmall?.copyWith(fontSize: 13),
          canRequestFocus: false,
          greyWhenDisabled: false,
          enabled: false,
          decoration: InputDecoration(
            errorStyle: const TextStyle(height: 0),
            alignLabelWithHint: true,
            hintText: '-',
            filled: !enabled,
            disabledBorder: enabled ? appTheme.inputDecorationTheme.enabledBorder : null,
            suffixIcon: enabled ? const Icon(BasfIcons.calendar, size: 20) : null,
          ),
        ),
      ),
    );
  }

  Future<void> _openCalendar(BuildContext context, ThemeData appTheme) async {
    final today = DateTime.now();
    final dateTime = await showDatePicker(
      context: context,
      initialDate: _parsedDate ?? lastDate ?? today,
      firstDate: firstDate ?? today.subtract(const Duration(days: 365)),
      lastDate: lastDate ?? today,
      builder: (context, child) {
        return Theme(
          data: BasfThemes.datePickerButtonTheme(appTheme),
          child: child!,
        );
      },
    );

    if (dateTime != null) {
      controller.text = DateFormat('dd.MM.yyyy').format(dateTime);
      setDateTime(dateTime);
    }
  }

  DateTime? get _parsedDate {
    if (controller.text.trim().isEmpty) return null;

    try {
      return DateFormat('dd.MM.yyyy').parseStrict(controller.text.trim());
    } catch (_) {
      return null;
    }
  }
}
