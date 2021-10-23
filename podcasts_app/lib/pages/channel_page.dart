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
      padding: EdgeInsets.fromLTRB(24.dw, 10.dh, 15.dw, 10.dh),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 150,
          child: Row(children: [
            AppImage(image: channel.channelImage, height: 150.w, width: 150.w),
            SizedBox(width: 10.dw),
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
                  SizedBox(height: 5.dh),
                  AppText(channel.channelOwner, size: 14),
                  SizedBox(height: 5.dh),
                ],
              ),
            ),
          ]),
        ),
        SizedBox(height: 15.dh),
        Padding(
          padding: EdgeInsets.only(right: 10.dw),
          child: AppRichText(channel.channelDescription),
        )
      ]),
    );
  }

  _buildSeriesList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.dw, 0, 10.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.separator),
          Padding(
            padding: EdgeInsets.fromLTRB(24.dh, 10.dw, 10.dh, 0),
            child: const AppText('My Series',
                size: 18, weight: 400, family: FontFamily.casual),
          ),
          SizedBox(height: 10.dh),
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
          padding: EdgeInsets.fromLTRB(24.dw, 10.dh, 15.dw, 5.dh),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                AppImage(image: series.image, width: 50.w, height: 50.w),
                SizedBox(width: 10.dw),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(series.name, family: FontFamily.louis, weight: 600),
                    SizedBox(height: 3.dh),
                    const AppText('Episodes : 24',
                        family: FontFamily.louis,
                        weight: 400,
                        color: AppColors.onSecondary)
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.dh),
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
          maximumSize: Size.fromWidth(140.dw),
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
