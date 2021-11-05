import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/channel_page_bloc.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/channel_page_state.dart';
import 'package:podcasts/widgets/channel_action_buttons.dart';
import 'package:podcasts/widgets/error_screen.dart';
import 'package:podcasts/widgets/series_widget.dart';
import '../source.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage(this.channelId, {key}) : super(key: key);

  final String channelId;

  static void navigateTo(BuildContext context, {required String channelId}) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => ChannelPage(channelId)));
  }

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late final ChannelPageBloc bloc;
  late final AudioPlayerService service;
  final topScrolledPixelsNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    service = Provider.of(context, listen: false);
    bloc = ChannelPageBloc(service);
    bloc.init(widget.channelId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelPageBloc, ChannelPageState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildContent(Channel channel, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        topScrolledPixelsNotifier.value = notification.metrics.pixels;
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(channel.channelName),
        body: ListView(padding: EdgeInsets.zero, children: [
          _buildTitle(channel),
          _buildSeriesList(channel),
          shouldLeaveSpace ? SizedBox(height: 80.dh) : Container()
        ]),
      ),
    );
  }

  _buildAppBar(String appBarTitle) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.dh),
      child: ValueListenableBuilder<double>(
          valueListenable: topScrolledPixelsNotifier,
          builder: (context, value, child) {
            return AppTopBars.channelPage(
                topScrolledPixels: value, title: appBarTitle);
          }),
    );
  }

  _buildTitle(Channel channel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 15.dw, 10.dh),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150.dh,
          child: Row(children: [
            AppImage(
                image: channel.channelImage,
                height: 150.w,
                width: 150.w,
                radius: 10),
            SizedBox(width: 10.dw),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(channel.channelName,
                      alignment: TextAlign.start,
                      weight: FontWeight.w700,
                      maxLines: 4,
                      size: 28.w),
                  SizedBox(height: 5.dh),
                ],
              ),
            ),
          ]),
        ),
        SizedBox(height: 10.dh),
        const ChannelActionButtons(),
        Padding(
          padding: EdgeInsets.only(right: 10.dw),
          child: AppRichText(
              text:
                  AppText(channel.channelDescription, size: 16.w, maxLines: 4),
              useToggleExpansionButtons: true),
        )
      ]),
    );
  }

  _buildSeriesList(Channel channel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.dw, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.dividerColor),
          Padding(
            padding: EdgeInsets.fromLTRB(18.dw, 10.dw, 10.dh, 0),
            child: AppText('Channel Series', size: 18.w, family: 'Louis'),
          ),
          SizedBox(height: 8.dh),
          ListView.builder(
              itemCount: channel.channelSeriesList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return _buildSeries(channel.channelSeriesList[index], index);
              })
        ],
      ),
    );
  }

  Widget _buildSeries(Series series, int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      index == 0
          ? Container()
          : Container(height: 1, color: AppColors.dividerColor),
      Padding(
          padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 15.dw, 0),
          child: SeriesWidget(series)),
    ]);
  }

  Widget _buildLoading(Channel channel, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildFailed(Channel channel, Supplements supplements) =>
      ErrorScreen(supplements.apiError!,
          refreshCallback: () => bloc.init(widget.channelId));
}
