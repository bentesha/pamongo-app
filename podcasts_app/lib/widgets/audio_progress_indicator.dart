import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:podcasts/source.dart';

class AudioProgressIndicator extends StatefulWidget {
  const AudioProgressIndicator({key}) : super(key: key);

  @override
  State<AudioProgressIndicator> createState() => AudioProgressIndicatorState();
}

class AudioProgressIndicatorState extends State<AudioProgressIndicator> {
  final initialOffset = 806.3.dh;
  late final ProgressIndicatorBloc bloc;
  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of(context, listen: false);
    bloc = ProgressIndicatorBloc(service);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressIndicatorBloc, ProgressIndicatorState>(
        bloc: bloc,
        listener: (context, state) {
          final error =
              state.maybeWhen(failed: (_, __, e) => e, orElse: () => null);

          if (error != null) _showError(error);
        },
        builder: (_, state) {
          return state.when(
              active: _buildContent,
              failed: _buildFailed,
              initial: _buildInitial);
        });
  }

  Widget _buildContent(ProgressIndicatorContent content, bool isHiding) {
    return !isHiding
        ? Stack(
            children: [
              Positioned(
                top: initialOffset,
                child: SizedBox(
                  height: 60.dh,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    child: GestureDetector(
                      onTap: _onTap,
                      child: _indicatorContent(content),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _buildFailed(
      ProgressIndicatorContent content, bool isHiding, AudioError error) {
    return _buildContent(content, isHiding);
  }

  Widget _buildInitial(ProgressIndicatorContent content, bool isHiding) {
    return Container();
  }

  _indicatorContent(ProgressIndicatorContent content) {
    final episode = content.episodeList[content.currentIndex];
    final fullWidth = MediaQuery.of(context).size.width;
    final loadingWidth = content.currentPosition * fullWidth / episode.duration;
    final playerState = content.playerState;
    final isIntroEpisode = episode.episodeNumber == 0;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          color: AppColors.indicatorColor,
          height: 60.dh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 8.dw),
                child: playerState.isLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.dw),
                        child: Lottie.asset('assets/icons/loading_2.json',
                            fit: BoxFit.contain, height: 25.dh),
                      )
                    : IconButton(
                        onPressed: bloc.togglePlayerStatus,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                            playerState.isPlaying
                                ? Icons.pause_circle
                                : Ionicons.play_circle,
                            color: AppColors.secondaryColor,
                            size: 35.dw)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(episode.title,
                        size: 15.w,
                        weight: FontWeight.w600,
                        alignment: TextAlign.start),
                    !isIntroEpisode ? SizedBox(height: 3.dh) : Container(),
                    !isIntroEpisode
                        ? AppText(
                            'Ep. ${episode.episodeNumber} from - ${episode.seriesName}',
                            alignment: TextAlign.start,
                            color: AppColors.textColor2,
                            size: 15.w)
                        : Container()
                  ],
                ),
              ),
              AppIconButton(
                margin: EdgeInsets.only(left: 20.dw, right: 20.dw),
                icon: EvaIcons.shareOutline,
                iconSize: 20.dw,
                onPressed: () => bloc.share(episode.id),
              ),
            ],
          ),
        ),
        Container(
            height: 4.dh,
            color: AppColors.accentColor,
            width: content.currentPosition == 0 ? 0 : loadingWidth)
      ],
    );
  }

  _showError(AudioError error) async {
    Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.onPrimary);
  }

  void _onTap() {
    bloc.toggleVisibilityStatus();
    Navigator.of(context)
        .push(CustomPageTransition(child: PlayingEpisodePage(bloc)));
  }
}
