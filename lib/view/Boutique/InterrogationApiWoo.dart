
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///ecran qui aide à patienter lors de la recupération des commandes
Widget InterrogationApiWoo(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/image/background.png'),
          fit:BoxFit.cover

      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('assets/logo/appstore.png'),
                  width: 100, // Remplacez par la largeur souhaitée
                  height: 100, // Remplacez par la hauteur souhaitée
                  fit: BoxFit.cover),
              Text(
                'recupération des commandes',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color:Colors.white
                    )
                ),
              )
            ]),
      ],
    ),
  );
}
