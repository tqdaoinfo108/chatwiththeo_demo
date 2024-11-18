import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.type});
  final int type;

  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [];
    var assetImage = "";
    var title = "";
    switch (type) {
      case 1:
        gradient = [
          const Color.fromRGBO(236, 90, 90, 1),
          const Color.fromRGBO(134, 51, 51, 1)
        ];
        assetImage = "assets/icon/icon1.png";
        title = "THẤU HIỂU\nBẢN THÂN";
        break;
      case 2:
        gradient = [
          const Color.fromRGBO(109, 106, 240, 1),
          const Color.fromRGBO(62, 61, 138, 1)
        ];
        assetImage = "assets/icon/icon2.png";
        title = "QUẢN TRỊ\nBẢN THÂN";

        break;
      case 3:
        gradient = [
          const Color.fromRGBO(120, 180, 74, 1),
          const Color.fromRGBO(52, 78, 32, 1)
        ];
        assetImage = "assets/icon/icon3.png";
        title = "PHÁT TRIỂN\nMỚI QUAN HỆ";

        break;
      case 4:
        gradient = [
          const Color.fromRGBO(236, 150, 70, 1),
          const Color.fromRGBO(134, 85, 39, 1)
        ];
        assetImage = "assets/icon/icon4.png";
        title = "ĐẶT LỊCH\nTRÒ CHUYỆN";

        break;
    }
    // Figma Flutter Generator Rectangle6419Widget - RECTANGLE
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 10.600000381469727)
          ],
          gradient: LinearGradient(
              begin: const Alignment(6.123234262925839e-17, 1),
              end: const Alignment(-1, 6.123234262925839e-17),
              colors: gradient),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(assetImage, height: 75, fit: BoxFit.contain),
            const SizedBox(height: 5),
            Text(
              title,
              style: AppTheme.titleMedium,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
