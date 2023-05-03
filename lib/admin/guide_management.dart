import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import './model/find_room.dart';

class GuideManagement extends StatelessWidget {
  const GuideManagement({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý các đường đi"),
      ),
      body: const GuideManagementScreen(),
    );
  }
}

class GuideManagementScreen extends StatelessWidget {
  const GuideManagementScreen({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {
    return FirestoreListView(
      query: FirebaseFirestore.instance.collection('FindRoom').orderBy('phongDi')
          .withConverter(
            fromFirestore: (snapshot, _) => FindRoom.fromJson(snapshot.data()!),
            toFirestore: (findroom, _) => findroom.toJson()
      ),
      padding: const EdgeInsets.all(8.0),

      loadingBuilder: (context){
        return const Center(child: CircularProgressIndicator());
      },

      emptyBuilder: (context){
        return const Center(
          child: Text("Không có dữ liệu"),
        );
      },

      itemBuilder: (context, snapshot){

        FindRoom fr = snapshot.data();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text("Tên repo:"),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("${fr.repoName}"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text("Đường đi từ:"),

                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: Text("${fr.phongDi} - ${fr.phongDen}"),

                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('FindRoom').doc(snapshot.id).delete();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150,35),
                  ),
                  child: const Text("Xóa"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

