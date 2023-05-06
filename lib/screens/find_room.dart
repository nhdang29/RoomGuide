import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_room_guide/models/find_room_model.dart';
import 'package:flutter_room_guide/models/post_model.dart';
import 'package:flutter_room_guide/screens/export_screens.dart';


class FindRoomPage extends StatefulWidget {
  const FindRoomPage({Key? key}) : super(key: key);
  static const String routeName = "/findRoomPage";
  static String pdi = "", pden = "";

  @override
  State<FindRoomPage> createState() => _FindRoomPageState();
}

class _FindRoomPageState extends State<FindRoomPage> {
  @override
  Widget build(BuildContext context) {

    TextEditingController fromRoomController = TextEditingController();
    TextEditingController toRoomController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Room"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: (){
              showDialog(context: context,builder: (context) => AlertDialog(
                title: const Text(
                  "Nhập vào vị trí phòng đang đứng và phòng muốn đến",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: fromRoomController,
                        decoration: const InputDecoration(
                          iconColor: Colors.blue,
                          labelText: "Phòng đi",
                          icon: Icon(Icons.room),
                        ),
                      ),
                      TextField(
                        controller: toRoomController,
                        decoration: const InputDecoration(
                          iconColor: Colors.blue,
                          labelText: "Phòng đến",
                          icon: Icon(Icons.door_back_door),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Hủy',style: TextStyle(color: Colors.red),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Tìm phòng', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      setState(() {
                        FindRoomPage.pdi = fromRoomController.value.text;
                        FindRoomPage.pden = toRoomController.value.text;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
            },
          ),
        ],
      ),
      body: FindRoomScreen(phongDi: FindRoomPage.pdi, phongDen: FindRoomPage.pden),
    );
  }
}



class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({required this.phongDi, required this.phongDen, Key? key}) : super(key: key);

  final String phongDi, phongDen;

  @override
  Widget build(BuildContext context) {

    CollectionReference findRoom = FirebaseFirestore.instance.collection("FindRoom");

    return FutureBuilder(
      future: findRoom.where("phongDi", isEqualTo: phongDi).where("phongDen", isEqualTo: phongDen).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.hasError) {
          return const Text("Đã có lỗi xảy ra, mong bạn thông cảm :((");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasData && snapshot.data!.docs.isEmpty){
          // return const Center(child: Text("Không có dữ liệu"),);
          return buildEmptyData();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          List<dynamic> duongDi = data["duongDi"] ;
          FindRoomModel findRoom = FindRoomModel(
            phongDi: data['phongDi'],
            phongDen: data['phongDen'],
            duongDi: duongDi.map((e) => Post(img: e["img"], moTa: e["moTa"])).toList(),
          );


          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                splashColor: const Color(0xff332FD0),
                isThreeLine: true,
                tileColor: Colors.grey[200],
                title: Text("Đường đi từ ${findRoom.phongDi} đến ${findRoom.phongDen}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    Text("${findRoom.duongDi!.length} bước đi"),
                    const SizedBox(height: 3,),
                    Text("Người đăng: ${data["nguoiDang"]}"),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios,color: Color(0xff0002A1),),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GuideScreen(model: findRoom,)));
                },
              ),
            ),
          );
        }).toList(),
        );
      },
    );
  }

  Widget buildEmptyData() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const SizedBox(height: 25,),
        const Text("Hướng dẫn sử dụng ứng dụng", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
        const SizedBox(height: 8,),
        const Text(
            "Để dễ dàng tìm phòng thì cách đặt tên phòng của Trường sẽ lấy theo số lầu",
            style: TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 8,),
        const Text(
            "Phòng ở lầu 1 sẽ có số phòng là 101, 102, .... Ngoài ra ở lầu 1 còn có Trung tâm điện tử và tin học, Phòng giám đốc, các phòng thuộc các chuyên ngành.",
            style: TextStyle(fontSize: 16)
        ),
        const SizedBox(height: 8,),
        const Text(
            "Để tìm được phòng thì bạn cần nhập vào số phòng mà bạn muốn đến, để đi đến các phòng như là trung tâm điện tử tin học thì nhập vào \"trung tâm điện tử tin học\"",
            style: TextStyle(fontSize: 16)
        ),

        const SizedBox(height: 25,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Chúc bạn học tập thật tốt!",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18), ),
          ],
        ),
      ],
    ),
  );


}



