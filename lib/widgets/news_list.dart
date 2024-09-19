import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/models/news_page.dart';
import 'package:news_app/widgets/news_item.dart';

class NewsListPage extends StatefulWidget {
  final NewsPage newsPage;
  const NewsListPage({super.key,required this.newsPage});

  @override
  State<NewsListPage> createState() => _NewsListPageState();  
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header:PageHeader(title: Text(widget.newsPage.title)),
      content: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent
      (maxCrossAxisExtent: 270,mainAxisExtent: 290,mainAxisSpacing: 10,crossAxisSpacing: 10), 
      padding: const EdgeInsets.all(16),
      itemBuilder:(ctx,index){
        return NewsItem();
      } )
    );
  }
}