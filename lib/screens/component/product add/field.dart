import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../utils/colors.dart';
import '../common.dart';

class addField extends StatelessWidget {
  const addField({
    super.key,
    required this.bill,
    required this.textInputType,
    required this.hintTxt,
    required this.controller,
  });

  final Bill bill;
  final TextInputType textInputType;
  final String hintTxt;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  $hintTxt', style: bodyTxt(),),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if(value!.isEmpty || value == ''){
                  return 'Please fill';
                }

                return null;
              },
              keyboardType: TextInputType.text,
              onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
              decoration: InputDecoration(
                labelText: hintTxt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondary, width: 2),
                ),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
