import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class BASFInputField extends StatefulWidget {
  const BASFInputField({
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.hintText,
    this.labelText = '',
    this.initialText = '',
    this.validation,
    this.initialValidation = true,
    this.disabled = false,
    this.withoutClear = false,
    this.obscureText = false,
    this.inputType,
    this.padding,
    Key? key,
  }) : super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  ///The onChanged returns the text inside the InputField anytime it's changed.
  final void Function(String)? onChanged;

  ///Adds a icon before the text in the InputField.
  final IconData? prefixIcon;

  ///The hintText will be shown in the InputField if there is no input.
  final String? hintText;

  ///The label above the InputField.
  final String? labelText;

  ///The initial text shown in the InputField.
  final String? initialText;

  ///This triggers the color of the field and adds an error text right under the
  /// InputField for the user if wanted.
  /// This validation is triggered also during initialization by default.
  /// You can change that with the [initialValidation] attribute.
  ///
  /// If the validation returns a filled String, the contend will be added as error.
  /// If the validation returns an empty String, just the color of the field will be triggered.
  /// If the validation returns null, no error response appear.
  ///
  /// You can use it like this:
  /// validation: (String text) {
  ///               if (text.isEmpty) return 'Must not be empty!';
  ///             },
  final String? Function(String)? validation;

  ///The initialValidation is to checks the initial value during creating the InputField.
  ///
  ///
  /// The default value is true.
  /// If you don't want this, maybe on login input fields, you can set this to false.
  final bool? initialValidation;

  ///This disables the interaction with the InputFiled changes its appearance.
  ///
  /// The default value is false.
  final bool? disabled;

  ///This enables you to don't show the clear button at the end of the InputField.
  ///
  /// The default value is false.
  final bool? withoutClear;

  ///This obscures the input.
  ///
  /// The default value is false.
  final bool? obscureText;

  ///Define the keyboard for this InputField.
  final TextInputType? inputType;

  ///The padding for the whole InputField.
  ///
  /// If that's null, the default padding is 4.0 vertically.
  final EdgeInsets? padding;

  @override
  State<BASFInputField> createState() => _BASFInputFieldState();
}

class _BASFInputFieldState extends State<BASFInputField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  String? errorText;

  late Color borderColor;
  late Color backgroundColor;
  late TextStyle textStyle;
  late TextStyle hintTextStyle;

  @override
  void initState() {
    ///Text Editing Controller
    controller = widget.controller ?? TextEditingController();
    if (widget.initialText != null) controller.text = widget.initialText!;

    ///Focus Node
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));

    ///Initial Input Validation
    if (widget.validation != null && widget.initialValidation!) {
      errorText = widget.validation!(widget.initialText ?? '');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Set appearance depending on actions
    if (widget.disabled!) {
      borderColor = BASFColors.middleGrey;
      backgroundColor = BASFColors.lightGrey;
      textStyle = BASFTextStyles.inputFieldDisabled;
      hintTextStyle = BASFTextStyles.inputFieldDisabled;
    } else {
      if (errorText != null) {
        borderColor = BASFColors.red;
        textStyle = BASFTextStyles.inputFieldError;
        hintTextStyle = BASFTextStyles.inputFieldHintError;
        if (focusNode.hasFocus) {
          backgroundColor = BASFColors.redPale;
        } else {
          backgroundColor = BASFColors.white;
        }
      } else {
        textStyle = BASFTextStyles.inputFieldInput;
        hintTextStyle = BASFTextStyles.inputFieldHint;
        if (focusNode.hasFocus) {
          borderColor = BASFColors.darkBlue;
          backgroundColor = BASFColors.darkBluePale;
          hintTextStyle = BASFTextStyles.inputFieldHintFocus;
        } else {
          borderColor = BASFColors.darkBlue[200]!;
          backgroundColor = BASFColors.white;
          hintTextStyle = BASFTextStyles.inputFieldHint;
        }
      }
    }

    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Text Label
          if (widget.labelText!.isNotEmpty)
            Text(
              widget.labelText!,
              style: BASFTextStyles.inputFieldLabel,
            ),

          ///Text Field
          Focus(
            focusNode: focusNode,
            canRequestFocus: false,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: EdgeInsets.only(
                left: widget.prefixIcon != null ? 8 : 5,
                right: !widget.withoutClear! ? 8 : 5,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                color: backgroundColor,
              ),
              child: Row(
                children: [
                  ///Prefix Icon
                  if (widget.prefixIcon != null)
                    Icon(widget.prefixIcon, size: 24),

                  ///TextField
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: textStyle,
                      enabled: !widget.disabled!,
                      keyboardType: widget.inputType,
                      cursorHeight: 16,
                      cursorRadius: Radius.zero,
                      cursorColor: textStyle.color,
                      obscureText: widget.obscureText!,
                      onChanged: (text) {
                        if (widget.onChanged != null) widget.onChanged!(text);

                        setState(() {
                          if (widget.validation != null) {
                            errorText = widget.validation!(text);
                          }
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: widget.hintText,
                        border: InputBorder.none,
                        hintStyle: hintTextStyle,
                      ),
                    ),
                  ),

                  ///Delete Icon
                  if (!widget.withoutClear! && focusNode.hasFocus)
                    IconButton(
                      focusNode: FocusNode(canRequestFocus: false),
                      icon: const Icon(BasfIcons.clear, size: 24),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints.tight(const Size(24, 24)),
                      highlightColor: BASFColors.transparent,
                      splashColor: BASFColors.transparent,
                      onPressed: () {
                        controller.clear();
                        if (widget.onChanged != null) widget.onChanged!('');
                        setState(() {
                          if (widget.validation != null) {
                            errorText = widget.validation!('');
                          }
                        });
                      },
                    ),
                ],
              ),
            ),
          ),

          ///Error Label
          if (errorText != null && errorText!.isNotEmpty && !widget.disabled!)
            Row(
              children: [
                const Icon(BasfIcons.attention,
                    color: BASFColors.red, size: 16),
                const SizedBox(width: 4), //TODO: Replace with Placeholder
                Text(
                  errorText!,
                  style: BASFTextStyles.inputFieldErrorLabel,
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
}