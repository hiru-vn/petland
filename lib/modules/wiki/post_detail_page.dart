import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/spin_loader.dart';

class PostDetailPage extends StatefulWidget {
  final String link;
  PostDetailPage(this.link);
  static Future navigate(String link) {
    return navigatorKey.currentState.push(pageBuilder(PostDetailPage(link)));
  }

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        automaticallyImplyLeading: true,
        actions: [
          Image.asset(
            'assets/image/logo.png',
            height: 27,
            width: 27,
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebView(
            initialUrl:
                widget.link??'https://sites.google.com/gm.uit.edu.vn/petland-post-1/home',
            onPageStarted: (str) {},
            onPageFinished: (str) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: kLoadingSpinner,
              ),
            )
        ],
      ),
    );
  }
}
