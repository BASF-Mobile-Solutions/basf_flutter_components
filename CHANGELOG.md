## 2.9.3
- Revert scanner to old stable version

## 2.9.2
- Scanner overlay fix

## 2.9.1
- Camera lib update
- Add Chinese translations

## 2.9.0
- More localization languages support added

## 2.8.1
- Appbar back button fix

## 2.8.0
- Elements for checklist process
- Lib Localization support

## 2.7.0
- Camera fixes

## 2.6.6
- Barcode scanner added
- Bloc and path provider libs can now be used in projects from this lib
- Flutter 3.32.0, Dart 3.8.0

## 2.6.5
- Various components from BASF apps added for merge

## 2.6.4
- Added the option `multiScanEnabled` in the BasfTextField

## 2.6.3
- Added getter to TextFieldData to better get and set the controller text

## 2.6.2
- Add function to TextFieldData, to set the controller text to the favorite value of persisted input
- Add greyWhenDisabled attribute to BasfTextField, to show or hide the grey color when disabled

## 2.6.1
- Improved Appearance of TextFields

## 2.6.0
- Fixes to minimize conflicts by last changes
- Generally improved implementations of last changes
- Improved theming and validation in BasfTextField and PersistedTextField
- Added fromTextFieldData constructors to BasfTextField and PersistedTextField
- Improvements by providing initial value to BasfDropDownInput
- Improve AppSnackBar

## 2.5.3
- Minor fixes

## 2.5.2
- Added TextFieldData to provide common data to BasfTextField and PersistedTextField
- Added 'isNullOrEmpty' and 'isNotNullOrEmpty' object extension
- Added default cases of TextInputFormatters

**BREAKING CHANGES:**
removed initialValue, onFieldSubmitted and onSaved from BasfTextField and PersistedTextField, because it had no effect.


## 2.5.1
- Changes to dropdown input widget: Added maxWidth to define constrains 
- Added LabeledWidget, which can be used to label text fields, dropdown and others

**BREAKING CHANGES:**

remove used 'isExpanded' dropdown attributes. 
Dropdown will occupy the minimum needed space, but can be stretched by the parent widget


## 2.5.0
- Flutter 3.29
- Snackbar clears previous snackbars before showing
- Validated fields do not occupy space when error text is empty
- Popup/Dropdown menu items do not add additional padding vertically
- (Max) dropdown - allow change via controller & disable if only one value
- New android animations

**BREAKING CHANGES:**

instead of Theme.of(context).dialogBackgroundColor now use BasfThemes.primaryPaleBackgroundColor()

## 2.4.4

**BREAKING CHANGES:**

Custom fonts behaviour

Now to use custom font from the library, you need to do two steps in the app.

1. Add mappings to the font in your app's pubspec.yaml with a path to the lib, full example is in **readme.md**

2. If you are using a BASF theme for theme app, then you need to include your font into the list of fallback fonts

`BasfThemes.lightMainTheme(fontFamilyFallback: const ['NotoSansSC'])`

* changed behavior of persistent input

## 2.4.3

- updated libs and support for Flutter 3.27

## 2.4.2

- Adds BasfOptionalDropDownInput

## 2.4.1

- Add dart 3.5 support

## 2.4.0

- Adds Noto Sans SC font to the package

## 2.3.0

- Upgrade to Flutter 3.22 and Dart 3.4

## 2.2.12

- Fix actions and paste in BASF Text field

## 2.2.11

- Persistent input now can work from outside

## 2.2.10

- Better persistent field show up

## 2.2.9

- Flutter 3.19

## 2.2.8

- Persistent input widget added
- Basf input widget updated

## 2.2.7

- update colors

## 2.2.6

- remove material 2
- update Flutter to 3.16

## 2.2.5

- adjust theme for multi-theming

## 2.2.4

- update to Dart 3.1 and Flutter 3.13.6

## 2.2.3

- update to Dart 3 and Flutter 3.10.0
- material3 enabled by default, possible to switch off in theme arg

## 2.2.2

- input field bug fix

## 2.2.1

- add text styles to disabled inputs

## 2.2.0

- Updated to Flutter 3.7.0 and Dart 2.19.0

## 2.1.10

- Fixed memory leak and error on dispose in Fade widget

## 2.1.9

- Added `isMandatory` param to `DropDownInput`. If it is set to `true`,
  and `TextEditingController.text` value is empty the border color is set to the current theme's
  `errorColor` (default: `false`)
- [Breaking change] Added limit of standard `BasfButton` height

## 2.1.8

- `DropDownInput` title style changed to `bodyText2`

## 2.1.7

- `TextInput` title style changed to `bodyText2`

## 2.1.6

- Dropdown title added
- Dropdown click extended
- Material3 switched off until released (icons theme was wrong)

## 2.1.5

- Change dropdown loading UI

## 2.1.4

- Added disable functionality for dropdown

## 2.1.3

- Changed disabled behavior of dropdown

## 2.1.2

- Fixed some issues regarding styles on buttons

## 2.1.1

- Updated documentation and contributing guide

## 2.1.0

- Removed unnecessary package dependencies

## 2.0.2

- Updated docs

## 2.0.1

- Added theme extension on context

## 2.0.0

- Whole new structure for the library, tests, and documentation

## 1.1.6

- changed init of Basf Dropdown

## 1.1.5

- added loader for dropdown input

## 1.1.4+2

- Changed dialog and date picker themes

## 1.1.3+1

- Added additional params to BasfDropDownInput

## 1.1.2+3

- Added Spacer

## 1.1.2+2

- Quick BasfDropDownInput fix

## 1.1.2+1

- Updated BasfDropDownInput component

## 1.1.1+2

- Fix issues

## 1.1.0+1

- Flutter 3.0 and fixed issues

## 1.0.0+11

- Remove tint color from Appbar by default

## 1.0.0+10

- Migrated to Flutter 3

## 1.0.0+9

- Adjusted general Paddings

## 1.0.0+8

- Fixed Padding

## 1.0.0+7

- Small fix

## 1.0.0+6

- Connect inputs to border theme

## 1.0.0+5

- Fixed iOS Icon error

## 1.0.0+4

- Connected all components to rounded corners

## 1.0.0+3

- Changed rounded corners (Sorry Dima)

## 1.0.0+2

- Changed .pubignore

## 1.0.0+1

- Fixed some problems

## 1.0.0

- First version with basic components working

## 0.1.0

- Initial release

## 0.0.1+3

- Removed unnecessary components

## 0.0.1+2

- Fixed errors

## 0.0.1+1

- Setup update

## 0.0.1

- Initial setup
