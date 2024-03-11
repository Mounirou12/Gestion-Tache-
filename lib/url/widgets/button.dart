import 'package:flutter/material.dart';
import 'package:gestion_tache/url/theme.dart';

class  MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 120,
        height: 80,
        padding: EdgeInsets.only(top: 20,bottom: 20,left: 30,right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryClr,
        ),
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }

}