import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:commandeplus/component/Appbar.dart';

import 'package:google_fonts/google_fonts.dart';
import '../models/settings.dart';
import 'Boutique/Boutique.dart';
import 'Livraison.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      appBar: appbar(widget.title),
      body: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final double Textsize = 16;
  final double TextsizeButton = 20;

  @override
  Widget build(BuildContext context) {
    final double width_button_alert_dailog = MediaQuery.of(context).size.width * 0.45;
    return Container(
      decoration: const BoxDecoration(
          image:DecorationImage(
          image: AssetImage('assets/image/background-adamo.jpg'),
          fit: BoxFit.cover)
      ),
      child: AlertDialog(
        contentPadding:const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        titlePadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        actionsPadding: EdgeInsets.all(30.0),
        backgroundColor: Colors.red[50],
        icon: const Icon(
          Icons.check_box,
          color: Colors.red,
          size:40,
        ),
        title: Text('Choix du service',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
        )
        ),
        content:Text('Veuillez choisir votre service: ',
        textAlign:  TextAlign.center,
        style:GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontWeight:  FontWeight.w400,
          )
        )
        ),
        actions: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width_button_alert_dailog,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:const EdgeInsets.symmetric(vertical:20.0 , horizontal: 0.0),
                    ),
                  onPressed: () {
                          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Boutique()),
                          );
                        }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                  Icon(
                      Icons.shopping_cart,
                  color: Colors.red[400]
                  ),
                  Text(' Commande',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: Textsize,

                    )
                  ),
                    textAlign: TextAlign.center,
                  )
                          ],
                        ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top:10)),
                SizedBox(
                  width: width_button_alert_dailog,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:const EdgeInsets.symmetric(vertical:20.0 , horizontal: 0.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Livraison()),
                      );
                    }, child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                          color: Colors.red[400],),

                        Text('Livraison',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: Textsize,

                              )
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${Settings.versionServer}')
                ],
              )
              ],

            ),

          ),

        ],
      ),
    );
  }
}


