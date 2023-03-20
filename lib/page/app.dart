import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late int _currentPageIndex ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;

  }


  BottomNavigationBarItem _bottomNavigationBarItem(String iconName, String label){
    return BottomNavigationBarItem(

        icon: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child:  SvgPicture.asset("assets/svg/${iconName}_off.svg", width:22),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom:5),
          child: SvgPicture.asset("assets/svg/${iconName}_on.svg", width:22),


        ),
        label: label,
    );
  }

  Widget _bottomNavigationBarwidget(){
    return BottomNavigationBar(
      type:BottomNavigationBarType.fixed,
      onTap:(int index){
        print(index);
        setState(() {
          _currentPageIndex = index ;
        });
      },
        selectedFontSize: 12,
        currentIndex:_currentPageIndex ,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        items: [

          _bottomNavigationBarItem("home","홈"),
          _bottomNavigationBarItem("notes","동네생활"),
          _bottomNavigationBarItem("location","내 근처"),
          _bottomNavigationBarItem("chat","채팅"),
          _bottomNavigationBarItem("user","나의 당근"),

          
        ]
    );
  }


  Widget _bodyWidget() {
    switch (_currentPageIndex){
      case 0:
        return Home();
        break;
      case 1:
        return Container();

      case 2:
        return Container();

      case 3:
        return Container();

      case 4:
        return Container();
    }

    return Container();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarwidget(),
    );
  }
}
