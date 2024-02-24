import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

///Affiche le montant de commande au total
Widget Price_commande(String price){
  return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(248, 97, 97, 0.33725490196078434)
      ),
      child: Text(
        price.toString()+" €",
        style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 18,fontWeight: FontWeight.w600
          ),
        ),
      )
  );
}

