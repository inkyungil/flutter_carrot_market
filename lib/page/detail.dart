import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);



  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }


  PreferredSizeWidget  _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white,),
      ),
      actions:[

        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),


      ]
    );
  }

  Widget _bodyWidget() {
      return Container(

          child: Stack(
            children: [

              Hero(
                tag: widget.data["cid"] as String,
                child: CarouselSlider(
                options: CarouselOptions(
                height: size.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                  onPageChanged: (index, reason){
                    print(index);
                  }
              ),

                  items: List.generate(5, (index) {
                    return Image.asset(
                      widget.data["image"].toString(),
                      width: size.width,
                      fit: BoxFit.fill,
                    );
                  }),
                ),
              ),

        ])

      );




      //   child: Image.asset(
      //     widget.data['image'].toString(),
      //     width:size.width,
      //     fit:BoxFit.fill,
      //
      //   ),
      // );



  }


  Widget _bottomBarwidget() {
    return Container(
      width: size.width,
      height: 55,
      color: Colors.red,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarwidget(),
    );
  }
}

