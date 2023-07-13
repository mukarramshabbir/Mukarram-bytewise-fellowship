import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  final String btnName;
  final Icon? icon;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? callback;

  RoundedButton({
    required this.btnName, this.icon, this.bgColor=Colors.blue, this.textStyle, this.callback
  });

  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        callback!();
      },
      child: icon!=null ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          Container(width: 13,),
          Text(btnName,style: textStyle,),
        ],
      ) : Text(btnName,style: textStyle,),
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(21),
                bottomLeft: Radius.circular(21),
          ),
        )
      ),
    );
  }
}