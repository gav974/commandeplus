import 'package:commandeplus/component/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Boutique.dart';
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

  final double Textsize = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:DecorationImage(
          image: AssetImage('assets/image/background-adamo.jpg'),
          fit: BoxFit.cover)
      ),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 40.0),
          titlePadding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
      actionsPadding: EdgeInsets.all(60.0),
        backgroundColor: Colors.red[50],
        icon: Icon(
          Icons.notifications
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
            fontWeight:  FontWeight.w200,

          )
        )
        ),
        actions: [
          ElevatedButton(
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
          SizedBox(height: 10),
           ElevatedButton(
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
        ],
      ),
    );
  }
}


