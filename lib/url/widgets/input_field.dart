
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({super.key, required this.title, required this.hint,this.controller, this.widget, });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:titleStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration:  BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            borderRadius: BorderRadius.circular(12),
          ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      // ignore: unnecessary_null_comparison
                      //readOnly: Widget==null?false:true,
                      autocorrect: false,
                      cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                      controller: controller,
                      style: subtitleStyle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subtitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:  BorderSide(
                            color: context.theme.colorScheme.background ,
                            width: 0
                          )
                        ),
                        enabledBorder:  UnderlineInputBorder(
                            borderSide:  BorderSide(
                                color: context.theme.colorScheme.background ,
                                width: 0)
                            ),
                      ),
                    )
                ),
                widget==null?Container():Container(child: widget,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
