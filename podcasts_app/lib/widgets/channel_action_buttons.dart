import 'package:podcasts/source.dart';

class ChannelActionButtons extends StatelessWidget {
  final VoidCallback shareCallback;
  const ChannelActionButtons(this.shareCallback, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildShareButton();
  }

  _buildShareButton() {
    return Row(
      children: [
        AppTextButton(
            onPressed: shareCallback,
            borderRadius: 5.dw,
            text: 'Share',
            withIcon: true,
            isBolded: true,
            padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dw),
            borderColor: AppColors.disabledColor),
      ],
    );
  }
}
