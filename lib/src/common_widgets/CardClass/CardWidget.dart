import 'package:flutter/material.dart';

// dynamic headerText;
// dynamic bodyText;
// dynamic headerColor;
// dynamic bodyColor;
// dynamic bodyImage;

Widget card(cardd){
  return Card(
    elevation: 4,
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35)
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container( padding: const EdgeInsets.fromLTRB(35, 30, 0, 0), height: 74 , color: cardd.headerColor ,child: Text(cardd.headerText, style: TextStyle(fontFamily:'Gotham',color: Colors.black, fontSize: 20),))),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(35),
            bottomLeft: Radius.circular(35)
          ),
          child: Container( padding: const EdgeInsets.fromLTRB(0, 30, 0, 0), height: 179 ,color: cardd.bodyColor ,child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(cardd.bodyText,style:TextStyle(fontFamily:'Gotham',color: Colors.black, fontSize: 20,height: 1.15)),
              SizedBox(width: 5,),
              Image.asset(cardd.bodyImage,width: 125, height: 169),
            ],
          )),
        ),
      ],
    ),
  );
}