import 'package:flutter/material.dart';
import 'guide_management.dart';
import 'add_guide.dart';
import 'package:flutter_room_guide/contrast.dart';

class AdminPage extends StatelessWidget {

  static String routeName = "/admin";

  const AdminPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
      ),
      body: const AdminScreen(),
    );
  }
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddGuide()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryColor,
              minimumSize: const Size(220, 50)
            ),
            child: const Text("Thêm hướng dẫn"),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GuideManagement()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: kSecondaryColor,minimumSize: const Size(220, 50)),
            child: const Text("Quản lý các hướng dẫn"),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: kDangerColor,minimumSize: const Size(220, 50)),
            child: const Text("Thoát"),
          ),
        ],
      ),
    );
  }
}



