import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components_example/screens/overview.dart';
import 'package:flutter/foundation.dart' hide Factory;
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BasfRive.init(defaultFactory: Factory.flutter);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  BasfThemeType _theme = BasfThemeType.darkBlue;

  void _setTheme(BasfThemeType theme) {
    setState(() => _theme = theme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASF Components',
      theme: BasfThemes.lightMainTheme(basfThemeType: _theme),
      home: OverviewScreen(
        currentTheme: _theme,
        onThemeChanged: _setTheme,
      ),
      navigatorObservers: [routeObserver],
      localizationsDelegates:
          BasfComponentsLocalizations.localizationsDelegates,
      supportedLocales: BasfComponentsLocalizations.supportedLocales,
    );
  }
}
