import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'models/Orders.dart';
import 'view/Homepage.dart';

void main() async {
  // Récupérez la version actuelle de l'application
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String localVersion = packageInfo.version;
  print("local: "+ localVersion);

  // Vérifiez la version sur le serveur
  var serverVersion = await getServerApkVersion();
  print("serverver" + serverVersion!);
  // Si la version sur le serveur est plus récente, déclenchez la mise à jour

  if (serverVersion != null && serverVersion.compareTo(localVersion) > 0) {
    print("server: " + serverVersion);
    showUpdateDialog(serverVersion);
  } else {
    Wakelock.enable();
    runApp(
      ChangeNotifierProvider<Orders>(
        create: (context) => Orders(),
        child: MyApp(),
      ),
    );
  }
}
     
Future<String?> getServerApkVersion() async {
  final serverjson = "https://adamo.resarun.com/application/appcast.json";
  try {
    final responseJson = await http.get(Uri.parse(serverjson));
    if (responseJson.statusCode == 200 ) {
  final Map<String, dynamic>  ResponseFinalJson= jsonDecode(responseJson.body);
      return ResponseFinalJson['version'];
    } else {

      print('Échec de la récupération de la version de l\'APK');
return null;
    }
  } catch (e) {
    print('Erreur lors de la récupération de la version de l\'APK: $e');

  }
}

void showUpdateDialog(String serverVersion) {
  runApp(
    MaterialApp(
      home: Builder(
        builder: (context) => AlertDialog(
          title: Text('Nouvelle version disponible'),
          content: Text('Une nouvelle version ($serverVersion) est disponible. Voulez-vous la télécharger et l\'installer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                launchDownloadLink();
              },
              child: Text('Oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Continuez avec votre application actuelle
                Wakelock.enable();
                runApp(
                  ChangeNotifierProvider<Orders>(
                    create: (context) => Orders(),
                    child: MyApp(),
                  ),
                );
              },
              child: Text('Non'),
            ),
          ],
        ),
      ),
    ),
  );
}

void launchDownloadLink() async {
  final String serverUrl = "https://adamo.resarun.com/application/app-release.apk";
  try {
    await launchUrl(Uri.parse(serverUrl));
  } catch (e) {
    print('Erreur lors de l\'ouverture du lien de téléchargement: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commmande Adamo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Commande Adamo'),
    );
  }
}