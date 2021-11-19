import 'package:podcasts/pages/homepage.dart';
import '../source.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage, explorePage }

class AppTopBars {
  static AppTopBar episodePage(bool isOpenedUsingLink) =>
      AppTopBar(Pages.episodePage, isOpenedUsingLink: isOpenedUsingLink);

  static AppTopBar explorePage() => const AppTopBar(Pages.explorePage);

  static AppTopBar channelPage(
      {required double topScrolledPixels,
      required String title,
      required bool isOpenedUsingLink}) {
    return AppTopBar(Pages.channelPage,
        topScrolledPixels: topScrolledPixels,
        title: title,
        isOpenedUsingLink: isOpenedUsingLink);
  }

  static AppTopBar seriesPage(
      {required double topScrolledPixels,
      required String title,
      required bool isOpenedUsingLink}) {
    return AppTopBar(
      Pages.seriesPage,
      topScrolledPixels: topScrolledPixels,
      title: title,
      isOpenedUsingLink: isOpenedUsingLink,
    );
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar(this.page,
      {this.topScrolledPixels = 0,
      this.title = '',
      this.isOpenedUsingLink = false,
      key})
      : super(key: key);

  final Pages page;
  final double topScrolledPixels;
  final String title;
  final bool isOpenedUsingLink;

  @override
  AppBar build(BuildContext context) {
    final isEpisodePage = page == Pages.episodePage;
    final isChannelPage = page == Pages.channelPage;
    final isSeriesPage = page == Pages.seriesPage;

    final shouldChangeSeriesPageTitle = topScrolledPixels > 53 && isSeriesPage;
    final shouldChangeChannelPageTitle =
        topScrolledPixels > 130 && isChannelPage;
    final isTitleChanged =
        shouldChangeSeriesPageTitle || shouldChangeChannelPageTitle;

    return isEpisodePage
        ? AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: _buildBackArrow(isOpenedUsingLink))
        : AppBar(
            automaticallyImplyLeading: false,
            title: isTitleChanged
                ? AppText(title,
                    size: 18.w, weight: FontWeight.w600, family: 'Louis')
                : Container(),
            iconTheme: const IconThemeData(color: Colors.black),
            leading: _buildBackArrow(isOpenedUsingLink),
            backgroundColor: AppColors.backgroundColor,
            elevation: isTitleChanged ? 2 : 0,
          );
  }

  _buildBackArrow(bool isOpenedUsingLink) {
    return Builder(builder: (context) {
      return IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(EvaIcons.arrowBackOutline, size: 25.dw),
          onPressed: isOpenedUsingLink
              ? () => Homepage.navigateTo(context)
              : () => Navigator.of(context).pop());
    });
  }
}
