import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.imageUrl,
    required this.user,
    required this.nickName,
    this.textColor,
  }) : super(key: key);
  final String? imageUrl;
  final String? user;
  final String? nickName;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKpeDKUVlK_AzUItjz2AGCxLCRqIsSk-2iLw&usqp=CAU',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nickName ?? '',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor ?? Colors.black,
              ),
            ),
            Text(
              user ?? '',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
