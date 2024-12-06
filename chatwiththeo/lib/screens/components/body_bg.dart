import 'package:flutter/material.dart';

class BackgroundBody extends StatelessWidget {
  const BackgroundBody({super.key, required this.body, this.paddingHorizontal});
  final Widget body;
  final double? paddingHorizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      child: body,
    );
  }
}
