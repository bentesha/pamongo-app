import 'package:podcasts/models/supplements.dart';
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

    return PopupMenuButton<int>(
        icon: const Icon(AppIcons.sort, size: 20),
        onSelected: onSelectedCallback,
        padding: EdgeInsets.zero,
        itemBuilder: (context) => [
              const PopupMenuItem(
                  height: 35,
                  enabled: false,
                  child: AppText("Sort by", weight: FontWeight.w600, size: 16),
                  value: 0),
              PopupMenuItem(
                  height: 35,
                  child: _buildPopupMenuItem(isLastToFirst, 'latest first'),
                  value: 1),
              PopupMenuItem(
                  height: 35,
                  child: _buildPopupMenuItem(isFirstToLast, 'oldest first'),
                  value: 2),
            ]);
  }

  _buildPopupMenuItem(bool isSelected, String text) {
    return Row(
      children: [
        Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.secondary : Colors.transparent)),
        const SizedBox(width: 10),
        AppText(text, size: 15),
      ],
    );
  }
}
