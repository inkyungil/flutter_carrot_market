import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String, String>> datas = [];
  late int _currentPageIndex ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPageIndex = 0;
    datas = [{
      "image" : "assets/images/ara-1.jpg",
      "title" : "네메시스 축구화275",
      "location" : "제주 제주시 아라동",
      "price" : "3000",
      "like" : "2"
    },{
    "image" : "assets/images/ara-2.jpg",
    "title" : "네메시스 축구화",
    "location" : "제주 제주시 아라동2",
    "price" : "4000",
    "like" : "2"
    },{
      "image" : "assets/images/ara-3.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-4.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-5.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-6.jpg",
      "title" : "네메시스 축구화275",
      "location" : "제주 제주시 아라동",
      "price" : "3000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-7.jpg",
      "title" : "네메시스 축구화",
      "location" : "제주 제주시 아라동2",
      "price" : "4000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-8.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-9.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    },{
      "image" : "assets/images/ara-10.jpg",
      "title" : "네메시스 축구화33",
      "location" : "제주 제주시 아라동2",
      "price" : "5000",
      "like" : "2"
    }

    ];
  }
  static final oCcy = new NumberFormat("#,###", "ko_KR");
  static String calcStringToWon(String priceString) {
    if (priceString != null && priceString != "") {
      return "${oCcy.format(int.parse(priceString))}원";
    } else {
      return "- 원";
    }
  }

  PreferredSizeWidget _appbarWidget(){
    return AppBar(
      title:GestureDetector(
        onTap: (){
          print("click");
        },
        child: Row(
            children: const [
              Text('경일동'),
              Icon(Icons.arrow_drop_down),
            ]
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(onPressed: (){}, icon : const Icon(Icons.search)),
        IconButton(onPressed: (){}, icon : const Icon(Icons.tune)),
        IconButton(onPressed: (){}, icon : SvgPicture.asset('assets/svg/bell.svg',width:22)),
      ],
    );
  }





  Widget _bodyWidget(){
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index){
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),

            child: Row(
              children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      datas[index]["image"].toString(),
                      width: 100,
                      height: 100,
                    ),
                  ),

              Expanded(child:  Container(
                height: 100,
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        datas[index]['title'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),),
                      Text(
                          datas[index]['location'].toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
                      ),

                      Text(
                          calcStringToWon(datas[index]['price'].toString() ),
                          style: const TextStyle(fontWeight: FontWeight.w500 )
                      ),

                      Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:[
                            SvgPicture.asset("assets/svg/heart_off.svg", width:13, height:13,),
                            const SizedBox(width: 5),
                            Text(datas[index]["like"].toString()),
                          ]
                        )
                      )

                    ]),))

              ],
            ),
          );
        },
        separatorBuilder: (BuildContext _context, int index){
          return Container(
            height: 1,
            color: const Color(0xff99999999),
          );
        },
        itemCount: 10);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget() ,
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarwidget(),
    );
  }
}
