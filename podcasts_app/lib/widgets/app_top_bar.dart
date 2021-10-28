import '../source.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class AppTopBars {
  static AppTopBar episodePage(BuildContext context) {
    return const AppTopBar(Pages.episodePage);
  }

  static AppTopBar homepage(BuildContext context) {
    return const AppTopBar(Pages.homepage);
  }

  static AppTopBar channelPage(BuildContext context,
      {required double topScrolledPixels, required String value}) {
    return AppTopBar(Pages.channelPage,
        topScrolledPixels: topScrolledPixels, value: value);
  }

  static AppTopBar seriesPage(BuildContext context,
      {required double topScrolledPixels, required String value}) {
    return AppTopBar(Pages.seriesPage,
        topScrolledPixels: topScrolledPixels, value: value);
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar(this.page,
      {this.topScrolledPixels = 0, this.value = 'hellow', key})
      : super(key: key);

  final Pages page;
  final double topScrolledPixels;
  final String value;

  @override
  AppBar build(BuildContext context) {
    final isEpisodePage = page == Pages.episodePage;
    final isHomepage = page == Pages.homepage;
    final isChannelPage = page == Pages.channelPage;
    final isSeriesPage = page == Pages.seriesPage;

    final shouldChangeSeriesPageTitle = topScrolledPixels > 53;
    final shouldChangeChannelPageTitle = topScrolledPixels > 130;
    final hasSeriesPageTitleChange =
        isSeriesPage ? shouldChangeSeriesPageTitle : false;
    final hasChannelPageTitleChange =
        isChannelPage ? shouldChangeChannelPageTitle : false;

    return isHomepage
        ? AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: AppColors.background,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: AppColors.onSecondary2),
            title: AppText('Podcasts', size: 20.w, weight: 600),
          )
        : AppBar(
            automaticallyImplyLeading: false,
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceIn,
              child: hasSeriesPageTitleChange || hasChannelPageTitleChange
                  ? Text(
                      value,
                      style: TextStyle(
                          fontSize: 18.dw,
                          fontWeight: FontWeight.w600,
                          color: AppColors.active,
                          fontFamily: 'Louis'),
                    )
                  : AppText(
                      isEpisodePage
                          ? 'Episode'
                          : isChannelPage
                              ? 'Channel'
                              : 'Series',
                      size: 20.w,
                      weight: 400,
                      family: FontFamily.workSans,
                    ),
            ),
            iconTheme: const IconThemeData(color: AppColors.onSecondary),
            leading: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(EvaIcons.arrowBackOutline, size: 25.dw),
                onPressed: () => Navigator.pop(context)),
            backgroundColor: AppColors.background,
            elevation:
                hasSeriesPageTitleChange || hasChannelPageTitleChange ? 2 : 0,
          );
  }
}
