import 'package:flutter/material.dart';
import '../models/find_room_model.dart';
import './components/custom_post_card.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({required this.model, Key? key}) : super(key: key);

  static const String routeName = "/guideScreen";

  final FindRoomModel model;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guiding"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5,),
              Text("Đường đi từ phòng ${model.phongDi} đến ${model.phongDen}", style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              const SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: model.duongDi!.map((e) => CustomPostCard(img: e.img, moTa: e.moTa)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
