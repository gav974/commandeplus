import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/Orders.dart';

///détermine si l'on doit afficher le bouton livraison
Widget IsLivraison(context, id_orderlivraison , isLivraison){
  print("islivraison"  + isLivraison[1].toString()) ;
  if( isLivraison[1]["value"] == "delivery"){
    return
      Container(
        padding: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 5.0),
        child: TextButton(
          onPressed: (){
            Provider.of<Orders>(context, listen: false).exec_livraison(id_orderlivraison);
          },
          style:TextButton.styleFrom(
            textStyle: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight:FontWeight.w600,
                color: Colors.white

            ),
            padding: EdgeInsets.symmetric(vertical:10.0 ,horizontal: 20.0),
            backgroundColor:Colors.blue,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "A livré",
              ),
            ],
          ),
        ),
      );
  } else {
    return Container();
  }
}