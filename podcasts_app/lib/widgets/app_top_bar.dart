import '../source.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class AppTopBars {
  static AppTopBar episodePage(BuildContext context) {
    return const AppTopBar(Pages.episodePage);
  }

  static AppTopBar homepage(BuildContext context) {
    return const AppTopBar(Pages.homepage);
  }

  static AppTopBar channelPage(BuildContext context) {
    return const AppTopBar(Pages.channelPage);
  }

  static AppTopBar seriesPage(BuildContext context) {
    return const AppTopBar(Pages.seriesPage);
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar(this.page, {key}) : super(key: key);

  final Pages page;

  @override
  AppBar build(BuildContext context) {
    final isEpisodePage = page == Pages.episodePage;
    final isHomepage = page == Pages.homepage;
    final isChannelPage = page == Pages.channelPage;

    return isHomepage
        ? AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: AppColors.background,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: AppColors.onSecondary2),
            title: const AppText('Podcasts', size: 20, weight: 600),
          )
        : AppBar(
            centerTitle: true,
            title: AppText(
              isEpisodePage
                  ? 'Episode'
                  : isChannelPage
                      ? 'Channel'
                      : 'Series',
              size: 20,
              weight: 400,
              family: FontFamily.workSans,
            ),
            iconTheme: const IconThemeData(color: AppColors.onSecondary),
            leading: IconButton(
                padding: const EdgeInsets.only(left: 14),
                icon: const Icon(EvaIcons.arrowBackOutline),
                onPressed: () => Navigator.pop(context)),
            backgroundColor: AppColors.background,
            elevation: 0,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              const SizedBox(width: 8)
            ],
          );
  }
}
