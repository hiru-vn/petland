import 'package:flutter/material.dart';

class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _folded = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _folded ? 48 : 180,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: _folded ? null : kElevationToShadow[1],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: !_folded
                  ? TextField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none),
                    )
                  : null,
            ),
          ),
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 24 : 0),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(_folded ? 24 : 0),
                  bottomRight: Radius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: _folded ? Colors.black87 : Colors.black45,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                  Future.delayed(Duration(milliseconds: 100), () {
                    _focusNode.requestFocus();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
