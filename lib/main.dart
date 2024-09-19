import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/models/article_category.dart';
import 'package:news_app/models/news_page.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:window_manager/window_manager.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle('News Application');
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(755, 545));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: 'News Application',
        theme: FluentThemeData(
          brightness: Brightness.light,
          accentColor: Colors.red,
        ),
        darkTheme: FluentThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red,
        ),
        home: const MyHomePage(title: 'News Application'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final viewKey = GlobalKey();
  int selectedIndex = 0;
  final List<NewsPage> pages = const [
    NewsPage(title: 'Top Headlines', iconData: FluentIcons.news, category: ArticleCategory.general),
    NewsPage(title: 'Business', iconData: FluentIcons.business_card, category: ArticleCategory.business),
    NewsPage(title: 'Technology', iconData: FluentIcons.laptop_secure, category: ArticleCategory.technology),
    NewsPage(title: 'Entertainment', iconData: FluentIcons.my_movies_t_v, category: ArticleCategory.entertainment),
    NewsPage(title: 'Sports', iconData: FluentIcons.more_sports, category: ArticleCategory.sports),
    NewsPage(title: 'Science', iconData: FluentIcons.communications, category: ArticleCategory.science),
    NewsPage(title: 'Health', iconData: FluentIcons.health, category: ArticleCategory.health),
  ];
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
   Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: selectedIndex,
        onChanged: (i) => setState(() => selectedIndex = i),
        displayMode: PaneDisplayMode.compact,
        items: pages.map<NavigationPaneItem>(((e)=> PaneItem(icon: Icon(e.iconData),body: NewsListPage(newsPage: pages[selectedIndex]), title: Text(e.title)))).toList(),
      ),
  
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
              title: Text('Close Application'),
              content: const Text('Are you sure?'),
              actions: [
                FilledButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.pop(context);
                    windowManager.destroy();
                  },
                ),
                FilledButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
    super.onWindowClose();
  }
}
