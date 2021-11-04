import '../source.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class AppTopBars {
  static AppTopBar homepage() => const AppTopBar(Pages.homepage);

  static AppTopBar episodePage() => const AppTopBar(Pages.episodePage);

  static AppTopBar channelPage(
      {required double topScrolledPixels, required String title}) {
    return AppTopBar(Pages.channelPage,
        topScrolledPixels: topScrolledPixels, title: title);
  }

  static AppTopBar seriesPage(
      {required double topScrolledPixels, required String title}) {
    return AppTopBar(Pages.seriesPage,
        topScrolledPixels: topScrolledPixels, title: title);
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar(this.page,
      {this.topScrolledPixels = 0, this.title = 'hellow', key})
      : super(key: key);

  final Pages page;
  final double topScrolledPixels;
  final String title;

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
                ? AppText('Podcasts', size: 20.w, weight: FontWeight.w600)
                : Container(),
            leading: isEpisodePage ? _buildBackArrow() : Container())
        : AppBar(
            automaticallyImplyLeading: false,
            title: isTitleChanged
                ? AppText(title,
                    size: 18.w, weight: FontWeight.w600, family: 'Louis')
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
          icon: Icon(EvaIcons.arrowBackOutline, size: 25.dw),
          onPressed: () => Navigator.of(context).pop());
    });
  }
}
