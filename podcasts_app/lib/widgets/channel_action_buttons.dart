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
    return SizedBox(
      width: 116,
      child: AppTextButton(
        callback: shareCallback,
        radius: 5,
        text: 'Share',
        withIcon: true,
      ),
    );
  }
}
