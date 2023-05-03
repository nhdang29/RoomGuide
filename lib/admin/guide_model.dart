class GuideModel {
  List<DuongDi>? duongDi;
  String? phongDi;
  String? phongDen;

  GuideModel({this.duongDi, this.phongDi, this.phongDen});

  GuideModel.fromJson(Map<String, dynamic> json) {
    if (json['duongDi'] != null) {
      duongDi = <DuongDi>[];
      json['duongDi'].forEach((v) {
        duongDi!.add(DuongDi.fromJson(v));
      });
    }
    phongDi = json['phongDi'];
    phongDen = json['phongDen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (duongDi != null) {
      data['duongDi'] = duongDi!.map((v) => v.toJson()).toList();
    }
    data['phongDi'] = phongDi;
    data['phongDen'] = phongDen;
    return data;
  }
}

class DuongDi {
  String? img;
  String? moTa;

  DuongDi({this.img, this.moTa});

  DuongDi.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    moTa = json['moTa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img'] = img;
    data['moTa'] = moTa;
    return data;
  }
}
