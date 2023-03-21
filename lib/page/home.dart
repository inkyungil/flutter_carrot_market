import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carrot_market/repository/contents_repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/data_utils.dart';
import 'detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({ Key ? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}


class Data{
  String cid;
  String image;
  String title;
  String location;
  String price;
  String likes;

  Data(this.cid, this.image, this.title, this.location, this.price, this.likes);

  factory Data.fromJson(dynamic json){
    return Data(json['cid'] as String, json['image'] as String, json['title'] as String, json['location'] as String, json['price'] as String, json['likes'] as String );
  }


}


class _HomeState extends State<Home> {

  var _text = "";
  final List<Data> _datas = [];

  void _fetchPosts() async{
    final response = await http.get(Uri.parse("https://propose9898.cafe24.com/_board2/list.php"));
    _text = utf8.decode(response.bodyBytes);
    var dataObjsJson = jsonDecode(_text)['ara'] as List;
    final List<Data> parsedResponse = dataObjsJson.map((dataJson)=>Data.fromJson(dataJson)).toList();

    setState(() {
      _datas.clear();
      _datas.addAll(parsedResponse);
    });
    print(parsedResponse);
  }


  final ContentsRepository contentsRepository = ContentsRepository();
  late String currentLocation;
  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동",
  };

  @override
  void initState() {
    super.initState();
    currentLocation = "ara";

    _fetchPosts();

  }

  /*
  * appBar Widget 구현
  */
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          print("click event");
        },
        child: PopupMenuButton<String>(
          offset: Offset(0, 20),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          child: Row(
            children: [
              Text(locationTypeToString[currentLocation]?? ""),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          onSelected: (String value) {
            setState(() {
              currentLocation = value;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "ara",
                child: Text("아라동"),
              ),
              const PopupMenuItem(
                value: "ora",
                child: Text("오라동"),
              )
            ];
          },
        ),
      ),
      elevation: 1, // 그림자를 표현되는 높이 3d 측면의 높이를 뜻함.
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, String>>> _loadContents() async {
    List<Map<String, String>> responseData =
    await contentsRepository.loadContentsFromLocation(currentLocation);
    return responseData;
  }

  Widget _makeDataList(List<Map<String, String>> datas) {
    int size = datas == null ? 0 : datas.length;
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15),
      physics: ClampingScrollPhysics(), // bounce 효과를 제거 할 수 있다.
      itemBuilder: (BuildContext context, int index) {

        if (datas != null && datas.length > 0) {
          Map<String, String> data = datas[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailContentView(data: data);
              }));
            },

            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Hero(
                        tag: data["cid"].toString(),
                        child: Image.asset(
                          data["image"].toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.only(left: 20, top: 2),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["title"].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data["location"].toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xff999999)),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DataUtils.calcStringToWon(data["price"].toString()),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 18,
                                      child: SvgPicture.asset(
                                        "assets/svg/heart_off.svg",
                                        width: 13,
                                        height: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(data["likes"].toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      itemCount: size,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        );
      },
    );
  }

  /*
   * body UI
   */
  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, dynamic snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("데이터 오류"));
        }
        if (snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }
        return const Center(child: Text("해당 지역에 데이터가 없습니다."));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
