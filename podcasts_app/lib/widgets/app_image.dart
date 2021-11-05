import 'package:podcasts/source.dart';

class AppImage extends StatelessWidget {
  final String image;
  final int width, height;
  final double radius;
  final bool fullWidth, leaveHeight, withBorders;
  const AppImage(
      {Key? key,
      required this.radius,
      required this.image,
      this.height = 180,
      this.fullWidth = false,
      this.leaveHeight = false,
      this.withBorders = false,
      this.width = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(radius));
    return leaveHeight
        ? Container(
            width: fullWidth ? double.maxFinite : width.toDouble(),
            decoration: BoxDecoration(
                borderRadius: borderRadius, color: AppColors.dividerColor),
            child: Stack(
              children: [
                Container(
                    constraints: const BoxConstraints.expand(),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.podcasts,
                      size: 25,
                    )),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            image,
                          )),
                      borderRadius: borderRadius,
                      color: Colors.transparent),
                ),
              ],
            ),
          )
        : Container(
            height: height.toDouble(),
            width: fullWidth ? double.maxFinite : width.toDouble(),
            decoration: BoxDecoration(
                border: withBorders
                    ? Border.all(width: 1, color: Colors.transparent)
                    : Border.all(width: 0, color: Colors.transparent),
                borderRadius: borderRadius,
                color: AppColors.dividerColor),
            child: Stack(
              children: [
                Container(
                    constraints: const BoxConstraints.expand(),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.podcasts,
                      size: 25,
                    )),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            image,
                          )),
                      borderRadius: borderRadius,
                      color: Colors.transparent),
                ),
              ],
            ),
          );
  }
}
