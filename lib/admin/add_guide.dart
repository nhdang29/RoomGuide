import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/find_room.dart';
import '../contrast.dart';
import './model/user.dart';

class AddGuide extends StatelessWidget {

  const AddGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Guide"),
      ),
      body: const AddGuideScreen(),
    );
  }
}

class AddGuideScreen extends StatefulWidget {
  const AddGuideScreen({Key? key}) : super(key: key);

  @override
  State<AddGuideScreen> createState() => _AddGuideScreenState();
}

class _AddGuideScreenState extends State<AddGuideScreen> {

  List<DuongDi> duongdi = [];



  @override
  Widget build(BuildContext context) {


    TextEditingController startController = TextEditingController();
    TextEditingController endController = TextEditingController();
    TextEditingController moTaController = TextEditingController();

    FindRoom fr = FindRoom();

    // dat ten thu muc hinh la: "repo" + ngay gio tao
    String repoName = "${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}";
    fr.repoName = "repo$repoName";


    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: startController,
              decoration: const InputDecoration(
                icon: Icon(Icons.room),
                labelText: "Chọn điểm bắt đầu",
              ),
            ),
            const SizedBox(height: 5,),
            TextField(
              controller: endController,
              decoration: const InputDecoration(
                icon: Icon(Icons.room),
                labelText: "Chọn điểm kết thúc",
              ),
            ),
            const SizedBox(height: 15,),
            const Divider(),


            Column(
              children: duongdi.isEmpty ? [const Text("Thêm đường đi")] : duongdi.map(
                // Card detail show thong tin cua 1 huong dan
                      (DuongDi d) => Card(
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(d.img!),
                              const Divider(),
                              Text(d.moTa!),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xffFB2576)),
                                    ),


                                    onPressed:(){
                                      //xoa phan tu tren firebase storage
                                      FirebaseStorage.instance.ref().child(fr.repoName!).child(d.imgName!).delete()
                                          .then((value){
                                        setState((){
                                          duongdi.remove(d); //xoa phan tu trong local
                                        });
                                      });

                                    },
                                    child: const Text("delete",style: TextStyle(color: Color(0xffFB2576)),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )


              ).toList(),
            ),
            const SizedBox(height: 10,),

            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: ()  {

                DuongDi itemDuongDi = DuongDi();
                itemDuongDi.imgName = DateTime.now().millisecondsSinceEpoch.toString(); // img name



                showDialog(context: context, builder: (context){
                  return StatefulBuilder(builder: (context, setStateChild){ // dung setState trong dialogbox

                    pickFromGallery() async {
                      // xu li chup anh dang fire storage o day

                      // image picker
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                      if(file == null) return;

                      // get reference
                      Reference rootRef = FirebaseStorage.instance.ref().child(fr.repoName!); // tao ref cho thu muc
                      Reference imageRef = rootRef.child(itemDuongDi.imgName!);  // tao ref cho anh

                      // store file

                      try {
                        await imageRef.putFile(File(file.path));
                        // download url
                        itemDuongDi.img = await imageRef.getDownloadURL();
                        setStateChild(() {});
                      } on FirebaseException {
                        // ...
                      }
                    }


                    return AlertDialog(
                      title: const Text(
                        "Thêm thông tin hướng dẫn đường đi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            // chon hinh
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.image_outlined),
                                  onPressed: pickFromGallery,
                                ),
                                (itemDuongDi.img != null) ? Flexible(
                                  child: Text(
                                      itemDuongDi.imgName!,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                                    : const Text("No image picked!"),

                              ],
                            ),


                            TextField(  // nhap mo ta
                              controller: moTaController,
                              decoration: const InputDecoration(
                                iconColor: kSecondaryColor,
                                labelText: "Mô tả",
                                icon: Icon(Icons.note_alt),
                              ),
                            ),
                          ],
                        ),
                      ),

                      actions: [

                        TextButton(
                          child: const Text('Hủy',style: TextStyle(color: kDangerColor, fontWeight: FontWeight.w600),), // alert dialog cancel btn
                          onPressed: () {
                            moTaController.clear();
                            FirebaseStorage.instance.ref().child(fr.repoName!).child(itemDuongDi.imgName!).delete();
                            Navigator.of(context).pop();
                          },
                        ),

                        TextButton(
                          child: const Text('Thêm', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600)), // alert dialog ok btn
                          onPressed: () {

                            if(moTaController.value.text.isEmpty || itemDuongDi.img == null ){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Bạn phải nhập đầy đủ thông tin!"),
                                backgroundColor: kDangerColor,
                              ));
                              moTaController.clear();
                              Navigator.of(context).pop();
                              return;
                            }

                            itemDuongDi.moTa = moTaController.value.text;
                            setState(() {
                              duongdi.add(itemDuongDi);
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });

                  //ket thuc show dialog
                });
              }
            ),



            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {  // cancel btn add guide screen
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDangerColor,
                  ),
                  child: const Text("Hủy bỏ"),
                ),
                const SizedBox(width: 10,),

                ElevatedButton(
                  onPressed: () { // ok btn add guide screen
                    fr.phongDi = startController.value.text;
                    fr.phongDen = endController.value.text;
                    fr.nguoiDang = currentUser.ten;
                    fr.duongDi = duongdi;

                    if(fr.phongDi!.isEmpty || fr.phongDen!.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Bạn phải điền đầy đủ nơi bắt đầu và nơi đến"),
                        backgroundColor: kDangerColor,
                      ));
                    }
                    else {

                      FirebaseFirestore.instance.collection("FindRoom").add(fr.toJson())
                          .then((value) {
                        Navigator.of(context).pop();
                      }) .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Thêm thành công"), backgroundColor: kLoadingColor,)));

                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor
                  ),
                  child: const Text("Thêm"),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }



}
