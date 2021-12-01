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

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        topScrolledPixelsNotifier.value = notification.metrics.pixels;
        return true;
      },
      child: WillPopScope(
        onWillPop: _handlePop,
        child: Scaffold(
          appBar: _buildAppBar(channel.name),
          body: ListView(padding: EdgeInsets.zero, children: [
            _buildTitle(channel),
            _buildSeriesList(channel),
            shouldLeaveSpace ? const SizedBox(height: 80) : Container()
          ]),
        ),
      ),
    );
  }

  _buildAppBar(String appBarTitle) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: ValueListenableBuilder<double>(
          valueListenable: topScrolledPixelsNotifier,
          builder: (context, value, child) {
            return AppTopBars.channelPage(
              topScrolledPixels: value,
              title: appBarTitle,
              isOpenedUsingLink: widget.isOpenedUsingLink,
            );
          }),
    );
  }

  _buildTitle(Channel channel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 15, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150,
          child: Row(children: [
            AppImage(image: channel.image, height: 150, width: 150, radius: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(channel.name,
                      alignment: TextAlign.start,
                      weight: FontWeight.w700,
                      maxLines: 4,
                      size: 28),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        ChannelActionButtons(() => bloc.share(ContentType.channel, channel.id)),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: AppRichText(
              text: AppText(channel.description, size: 16, maxLines: 4),
              useToggleExpansionButtons: true),
        )
      ]),
    );
  }

  _buildSeriesList(Channel channel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.dividerColor),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 10, 10, 8),
            child: AppText('Channel Series', size: 18, family: 'Louis'),
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
          padding: EdgeInsets.fromLTRB(18, index == 0 ? 0 : 10, 15, 0),
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
