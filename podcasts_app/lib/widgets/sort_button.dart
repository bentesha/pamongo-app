import 'package:podcasts/source.dart';

class SortButton extends StatelessWidget {
  const SortButton(
      {required this.sortStyle, required this.onSelectedCallback, key})
      : super(key: key);

  final SortStyles sortStyle;
  final void Function(int) onSelectedCallback;

  @override
  Widget build(BuildContext context) {
    final isFirstToLast = sortStyle == SortStyles.oldestFirst;
    final isLastToFirst = sortStyle == SortStyles.latestFirst;

    return SizedBox(
      height: 22.dh,
      child: PopupMenuButton<int>(
          icon: Icon(AppIcons.sort, size: 20.dw),
          onSelected: onSelectedCallback,
          padding: EdgeInsets.zero,
          color: AppColors.secondaryColor,
          itemBuilder: (context) => [
                PopupMenuItem(
                    height: 35.dh,
                    enabled: false,
                    child: AppText("Sort by",
                        weight: FontWeight.w600,
                        size: 16.w,
                        color: AppColors.onPrimary),
                    value: 0),
                PopupMenuItem(
                    height: 35.dh,
                    child: _buildPopupMenuItem(isLastToFirst, 'latest first'),
                    value: 1),
                PopupMenuItem(
                    height: 35.dh,
                    child: _buildPopupMenuItem(isFirstToLast, 'oldest first'),
                    value: 2),
              ]),
    );
  }

  _buildPopupMenuItem(bool isSelected, String text) {
    return Row(
      children: [
        Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(top: 3.dh),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? AppColors.accentColor : Colors.transparent)),
        SizedBox(width: 10.dw),
        AppText(text, size: 15.w, color: AppColors.onPrimary),
      ],
    );
  }
}
