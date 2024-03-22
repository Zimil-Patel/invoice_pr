import 'package:flutter/material.dart';
import 'package:invoice_pr/screens/view/add_product.dart';
import 'package:invoice_pr/screens/view/edit_product.dart';
import 'package:invoice_pr/screens/view/home_screen.dart';

void main() {
  runApp(const Invoice());
}

class Invoice extends StatelessWidget {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      initialRoute: '/home',
      routes: {
        '/home' : (context) => const HomeScreen(),
        '/add' : (context) => const AddProduct(),
        '/edit' : (context) => const EditProduct(),
      },

    );
  }
}




