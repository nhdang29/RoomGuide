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
      future: findRoom.where("phongDi",isEqualTo: phongDi).where("phongDen", isEqualTo: phongDen).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

        if (snapshot.hasError) {
          return const Text("Đã có lỗi xảy ra, mong bạn thông cảm :((");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasData && snapshot.data!.docs.isEmpty){
          return const Center(child: Text("Không có dữ liệu"),);
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
}



// class MyDialogBox extends StatefulWidget {
//   const MyDialogBox({Key? key}) : super(key: key);
//
//   @override
//   State<MyDialogBox> createState() => _MyDialogBoxState();
// }
//
// class _MyDialogBoxState extends State<MyDialogBox> {
//   @override
//   Widget build(BuildContext context) {
//
//     TextEditingController phongDiController = TextEditingController();
//     TextEditingController phongDenController = TextEditingController();
//
//     String soPhongDi = "", soPhongDen = "";
//
//     return AlertDialog(
//       title: const Text("Bạn hãy nhập vào phòng đi và đến", style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w500,
//       ),),
//       content: Column(
//         children: [
//           TextField(
//             controller: phongDiController,
//             decoration: const InputDecoration(
//               iconColor: Colors.blue,
//               labelText: "Phòng đi",
//               icon: Icon(Icons.room),
//             ),
//           ),
//           TextField(
//             controller: phongDenController,
//             decoration: const InputDecoration(
//               labelText: "Phòng đến",
//               icon: Icon(Icons.door_back_door),
//               iconColor: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 5,),
//           ElevatedButton(onPressed: (){ setState(() {
//             soPhongDi = phongDiController.value.text;
//             soPhongDen = phongDenController.value.text;
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) => FindRoomScreen(phongDi: soPhongDi, phongDen: soPhongDen)));
//
//           }); }, child: const Text("Tìm")),
//         ],
//       ),
//     );
//   }
// }