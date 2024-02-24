import 'dart:async';

import 'package:commandeplus/component/Appbar.dart';
import 'package:commandeplus/component/Avertissement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';
import '../component/Font_line.dart';
import '../models/Orders.dart';
import 'package:wakelock/wakelock.dart';

class Livraison extends StatefulWidget {
  const Livraison({super.key});

  @override
  State<Livraison> createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
  @override
  final String title = "Livraison";
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar(title), body: viewLivraison());
  }
}

class viewLivraison extends StatefulWidget {
  const viewLivraison({super.key});

  @override
  State<viewLivraison> createState() => _viewLivraisonState();
}

class _viewLivraisonState extends State<viewLivraison> {
  @override
  late Timer _timer;
  late Future<dynamic> _order;

  @override
  void initState() {
    super.initState();
    final _Orders = Provider.of<Orders>(context as BuildContext, listen: false);
    _order = _Orders.fetchOrders(); // Appel initial pour obtenir les commandes
    // Créer un Timer qui exécute la fonction chaque 60 secondes

    _timer = Timer.periodic(Duration(seconds: 60), (Timer timer) {
      _order = _Orders.fetchOrders();
    });
  }
@override
  void dispose() {
    // Assurez-vous de désactiver le timer pour éviter les fuites de mémoire
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.disable();
    return Consumer<Orders>(builder: (context, responseBuilder, child) {
      if (responseBuilder.orders.isEmpty) {
        return Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/image/background.png'),
                fit:BoxFit.cover

              ),
            ),
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Récupération en cours des livraisons',style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white
              )
            ),)],
          ),
        ));
      } else {
        var incrementIndex = 0;
        return Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.2,
            fit: BoxFit.cover,
            image:AssetImage('assets/image/bancground-white.png')
      ),
            ),
      child: ListView.builder(
              itemCount: responseBuilder.orders.length,
              itemBuilder: (context, index) {
                //  print(responseBuilder.orders[index]["meta_data"]);
                final double sizeText = 16.00;

                if (responseBuilder.orders[index]["meta_data"] != null &&
                    responseBuilder.orders[index]["meta_data"].length > 2 &&
                    responseBuilder.orders[index]["meta_data"][2]["value"] ==
                        "ready") {

                  incrementIndex ++  ;
            print(incrementIndex);
                  return Container(

                    color:colorlines(incrementIndex.toInt()),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Commande " +
                                    responseBuilder.orders[index]["id"]
                                        .toString(),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 20.00,
                                    height: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              IconButton(onPressed: (){
                                bottomSheetInformations(context,responseBuilder.orders[index]);
                              },
                                  icon:const Icon(Icons.remove_red_eye_outlined ))
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(Icons.person_3, size: sizeText),
                                  ),
                                  Text(
                                    responseBuilder.orders[index]['billing']
                                            ['last_name'] +
                                        ' ' +
                                        responseBuilder.orders[index]['billing']
                                            ['first_name'],
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: sizeText,

                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(Icons.home, size: sizeText),
                              ),
                              Text(
                                responseBuilder.orders[index]['billing']
                                    ['address_1'],
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: sizeText)),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 10, horizontal: 0)),
                          Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                  children: [
                                TextButton(
                                  onPressed: () {
                                    var rawAdress = responseBuilder.orders[index]['billing'];
                                    String Adress = rawAdress['address_1'].toString() + "," + rawAdress['country'].toString() + "," + rawAdress['postcode'].toString() + " " + rawAdress['city'].toString();
                                    openMaps(Adress);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.map_outlined),
                                      Text('Voir sur la carte '),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: ()  {
                                    var keyID = responseBuilder.orders[index]['id'];
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Avertissement(ID: keyID);
                                        }
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.check),
                                      Text('Commande terminée ')
                                    ],
                                  ),
                                )
                              ]),
                            ],
                          )
                        ],
                      ));
                } else {
                  return Container();
                }
              }),
        );
      }
    });
  }
}

///
Future<void> openMaps(rawAdress) async {
  print(rawAdress);
  String query = Uri.encodeComponent(rawAdress);
  Uri mapUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");

  await launchUrl(mapUrl);

}


Future<void> bottomSheetInformations(context, commande){
  double screenWidth = MediaQuery.of(context).size.width;
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context){

return Container(
  width: screenWidth * 0.9 ,
  padding: EdgeInsets.symmetric(vertical:screenWidth * 0.02,horizontal: screenWidth * 0.02 ),
  child: Column(
    children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.receipt_long_outlined,
                      size:30,),
            ),
            Text(commande['id'].toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )
            ),
        ),
          ],
        ),
      Text("Informations de commande ",
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        fontWeight: FontWeight.w500,
            fontSize: MediaQuery.devicePixelRatioOf(context)*8,
      )
        ),
        ),
      Padding(
        padding: EdgeInsets.only(top:50),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for(var product in commande['line_items'])
            Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product['quantity'].toString(),
                ),
                Text(" x " + product['name'].toString()),
              ],
            ),
            )
        ],
      ),
  Spacer(
    flex: 1,
  ),
      Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
        width: screenWidth * 0.8,
        decoration: const BoxDecoration(
          color: Color.fromARGB(103, 171, 94, 94),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  child:Text("Statut",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 171, 11, 11)
                    )
                  ),
                  )
                ),
                Container(
                  child: Text(commande["transaction_id"].toString().isEmpty ? "Non payé ":"payé",
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 25,
                            color: commande["transaction_id"].toString().isEmpty? Color.fromARGB(
                                255, 89, 3, 25): Color.fromARGB(
                                255, 67, 229, 14)
                        )
                    ),),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  child:Text("Reste à Payer",
                style: GoogleFonts.poppins(
                textStyle: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 171, 11, 11)
            )
),
        )
                ),
                Container(
                  child:Text(commande['total'],
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 171, 11, 11)
                        )
                    ),)
                )
              ],
            )
          ],
        )
      )
    ],
  ),
);
      });
}


