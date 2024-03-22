import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoice_pr/screens/component/common.dart';
import 'package:invoice_pr/utils/colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pd;
import 'package:printing/printing.dart';
import '../../model/model.dart';
import '../component/home/product_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final PdfColor p = const PdfColor.fromInt(0xAA86B6F6);
final PdfColor s = const PdfColor.fromInt(0xAAB4D4FF);

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    Bill bill = Bill();
    bill.refreshData();

    return Scaffold(
      backgroundColor: bgColor,


      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: const CircleBorder(),
        onPressed: (){

          Navigator.of(context).pushNamed('/add').then((value) => setState(() {
            
          }));

        },
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: primary,
        title: Text(
          'Invoice Generator',
          style: headingTxt(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          //product list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  productBox(bill: bill,),
                ],
              ),
            ),
          ),

          //bottom bar
          Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {

                double subTotal = 0;
                for(int i = 0; i < data.length; i++){
                  subTotal += bill.productList![i].price! * bill.productList![i].quantity!;
                }

                final pdf = pd.Document();

                pdf.addPage(pd.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (context) => pd.Column(
                    children: [

                        pd.Row(
                          children: [
                            pd.Expanded(
                              child: pd.Container(
                                alignment: pd.Alignment.centerLeft,
                                height: 80,
                                color: s,
                                child: pd.Text('  Invoice', style: pd.TextStyle(
                                  fontWeight: pd.FontWeight.bold,
                                  fontSize: 30,
                                  color: PdfColors.white
                                ),),
                              ),
                            ),

                            pd.Container(
                              height: 80,
                              width: 140,
                              alignment: pd.Alignment.center,
                              child: pd.Text('${ subTotal + (subTotal * 18) / 100} Rs.', style: pd.TextStyle(
                                fontWeight: pd.FontWeight.bold,
                                fontSize: 20,
                              ),),
                              color: p,
                            ),
                          ],
                        ),

                        pd.SizedBox(
                          height: 20
                        ),




                      pd.SizedBox(
                          height: 20
                      ),

                        //product list and table
                        pd.Row(
                          mainAxisAlignment: pd.MainAxisAlignment.start,
                          children: [

                            pd.Expanded(
                              child: pd.Column(
                                children: [
                                  titleBox('Product Id '),
                                  ...List.generate(bill.productList!.length, (index) => cellBox(index, '${index + 1}')),
                                ],
                              ),
                            ),

                            pd.Expanded(
                              child: pd.Column(
                                crossAxisAlignment: pd.CrossAxisAlignment.start,
                                children: [
                                  titleBox('Product Name '),
                                  ...List.generate(bill.productList!.length, (index) => cellBox(index, '${bill.productList![index].name}')),
                                ],
                              ),
                            ),

                            pd.Expanded(
                              child: pd.Column(
                                crossAxisAlignment: pd.CrossAxisAlignment.start,

                                children: [
                                  titleBox('Product Quantity '),
                                  ...List.generate(bill.productList!.length, (index) => cellBox(index, '${bill.productList![index].quantity}')),
                                ],
                              ),
                            ),

                            pd.Expanded(
                              child: pd.Column(
                                crossAxisAlignment: pd.CrossAxisAlignment.start,

                                children: [
                                  titleBox('Product Price '),
                                  ...List.generate(bill.productList!.length, (index) => cellBox(index, '${bill.productList![index].price! * bill.productList![index].quantity!}')),
                                ],
                              ),
                            ),

                          ],
                        ),


                      pd.SizedBox(
                        height: 30,
                      ),

                      // total stuffs
                      pd.Row(
                        mainAxisAlignment: pd.MainAxisAlignment.end,
                        children: [
                          //name
                          pd.Column(
                            crossAxisAlignment: pd.CrossAxisAlignment.start,
                            children: [
                              pd.Text('Subtotal :'),
                              pd.SizedBox(
                                height: 8,
                              ),pd.Text('GST (18%) :'),
                              pd.SizedBox(
                                height: 8,
                              ),
                              pd.Text('Total :'),
                            ]
                          ),





                          pd.SizedBox(
                            width: 30
                          ),

                          //value
                          pd.Column(
                            crossAxisAlignment: pd.CrossAxisAlignment.end,
                            children: [


                              pd.Text('$subTotal Rs.'),
                              pd.SizedBox(
                                height: 8,
                              ),pd.Text('${(subTotal * 18) / 100} Rs.'),
                              pd.SizedBox(
                                height: 8,
                              ),
                              pd.Text('${ subTotal + (subTotal * 18) / 100} Rs.'),
                            ]
                          ),
                        ],
                      ),
                    ],
                  ),
                ));

                await Printing.layoutPdf(
                    onLayout: (format) async => pdf.save());

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
                  'Print PDF',
                  style: bodyTxt(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

titleBox(String title) {
  return pd.Container(
    alignment: pd.Alignment.center,
    width: double.infinity,
    padding: const pd.EdgeInsets.symmetric(vertical: 10),
    decoration: pd.BoxDecoration(
      color: p,
    ),
    child: pd.Text(
      title,
      style: pd.TextStyle(
        fontWeight: pd.FontWeight.bold,
      ),
    ),
  );
}


cellBox(int index, String data) {
  return pd.Container(
    alignment: pd.Alignment.center,
    width: double.infinity,
    padding: const pd.EdgeInsets.symmetric(vertical: 10),
    decoration: pd.BoxDecoration(
      color: (index % 2) != 0 ? p : s,
    ),
    child: pd.Text(
      data,
      style: pd.TextStyle(
        fontWeight: pd.FontWeight.bold,
      ),
    ),
  );
}

