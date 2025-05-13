// import 'package:basf_flutter_components/basf_flutter_components.dart';
// import 'package:flutter/material.dart';
//
// /// Layout fr no permission to use camera
// class ScannerNoPermissionLayout extends StatelessWidget {
//   ///
//   const ScannerNoPermissionLayout({
//     required this.provideCameraPermissionText,
//     super.key,
//   });
//
//   /// "Provide Camera Permission"
//   final String provideCameraPermissionText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: Dimens.paddingDefault,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         noCameraIcon(context),
//         BasfTextButton.transparent(
//           text: provideCameraPermissionText,
//           onPressed: () async => await checkPermissionOrOpenSettings(),
//         ),
//       ],
//     );
//   }
//
//   ///
//   Widget noCameraIcon(BuildContext context) {
//     return Icon(
//       Icons.no_photography_outlined,
//       size: 30,
//       color: Theme.of(context).primaryColor,
//     );
//   }
//
//   /// Checks permission
//   Future<void> checkCameraPermission(BuildContext context) async {
//     if (!context.mounted) return;
//
//     if (await PlatformSpecific.isPhysicalDevice()) {
//       PermissionStatus permission = await Permission.camera.request();
//       if (mounted) {
//         cameraPermission.value = permission;
//       }
//     } else {
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }
//
//   Future<void> checkPermissionOrOpenSettings() async {
//     await checkCameraPermission();
//
//     if (cameraPermission.value != PermissionStatus.granted) {
//       await AppSettings.openAppSettings();
//     }
//   }
// }
