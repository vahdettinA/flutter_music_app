import 'package:flutter/material.dart';
import 'package:flutter_music_app/product/theme/mytheme.dart';

class ListileLeading extends StatelessWidget {
  const ListileLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: MyTheme.white,
        boxShadow: [
          BoxShadow(
              color: MyTheme.white,
              blurStyle: BlurStyle.solid,
              blurRadius: 10,
              offset: Offset(0, 2))
        ],
      ),
      child: Icon(
        Icons.music_note,
        color: MyTheme.backgroundColor,
      ),
    );
  }
}
