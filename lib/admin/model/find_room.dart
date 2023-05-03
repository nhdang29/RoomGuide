class FindRoom {
  String? phongDen;
  String? phongDi;
  String? nguoiDang;
  String? repoName;
  List<DuongDi>? duongDi;

  FindRoom(
      {this.phongDen,
        this.phongDi,
        this.nguoiDang,
        this.repoName,
        this.duongDi});

  FindRoom.fromJson(Map<String, dynamic> json) {
    phongDen = json['phongDen'];
    phongDi = json['phongDi'];
    nguoiDang = json['nguoiDang'];
    repoName = json['repoName'];
    if (json['duongDi'] != null) {
      duongDi = <DuongDi>[];
      json['duongDi'].forEach((v) {
        duongDi!.add(DuongDi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phongDen'] = phongDen;
    data['phongDi'] = phongDi;
    data['nguoiDang'] = nguoiDang;
    data['repoName'] = repoName;
    if (duongDi != null) {
      data['duongDi'] = duongDi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DuongDi {
  String? img;
  String? moTa;
  String? imgName;

  DuongDi({this.img, this.moTa, this.imgName});

  DuongDi.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    moTa = json['moTa'];
    imgName = json['imgName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['moTa'] = moTa;
    data['imgName'] = imgName;
    return data;
  }
}
