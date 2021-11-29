import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:podcasts/blocs/progress_indicator_bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/states/progress_indicator_state.dart';
import 'package:podcasts/widgets/custom_page_transition.dart';

class AudioProgressIndicator extends StatefulWidget {
  const AudioProgressIndicator({key}) : super(key: key);

  @override
  State<AudioProgressIndicator> createState() => AudioProgressIndicatorState();
}

class AudioProgressIndicatorState extends State<AudioProgressIndicator> {
  final initialOffset = 796.3.dh;
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
                  height: 70.dh,
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
    final isPlaying = content.playerState == playingState;
    final isLoading = content.playerState == loadingState;
    final isIntroEpisode = episode.episodeNumber == 0;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          color: AppColors.indicatorColor,
          height: 70.dh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.dw),
                child: AppImage(
                    image: episode.image,
                    radius: 7.dw,
                    height: 50.h,
                    width: 50.h,
                    withBorders: true),
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
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 12.dw),
                child: isLoading
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.dw),
                        child: Lottie.asset('assets/icons/loading_2.json',
                            fit: BoxFit.contain, height: 25.dh),
                      )
                    : IconButton(
                        onPressed: bloc.togglePlayerStatus,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                            isPlaying
                                ? Icons.pause_circle
                                : Ionicons.play_circle,
                            color: AppColors.secondaryColor,
                            size: 35.dw)),
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
