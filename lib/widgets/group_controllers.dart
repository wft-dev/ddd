import 'package:flutter/material.dart';

/// These [GroupControllers] are used for name, price, quantity as [TextEditingController].
class GroupControllers {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  void dispose() {
    name.dispose();
    price.dispose();
    quantity.dispose();
  }
}
