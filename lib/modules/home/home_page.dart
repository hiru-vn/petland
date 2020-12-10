import 'package:petland/modules/home/bottom_navigator.dart';
import 'package:petland/modules/story/story_page.dart';
import 'package:petland/share/import.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages.addAll([
      StoryPage(),
      Container(),
      Container(),
      Container(),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool flag = await showConfirmDialog(context, 'Close the app?',
            confirmTap: () {}, navigatorKey: navigatorKey);
        return flag;
      },
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
            Positioned(
              bottom: 0,
              child: BottomNavigator(
                selectedIndex: _selectedIndex,
                listIcons: [
                  MdiIcons.heart,
                  MdiIcons.home,
                  MdiIcons.bell,
                  Icons.pets
                ],
                onSelect: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
