import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'models/Orders.dart';
import 'view/Homepage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String localVersion = packageInfo.version;
  print(localVersion);
  runApp(
    ChangeNotifierProvider<Orders>(
      create: (context) => Orders(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    return MaterialApp(
      title: 'Commmande plus ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Commande adamo'),
    );
  }
}