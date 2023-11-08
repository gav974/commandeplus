import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class Orders extends ChangeNotifier {

  List<dynamic> _orders = [];
  List<dynamic> get orders => _orders;

  set orders(List<dynamic> value) {
    _orders = value;
  }

  WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: "https://adamo.resarun.com",
      consumerKey: "ck_20fd9b55a3a3d5da7f421edd18a4bf000e0fe1bd",
      consumerSecret: "cs_f61247e8ebb7c1b5044da0a98acace426def394d");

  Future fetchOrders() async {
    const items = "orders";
    const param = "?status=processing";
    const order = "&order=asc";
    // Initialize the API

    // Get data using the "products" endpoint
    orders = await wooCommerceAPI.getAsync(items + param + order);

    _orders = orders;
    notifyListeners();
  }

  Future terminatedOrder(int id) async {
    try {
      const items = "orders/";
      var key = id;
      var response = await wooCommerceAPI.postAsync(
        items + key.toString(),
        {
          "status": "completed"
        },
      );

      this.fetchOrders();
      print(response); // JSON Object with response
    } catch (e) {
      print(e);

      notifyListeners()
      ;
    }
  }
}
