import 'package:flutter/material.dart';
import 'package:todoapp/models/global.dart';

class IntrayPage extends StatefulWidget {
  
  @override
  _IntrayPage createState() => _IntrayPage();
}

class _IntrayPage extends State<IntrayPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrayColor,
      child: ListView(
        padding: EdgeInsets.only(top: 300),
        children: getList(),
      ),

    );
}
  List<Widget> getList(){
    return[
      Container(
        height: 100,
        color: Colors.red,
      ),
            Container(
        height: 100,
        color: Colors.green,
      ),
    ];
  }
}
