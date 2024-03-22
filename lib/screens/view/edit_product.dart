import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../utils/colors.dart';
import '../component/common.dart';
import '../component/product add/field.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

int editIndex = 0;

class _EditProductState extends State<EditProduct> {
  final formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Bill bill = Bill();
    bill.refreshData();

    bill.txtName = TextEditingController(text: data[editIndex]['name']);
    bill.txtPrice = TextEditingController(text: '${data[editIndex]['price']}');
    bill.txtQuantity = TextEditingController(text: '${data[editIndex]['quantity']}');
    return Scaffold(

      backgroundColor: bgColor,

      appBar: AppBar(

        centerTitle: true,
        backgroundColor: primary,
        title: Text(
          'Add Product',
          style: headingTxt(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(

            height: 600,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow:  [
                BoxShadow(
                  color: secondary,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: Form(
              key: formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addField(bill: bill, hintTxt: 'Product Name', textInputType: TextInputType.text, controller: bill.txtName,),
                  addField(bill: bill, hintTxt: 'Product Price', textInputType: TextInputType.number, controller: bill.txtPrice,),
                  addField(bill: bill, hintTxt: 'Product Quantity', textInputType: TextInputType.number, controller: bill.txtQuantity,),

                  const SizedBox(
                    height: 20,
                  ),

                  Center(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {

                        if(formKey1.currentState!.validate()){
                          const snackBar = SnackBar(
                            backgroundColor: Colors.black,
                            content: Text('Dat Saved'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);


                          data[editIndex]['name'] = bill.txtName.text;
                          data[editIndex]['price'] = double.parse(bill.txtPrice.text);
                          data[editIndex]['quantity'] = int.parse(bill.txtQuantity.text);


                          bill.refreshData();
                          setState(() {

                          });
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: 130,
                        child: Text(
                          'Save',
                          style: bodyTxt(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
