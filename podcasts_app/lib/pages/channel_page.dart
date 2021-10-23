import 'package:flutter/cupertino.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/pages/series_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: ListView(children: [_buildTitle(), _buildSeriesList()]));
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppTopBars.channelPage(context),
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 15, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150,
          child: Row(children: [
            AppImage(image: channel.channelImage, height: 150, width: 150),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(widget.channelName,
                      alignment: TextAlign.start,
                      family: FontFamily.workSans,
                      weight: 600,
                      size: 25),
                  const SizedBox(height: 5),
                  AppText(channel.channelOwner, size: 14),
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

  _buildSeriesList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.separator),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 10, 0),
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
          padding: const EdgeInsets.fromLTRB(24, 10, 15, 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                AppImage(image: series.image, width: 50, height: 50),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(series.name, family: FontFamily.louis, weight: 600),
                    const SizedBox(height: 3),
                    const AppText('Episodes : 24',
                        family: FontFamily.louis,
                        weight: 400,
                        color: AppColors.onSecondary)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            AppText(series.description,
                size: 15,
                family: FontFamily.workSans,
                color: AppColors.onSecondary2),
            _buildGoToSeriesButton(series)
          ])),
    ]);
  }

  _buildGoToSeriesButton(Series series) {
    return TextButton(
        onPressed: () => SeriesPage.navigateTo(context, series),
        style: TextButton.styleFrom(
          maximumSize: const Size.fromWidth(140),
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: AppColors.inactive, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.podcasts, color: AppColors.secondary, size: 20),
            AppText('Visit Series', size: 14),
          ],
        ));
  }
}
