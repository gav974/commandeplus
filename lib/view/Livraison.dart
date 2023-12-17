import 'package:commandeplus/component/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Livraison extends StatefulWidget {
  const Livraison({super.key});

  @override
  State<Livraison> createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
  @override
  final String title = " Livraison";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title),
      body:viewLivraison()
    );
  }
}

class viewLivraison extends StatefulWidget {
  const viewLivraison({super.key});

  @override
  State<viewLivraison> createState() => _viewLivraisonState();
}

class _viewLivraisonState extends State<viewLivraison> {
  @override
  Widget build(BuildContext context) {
    return Center(
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Page en Construction')
      ],
    )
    ],
),
    );
  }
}


