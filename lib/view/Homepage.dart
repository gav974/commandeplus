import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Orders.dart';


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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title,
        textAlign: TextAlign.center,),
        centerTitle: true,

      ),
      body: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  late Timer _timer;
  late Future<dynamic> _order;
  double _sizeIcon= 40.0;

  @override
  void initState() {
    super.initState();
    final _Orders = Provider.of<Orders>(context, listen: false);


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


  iconLivraison(var shipping,) {
    if (shipping["email"].isEmpty){
      return Icon(
        Icons.storefront,
        size:_sizeIcon,
      );
    }else{
      return Icon(
        Icons.motorcycle,
        size:_sizeIcon,
      );
    };
  }

  iconPayment(var payment) {
    if (payment.isEmpty){
      return Icon(
        Icons.credit_card_off,
        size:_sizeIcon,
        color: Colors.red,
      );
    }else{
      return Icon(
        Icons.credit_score,
        size:_sizeIcon,
        color: Colors.green,
      );
    };
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Orders>(
      builder: (context, responseBuilder,child) {
    if (responseBuilder.orders.isEmpty){
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('recupération des commandes'
        ,textAlign: TextAlign.center,)
      ],
    );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical:10,horizontal:10),
                      child: Text("Commande " + responseBuilder.orders[index]["id"].toString(),
                      style: const TextStyle(
                        fontSize: 20.00,
                        height: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    Container(

                      padding: EdgeInsets.symmetric(vertical:0,horizontal:12.0),
                      child:
                    iconLivraison(responseBuilder.orders[index]["billing"]),
                    ),
                    Container(
                      child:iconPayment(responseBuilder.orders[index]["transaction_id"])
                    )
                  ],
                ),
                Wrap(
                  spacing: 0.0, // Espacement horizontal entre les colonnes
                  runSpacing: 8.0, // Espacement vertical entre les lignes

                  children: [
                    for (var listItems in responseBuilder.orders[index]["line_items"])
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width / 2 - 12.0, // Largeur de chaque colonne
                        child: Text(
                          listItems["quantity"].toString() + "x " + listItems["name"],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: TextButton(onPressed: ()=>{},
                            style:const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                              minimumSize: MaterialStatePropertyAll<Size>(Size(200,40))
                            ),
                          child: Row(
                            children: [
                              Text(
                                "Cuisson",
                                style:TextStyle(
                                  color: Colors.white
                                ) ,
                              ),

                            ],
                          ),

                          ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      child: TextButton(
                          onPressed:(){
                            var  keyID = responseBuilder.orders[index]["id"];
                            Provider.of<Orders>(context,listen:false).terminatedOrder(keyID);
                          }
                          ,
                          style:const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                              minimumSize: MaterialStatePropertyAll<Size>(Size(200,40))
                          ),
                          child: Text(
          "Terminé"
          )),
                    )

                  ],
                ),
                Divider(
                  thickness: 2.0,
                )

              ],
            ),
          );
        },
        itemCount: responseBuilder.orders.length,
      );
    }
      },
    );
  }
}