import 'package:flutter_room_guide/models/post_model.dart';


class FindRoomModel {
  final String phongDi, phongDen;
  final List<Post>? duongDi;

  FindRoomModel({required this.phongDi, required this.phongDen, this.duongDi});

  List<Post> get getPosts => duongDi!;

}
