class Admin{
  late String email, userName, passWord;

  Admin({required this.email, required this.userName, required this.passWord});

  Admin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    passWord = json['passWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userName'] = userName;
    data['passWord'] = passWord;
    return data;
  }
}

Admin ad = Admin(email: "", userName: "", passWord: "");