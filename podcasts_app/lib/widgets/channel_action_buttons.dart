import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text_button.dart';

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
            borderRadius: 5,
            text: 'Share',
            withIcon: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            borderColor: AppColors.disabledColor),
      ],
    );
  }
}
