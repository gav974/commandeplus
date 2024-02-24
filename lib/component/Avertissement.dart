import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../models/Orders.dart';

///génere une modale pour eviter les erreur de suppression de
///@param keyId ;
class Avertissement extends StatelessWidget {
  final dynamic ID;
  Avertissement({required this.ID});
  @override

  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Row(
        children: [
          Icon(
            Icons.warning,
            color:Colors.redAccent,
            size:100,

          ),
          Text(' Attention',
          style: GoogleFonts.poppins(
            textStyle:  TextStyle(
              fontSize:39,
            )
          ),),
        ],
      ),
      content: Text('Êtes-vous sûr de vouloir terminer la commande '+ ID.toString()  + ' ?',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800
        )
      ),),
      insetPadding: EdgeInsets.all(10.0),
      actions: [
        Column(
          children: [
            Container(
              width:MediaQuery.of(context).size.width* 0.5,
              child: TextButton(
                style:TextButton.styleFrom(
                  minimumSize: Size(10, 0),
                side:BorderSide(
                  width: 2.00,
                  color: Colors.green,
                ),
                  ),
                onPressed: () {
                  // Si l'utilisateur appuie sur "Annuler", ferme le dialogue sans terminer la commande
                  Navigator.of(context).pop(false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.green,
                    ),
                    Text('Annuler',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.green
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
    Container(
    width:MediaQuery.of(context).size.width* 0.5,
    child: TextButton(
    style:TextButton.styleFrom(
    minimumSize: Size(10, 0),
    side:BorderSide(
    width: 2.00,
    color: Colors.red,
    ),
    ),
    onPressed: () {
    // Si l'utilisateur appuie sur "Terminer", ferme le dialogue et termine la commande
    //Provider.of<Orders>(context, listen: false).terminatedOrder(ID);
    Navigator.of(context).pop(true);
    },
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(Icons.delete,
    color: Colors.red,)
    ,Text('Terminer'),
    ],
    ),
    ),
    )
          ],
        ),
      ],
    );
  }
}