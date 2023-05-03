import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_room_guide/contrast.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: (){
              Navigator.of(context).pushNamed("/login");
            },
          ),
        ],
      ),
      body: const MyHomePage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).pushNamed("/findRoomPage");
        },
        label: const Text("Tìm phòng học"),
        icon: const Icon(Icons.search),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 5,),
            SizedBox(height: 30,child: Marquee(
              text: "Chào mừng đến với Trường Công nghệ thông tin và Truyền thông",
              style: kGoogleFontItim.copyWith(fontWeight: FontWeight.w600, fontSize: 20, color: kSecondaryColor),
              blankSpace: 12.0,
              velocity: 50,
              fadingEdgeStartFraction: 0.09,
              fadingEdgeEndFraction: 0.09,
            ),),
            const SizedBox(height: 25,),
            const Text("Hướng dẫn sử dụng ứng dụng", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            const SizedBox(height: 8,),
            const Text(
                "1. Bấm vào nút 'Tìm phòng học' ở góc dưới bên phải để chuyển sang trang tìm phòng",
                style: TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 8,),
            const Text(
                "2. Sau đó bấm vào nút Tìm hình kính lúp phía góc trên bên phải để mở hộp thoại nhập phòng",
                style: TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 8,),
            const Text(
                "3. Sau khi nhập phòng bấm nút tìm để tỉm đường",
                style: TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 10,),
            RichText(
              text: TextSpan(
                style: kGoogleFontBalooDa2.copyWith(fontSize: 16, color: Colors.black),
                children: const [
                  TextSpan(
                    text: "Xem thêm:",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: " Một số hình ảnh về trường CNTT & TT",
                  ),
                ]
              ),
            ),

            const SizedBox(height: 20,),

            Card(child: Image.asset("assets/truongCNTT.jpg")),
            Card(child: Image.asset("assets/SanhKhoa.jpg")),
            Card(child: Image.asset("assets/ThuVienKhoa.jpg")),
            Card(child: Image.asset("assets/VanNgheKhoa.jpg")),


          ],
        ),
      ),
    );
  }
}

