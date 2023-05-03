import 'package:flutter/material.dart';
import 'package:flutter_room_guide/contrast.dart';

class CustomPostCard extends StatelessWidget {
  const CustomPostCard({required this.img, required this.moTa, Key? key})
      : super(key: key);

  final String img, moTa;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              img,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: kLoadingColor,
                  ),
                );
              },
            ),
            const Divider(),
            Text(moTa),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
