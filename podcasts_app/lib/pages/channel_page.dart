import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/channel_page_bloc.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/channel_page_state.dart';
import 'package:podcasts/widgets/series_widget.dart';
import '../source.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage(this.channelName, {key}) : super(key: key);

  final String channelName;

  static void navigateTo(BuildContext context, {required String channelName}) {
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => ChannelPage(channelName)));
  }

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late final ChannelPageBloc bloc;
  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of(context, listen: false);
    bloc = ChannelPageBloc(service);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _handleWillPop,
        child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
  }

  _buildBody() {
    return BlocBuilder<ChannelPageBloc, ChannelPageState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(Channel channel, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildContent(Channel channel, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;
    log(shouldLeaveSpace.toString());
    return ListView(children: [
      _buildTitle(channel),
      _buildSeriesList(channel),
      shouldLeaveSpace ? const SizedBox(height: 80) : Container()
    ]);
  }

  Widget _buildFailed(Channel channel, Supplements supplements) {
    return _buildContent(channel, supplements);
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppTopBars.channelPage(context),
    );
  }

  _buildTitle(Channel channel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 15, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150,
          child: Row(children: [
            AppImage(
                image: channel.channelImage,
                height: 150,
                width: 150,
                radius: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(widget.channelName,
                      alignment: TextAlign.start, weight: 700, size: 25),
                  const SizedBox(height: 5),
                  AppText('by ' + channel.channelOwner,
                      size: 14, weight: 600, color: AppColors.onSecondary2),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ]),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: AppRichText(channel.channelDescription),
        )
      ]),
    );
  }

  _buildSeriesList(Channel channel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.separator),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 10, 10, 0),
            child: AppText('My Series',
                size: 18, weight: 400, family: FontFamily.casual),
          ),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: channel.channelSeriesList.map((e) {
              final index = channel.channelSeriesList.indexOf(e);
              return _buildSeries(e, index);
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildSeries(Series series, int index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      index == 0
          ? Container()
          : Container(height: 1, color: AppColors.separator),
      Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 15, 5),
          child: SeriesWidget(series)),
    ]);
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
