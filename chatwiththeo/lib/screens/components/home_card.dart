import 'package:chatwiththeo/model/categories_model.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.data,
  });
  final CategoryModel data;
  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [
      Color(int.parse("0xff${data.bGColor1}")),
      Color(int.parse("0xff${data.bGColor2}"))
    ];
    var assetImage = "assets/icon/icon1.png";
    var title = data.categoryName?.replaceAll("\\n", "\n");
  
    // Figma Flutter Generator Rectangle6419Widget - RECTANGLE
    return InkWell(
      onTap: () => context.push("/home", extra: data.categoryID),
      child: Container(
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
                title ?? "",
                style:
                    AppTheme.titleMedium.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
