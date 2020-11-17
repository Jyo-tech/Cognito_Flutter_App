import 'package:Cognito_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeepfakeAppBar extends StatefulWidget implements PreferredSizeWidget {
  DeepfakeAppBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _DeepfakeAppBarState createState() => _DeepfakeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

bool isDark = true;

class _DeepfakeAppBarState extends State<DeepfakeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        widget.title,
      ),
    );
  }
}
