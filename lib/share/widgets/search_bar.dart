import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key key, this.onSearch}) : super(key: key);

  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      padding:
          EdgeInsets.symmetric(horizontal: 14, vertical: 10).copyWith(top: 0),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white38,
        ),
        child: Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                style: ptBigBody(),
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: 'Search'),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
