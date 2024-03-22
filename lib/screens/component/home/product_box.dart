import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pr/screens/view/edit_product.dart';

import '../../../model/model.dart';
import '../../../utils/colors.dart';
import '../common.dart';

class productBox extends StatefulWidget {
  const productBox({
    super.key,
    required this.bill,
  });


  final Bill bill;

  @override
  State<productBox> createState() => _productBoxState();
}

class _productBoxState extends State<productBox> {
  @override
  Widget build(BuildContext context) {
    widget.bill.refreshData();

    return
    Column(
      children: [
        ...List.generate(data.length, (index) =>
        Container(
          height: 160,
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name and quantity
                        Text(
                          'Name : ${widget.bill.productList![index].name}',
                          style: bodyTxt(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Quantity : ${widget.bill.productList![index].quantity}',
                          style: bodyTxt(),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //product price
                        Text(
                          'Price : ${widget.bill.productList![index].price}',
                          style: bodyTxt(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //delete button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      data.removeAt(index);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: 130,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Delete',
                            style: bodyTxt(color: Colors.white),
                          ),
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),


                  //edit button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {


                      editIndex = index;
                      Navigator.of(context).pushNamed('/edit').then((value) => setState(() {
                        
                      }));
                      
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      width: 130,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Edit',
                            style: bodyTxt(color: Colors.white),
                          ),
                          const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),)
      ],
    );
  }
}