import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.implyLeading = true,
    this.actions,
    this.icon,
  });

  final String? title;
  final String? icon;
  final bool implyLeading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: implyLeading
          ? Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      width: 35,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          icon ?? 'assets/svg/prev.svg',
                          color: Colors.black,
                        ),
                      ),
                    )),
              ],
            )
          : null,
      title: Text(
        title ?? '',
        style: const TextStyle(fontSize: 17),
      ),
      actions: [if (actions != null) Row(children: actions!)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
