import 'dart:async';

import 'package:commandeplus/component/Appbar.dart';
import 'package:commandeplus/component/Font_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models/Orders.dart';
import '../../component/Avertissement.dart';
import '../../view/Boutique/IconPayment.dart';
import 'IsLivraison.dart';
import 'Price_commande.dart';
import 'InterrogationApiWoo.dart';

class Boutique extends StatefulWidget {
  const Boutique({super.key});

  @override
  State<Boutique> createState() => _BoutiqueState();
}

class _BoutiqueState extends State<Boutique> {
  final String title = 'Commande ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title),
      body: viewBoutique(),
    );
  }
}

class viewBoutique extends StatefulWidget {
  const viewBoutique({super.key});

  @override
  State<viewBoutique> createState() => _viewBoutiqueState();
}

class _viewBoutiqueState extends State<viewBoutique> {
  @override
  late Timer _timer;
  late Future<dynamic> _order;


  @override
  void initState() {
    super.initState();
    final _Orders = Provider.of<Orders>(context as BuildContext, listen: false);
   // final _Orders  = context.watch<Orders>();
    _order = _Orders.fetchOrders(); // Appel initial pour obtenir les commandes
    // Créer un Timer qui exécute la fonction chaque 20 secondes

    _timer = Timer.periodic(Duration(seconds: 05), (Timer timer) {
      _order = _Orders.fetchOrders();
    });
  }

  void dispose() {
    // Assurez-vous de désactiver le timer pour éviter les fuites de mémoire
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<Orders>(
        builder: (context, responseBuilder, child) {
          if (responseBuilder.orders.isEmpty) {
            return InterrogationApiWoo(context);
          } else {
            var index_lines = 0;

            return ListView.builder(
              itemCount: responseBuilder.orders.length,
              itemBuilder: (context, index) {
                if(responseBuilder.orders[index]["meta_data"] != null &&
                    responseBuilder.orders[index]["meta_data"].length >= 2 &&
                    responseBuilder.orders[index]["meta_data"][2]["value"]  == "null") {
                  index_lines ++;
                  return Container(
                    color: colorlines(index_lines),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
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
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12.0),
                              child: IconPayment.iconLivraison (
                                  responseBuilder.orders[index]["meta_data"]),
                            ),
                            Container(
                                child: IconPayment.iconPayment(
                                    responseBuilder.orders[index]
                                    ["transaction_id"])),
                            Spacer(
                              flex: 1,
                            ),
                            Price_commande(responseBuilder.orders[index]['total'])
                          ],

                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.spaceBetween,
                          runSpacing: 20.00,

                          children: [
                            for (var listItems in responseBuilder.orders[index]
                            ["line_items"])
                              Container(
                                height: 30.0,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 -
                                    12.0, // Largeur de chaque colonne
                                child: Text(
                                  listItems["quantity"].toString() +
                                      "x " +
                                      listItems["name"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IsLivraison(context,
                                responseBuilder.orders[index]["id"],
                                responseBuilder.orders[index]["meta_data"]),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              child: TextButton(
                                  onPressed: () {
                                    var keyID =
                                    responseBuilder.orders[index]["id"];
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Avertissement(ID: keyID);
                                        }
                                    ); //Provider.of<Orders>(context, listen: false).terminatedOrder(keyID);
                                    print('pressed');
                                  },
                                  style: TextButton.styleFrom(
                                    textStyle: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    backgroundColor: Colors.green,
                                  ),
                                  child: Text("Terminé")
                              ),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                        )
                      ],
                    ),
                  );
                }else{
                  return Container();
                }
              },

            );
          }
        },
      ),
    );
  }
}


