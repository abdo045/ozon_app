import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mybottom extends StatelessWidget {

  final VoidCallback onPressed;

  Mybottom( {required this.onPressed, required this.title,});
final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(20),
              right: Radius.circular(20)
          ),
      color:Color.fromARGB(255, 37, 41, 127),
      ),

      child:  MaterialButton(
        onPressed:onPressed,
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
      ),

    );
  }
}