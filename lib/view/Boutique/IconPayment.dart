
import 'package:flutter/material.dart';


///vérifie si la commande a été payé en ligne
class IconPayment {
  static double _sizeIcon = 40.0;

  static Icon iconPayment(var payment) {
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

  ///vérifie si c'est une livraison///

  static Icon iconLivraison(var shipping) {
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

}
