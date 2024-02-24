
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'controller/update.dart';
import 'models/Orders.dart';
import 'view/Homepage.dart';
import 'models/settings.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Récupérez la version actuelle de l'application
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String localVersion = packageInfo.version;
  print("local: " + localVersion);

  Settings.versionServer = localVersion;

  // Vérifiez la version sur le serveur
  var serverVersion = await getServerApkVersion();
  print("server: "+ serverVersion!);
  // Si la version sur le serveur est plus récente, déclenchez la mise à jour

  if (serverVersion != null && serverVersion.compareTo(localVersion) > 0) {
    print("server: " + serverVersion);
    showUpdateDialog(serverVersion);
  } else {
    Wakelock.enable();
    runApp(

      ChangeNotifierProvider<Orders>(
        create: (_) => Orders(),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final titleAppbar = 'Commande Adamo';
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    //enleve le spash ecran
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commmande Adamo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: titleAppbar),
    );
  }
}
