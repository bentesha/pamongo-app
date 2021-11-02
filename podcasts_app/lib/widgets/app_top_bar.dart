import '../source.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class AppTopBars {
  static AppTopBar homepage() => AppTopBar(Pages.homepage, popCallback: () {});

  static AppTopBar episodePage(VoidCallback popCallback) =>
      AppTopBar(Pages.episodePage, popCallback: popCallback);

  static AppTopBar channelPage(
      {required double topScrolledPixels,
      required String title,
      required VoidCallback popCallback}) {
    return AppTopBar(Pages.channelPage,
        topScrolledPixels: topScrolledPixels,
        popCallback: popCallback,
        title: title);
  }

  static AppTopBar seriesPage(BuildContext context,
      {required double topScrolledPixels, required String title}) {
    return AppTopBar(Pages.seriesPage,
        popCallback: () {}, topScrolledPixels: topScrolledPixels, title: title);
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar(this.page,
      {this.topScrolledPixels = 0,
      required this.popCallback,
      this.title = 'hellow',
      key})
      : super(key: key);

  final Pages page;
  final double topScrolledPixels;
  final String title;
  final VoidCallback popCallback;

  @override
  AppBar build(BuildContext context) {
    final isEpisodePage = page == Pages.episodePage;
    final isHomepage = page == Pages.homepage;
    final isChannelPage = page == Pages.channelPage;
    final isSeriesPage = page == Pages.seriesPage;

    final shouldChangeSeriesPageTitle = topScrolledPixels > 53 && isSeriesPage;
    final shouldChangeChannelPageTitle =
        topScrolledPixels > 130 && isChannelPage;
    final isTitleChanged =
        shouldChangeSeriesPageTitle || shouldChangeChannelPageTitle;

    return isHomepage || isEpisodePage
        ? AppBar(
            centerTitle: isHomepage,
            elevation: isHomepage ? 1 : 0,
            backgroundColor: AppColors.background,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: AppColors.onSecondary),
            title: isHomepage
                ? const AppText('Podcasts', size: 20, weight: FontWeight.w600)
                : Container(),
            leading: isEpisodePage ? _buildBackArrow() : Container())
        : AppBar(
            automaticallyImplyLeading: false,
            title: isTitleChanged
                ? AppText(title,
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.active,
                    family: 'Louis')
                : Container(),
            iconTheme: const IconThemeData(color: AppColors.onSecondary),
            leading: _buildBackArrow(),
            backgroundColor: AppColors.background,
            elevation: isTitleChanged ? 2 : 0,
          );
  }

  _buildBackArrow() {
    return Builder(builder: (context) {
      return IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(EvaIcons.arrowBackOutline, size: 25),
          onPressed: popCallback);
    });
  }
}
