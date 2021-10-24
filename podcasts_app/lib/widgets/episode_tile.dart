import 'package:podcasts/models/episode.dart';
import 'package:podcasts/source.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile(this.page,
      {required this.actionPadding,
      required this.episode,
      required this.playCallback,
      required this.status,
      required this.duration,
      key})
      : super(key: key);

  final Pages page;
  final EdgeInsetsGeometry actionPadding;
  final Episode episode;
  final VoidCallback playCallback;
  final String status, duration;

  @override
  Widget build(BuildContext context) {
    final bool isDescriptionFirst = page == Pages.homepage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EpisodeTitle(
          title: episode.title,
          seriesName: episode.seriesName,
          date: episode.date,
          image: episode.image,
        ),
        isDescriptionFirst ? Container() : _buildActions(playCallback),
        AppText(episode.description,
            family: FontFamily.workSans,
            color: AppColors.onSecondary2,
            size: 15.w),
        isDescriptionFirst ? _buildActions(playCallback) : Container(),
      ],
    );
  }

  _buildActions(VoidCallback playCallback) {
    return EpisodeActionButtons(page,
        playCallback: playCallback,
        status: status,
        duration: duration,
        actionPadding: actionPadding);
  }
}
