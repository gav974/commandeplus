import 'dart:async';

import 'package:commandeplus/component/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/Orders.dart';
import '../component/Avertissement.dart';

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
  double _sizeIcon = 40.0;

  @override
  void initState() {
    super.initState();
    final _Orders = Provider.of<Orders>(context as BuildContext, listen: false);
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
///vérifie si c'est une livraison
  _iconLivraison(
    var shipping
  ) {
    var title_shipping = shipping[1]["value"].toString();

    if (title_shipping != "delivery") {
      return Icon(
        Icons.storefront,
        size: _sizeIcon,
      );
    } else {
      return Icon(
        Icons.motorcycle,
        size: _sizeIcon,
      );
    }

  }
///vérifie si la commande a été payé en ligne
  _iconPayment(var payment) {
    if (payment.isEmpty) {
      return Icon(
        Icons.credit_card_off,
        size: _sizeIcon,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.credit_score,
        size: _sizeIcon,
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<Orders>(
        builder: (context, responseBuilder, child) {
          if (responseBuilder.orders.isEmpty) {
            return _InterrogationApiWoo();
          } else {
            return ListView.builder(
              itemCount: responseBuilder.orders.length,
              itemBuilder: (context, index) {
                if(responseBuilder.orders[index]["meta_data"][2]["value"]  == "null") {
                  return Container(
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
                              child: _iconLivraison(
                                  responseBuilder.orders[index]["meta_data"]),
                            ),
                            Container(
                                child: _iconPayment(responseBuilder.orders[index]
                                ["transaction_id"]))
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
                            _isLivraison(context,
                                responseBuilder.orders[index]["id"],
                                responseBuilder.orders[index]["meta_data"]),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
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
                                        vertical: 20.0, horizontal: 50.0),
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
                }
              },

            );
          }
        },
      ),
    );
  }
}


///ecran qui aide à patienter lors de la recupération des commandes
_InterrogationApiWoo() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage('assets/logo/appstore.png'),
                width: 200, // Remplacez par la largeur souhaitée
                height: 200, // Remplacez par la hauteur souhaitée
                fit: BoxFit.cover),
            Text(
              'recupération des commandes',
              textAlign: TextAlign.center,
            )
          ]),
    ],
  );
}

///détermine si l'on doit afficher le bouton livraison
 _isLivraison(context, id_orderlivraison , isLivraison){
print(isLivraison[1]) ;
if( isLivraison[1]["value"] == "delivery"){
return
    Container(
      padding: EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 10.0),
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
          padding: EdgeInsets.symmetric(vertical:20.0 ,horizontal: 50.0),
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
}
else{
    return Container();

  }
}
