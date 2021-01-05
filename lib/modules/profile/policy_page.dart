import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/spin_loader.dart';

class PolicyPage extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(PolicyPage()));
  }

  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Term & Policy',
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebView(
            initialUrl:
                'https://sites.google.com/view/apppetlandio/trang-ch%E1%BB%A7',
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
