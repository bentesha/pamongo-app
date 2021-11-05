import 'package:podcasts/source.dart';

enum Operations { addingToPlaylist, downloading, sharing, addingToFavourites }

class AppIconButton extends StatefulWidget {
  const AppIconButton(
      {required this.icon,
      required this.operation,
      required this.iconColor,
      required this.padding,
      key})
      : super(key: key);

  final IconData icon;
  final Color iconColor;
  final EdgeInsets padding;
  final Operations operation;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        padding: widget.padding,
        constraints: const BoxConstraints(),
        icon: Icon(widget.icon, color: widget.iconColor, size: 22));
  }
}
