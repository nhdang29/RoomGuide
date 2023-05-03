import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './model/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "/login";


  @override
  Widget build(BuildContext context) {

    final TextEditingController nameController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng nhập",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 40,),

              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Image.asset("assets/logoCICT.jpg", width: 150,),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Tài khoản',
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Mật khẩu',
                  ),
                ),
              ),

              const SizedBox(height: 40,),

              Container(
                  height: 80,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Đăng nhập',style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      if(nameController.text.isNotEmpty){

                        FirebaseFirestore.instance.collection("users").doc(nameController.text.toLowerCase()).get()
                            .then((DocumentSnapshot documentSnapshot) {
                          if(documentSnapshot.exists){
                            if( documentSnapshot.get("matKhau") == passController.text ) {
                              // Tai khoan & mat khau dung

                              currentUser = User(
                                maSo: documentSnapshot.get("maSo"),
                                matKhau: documentSnapshot.get("matKhau"),
                                ten: documentSnapshot.get("ten"),
                                email: documentSnapshot.get("email"),
                              );


                              Navigator.pushNamedAndRemoveUntil(context, "/admin", (route) => false);

                            } else{
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text(
                                    "Mật khẩu sai!"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else{
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Tên đăng nhập không đúng!"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }).then((value){
                          nameController.clear();
                          passController.clear();
                        });

                      }

                    },
                  )),

              TextButton(
                onPressed: null,
                child: Text(
                  'Quên mật khẩu?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


