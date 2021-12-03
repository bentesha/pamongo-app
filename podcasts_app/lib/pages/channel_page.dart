import '../source.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage(this.channelId, {this.isOpenedUsingLink = false, key})
      : super(key: key);

  final String channelId;
  final bool isOpenedUsingLink;

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

    return WillPopScope(
        onWillPop: _handlePop,
        child: AppListView(
          thresholdOffset: 130.0,
            backArrowCallback: widget.isOpenedUsingLink
                ? () => Homepage.navigateTo(context)
                : null,
            header: channel.name,
            children: [
              _buildTitle(channel),
              _buildSeriesList(channel),
              shouldLeaveSpace ? SizedBox(height: 80.dh) : Container()
            ]));
  }

  _buildTitle(Channel channel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 15.dw, 10.dh),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150.dh,
          child: Row(children: [
            AppImage(
                image: channel.image, height: 150.w, width: 150.w, radius: 10),
            SizedBox(width: 10.dw),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(channel.name,
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
        SizedBox(height: 15.dh),
        ChannelActionButtons(() => bloc.share(ContentType.channel, channel.id)),
        Padding(
          padding: EdgeInsets.only(right: 10.dw, top: 10.dh),
          child: AppRichText(
              text: AppText(channel.description, size: 16.w, maxLines: 4),
              useToggleExpansionButtons: true),
        )
      ]),
    );
  }

  _buildSeriesList(Channel channel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5.dw, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.dividerColor),
          Padding(
            padding: EdgeInsets.fromLTRB(18.dw, 10.dw, 10.dh, 8.dh),
            child: AppText('Channel Series', size: 18.w, family: 'Louis'),
          ),
          ListView.builder(
              itemCount: channel.seriesList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return _buildSeries(channel.seriesList[index], index);
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
          padding: EdgeInsets.fromLTRB(18.dw, index == 0 ? 0 : 10.dh, 15.dw, 0),
          child: SeriesWidget(series,
              shareCallback: () => bloc.share(ContentType.series, series.id))),
    ]);
  }

  Widget _buildLoading(Channel channel, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildFailed(Channel channel, Supplements supplements) =>
      ErrorScreen(supplements.apiError!,
          refreshCallback: () => bloc.init(widget.channelId));

  /// pushes to homepage if app is opened using the link, otherwise normal
  /// behaviour applies.
  Future<bool> _handlePop() async {
    if (widget.isOpenedUsingLink) Homepage.navigateTo(context);
    return true;
  }
}
