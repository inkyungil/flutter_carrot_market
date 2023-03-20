import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];

  late String currentLocation;
  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동",
  };


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentLocation = "ara" ;


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
        child: PopupMenuButton<String>(
          offset: Offset(0,20),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          onSelected: (String where){
            print(where);
            setState(() {
              currentLocation = where ;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: "ara", child:Text("아라동")),
              const PopupMenuItem(value: "ora", child:Text("오라동")),
              const PopupMenuItem(value: "donam", child:Text("동남동")),
            ];
          },


        child: Row(
            children:[
              //Text('경일동'),
              Text(locationTypeToString[currentLocation]?? ""),
              Icon(Icons.arrow_drop_down),
            ]
          ),
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


  Widget _bodyWidget() {
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
