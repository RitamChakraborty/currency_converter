import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/views/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Converter(),
      child: MaterialApp(
        title: "Currency Converter",
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.cyanAccent,
        ),
        home: Home(),
      ),
    );
  }
}
