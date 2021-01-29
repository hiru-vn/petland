import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class BottomNavigator extends StatelessWidget {
  final int selectedIndex;
  final List<IconData> listIcons;
  final Function(int) onSelect;

  const BottomNavigator(
      {Key key,
      @required this.selectedIndex,
      @required this.listIcons,
      @required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavBarItems = listIcons
        .map(
          (e) => BottomNavigationBarItem(
            icon: Icon(e),
            title: SizedBox.shrink(),
            activeIcon: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: ptPrimaryColor(context),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  e,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
        .toList();
    return Material(
      elevation: selectedIndex!=0? 4: 0,
      color: Colors.white30,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.15, left: 0.1, right: 0.1),
        child: Container(
          height: 56,
          width: deviceWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              elevation: selectedIndex!= 0? 3: 0,
              backgroundColor: selectedIndex!=0? ptDarkColor(context): Colors.transparent,
              selectedItemColor: ptPrimaryColor(context),
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: bottomNavBarItems,
              currentIndex: selectedIndex,
              onTap: onSelect,
            ),
          ),
        ),
      ),
    );
  }
}
