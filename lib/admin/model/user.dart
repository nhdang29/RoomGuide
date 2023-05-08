class User {
  late String maSo;
  late String matKhau;
  late String ten;
  late String? email;

  User({required this.maSo,required this.matKhau,required this.ten, this.email});

  User.fromJson(Map<String, dynamic> json) {
    maSo = json['mssv'];
    matKhau = json['matKhau'];
    ten = json['ten'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mssv'] = maSo;
    data['matKhau'] = matKhau;
    data['ten'] = ten;
    data['email'] = email;
    return data;
  }

  String get getMssv => maSo;
  String get getTen => ten;
  void setTen(String nn){
    ten = nn ;
  }
}
late User currentUser;
