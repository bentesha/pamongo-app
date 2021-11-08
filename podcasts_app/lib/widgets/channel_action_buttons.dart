import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text_button.dart';

class ChannelActionButtons extends StatelessWidget {
  const ChannelActionButtons({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [_buildSubscribeButton(), _buildShareButton()]);
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share);
  }

  _buildSubscribeButton() {
    return AppTextButton(callback: () {}, text: 'Subscribe', radius: 5.dw);
  }

  _iconButton(IconData icon) {
    return IconButton(
        onPressed: () {},
        padding: EdgeInsets.only(right: 15.dw),
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: AppColors.primaryColor, size: 22.dw));
  }
}
