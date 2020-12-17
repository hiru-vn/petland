
import 'package:petland/share/import.dart';

import 'custom_list_tile.dart';

class PickerPageModel {
  final Widget prefixIcon;
  final String title;
  final dynamic value;

  PickerPageModel(this.prefixIcon, this.title, this.value);
}

class PickerPage extends StatelessWidget {
  final List<PickerPageModel> list;
  final dynamic initialValue;
  final String title;
  final Function(String) onSearch;

  const PickerPage(
      {Key key, this.list, this.initialValue, @required this.title, this.onSearch})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    list.forEach((element) {
      widgets.addAll([
        CustomListTile(
          onTap: () {
            navigatorKey.currentState.pop(element.value);
          },
          leading: element.prefixIcon,
          title: Text(element.title),
          trailing: (initialValue == element.value)
              ? Icon(Icons.check)
              : SizedBox.shrink(),
        ),
        Divider(
          height: 1,
          color: ptLineColor(context),
        ),
      ]);
    });
    return Scaffold(
      appBar: innerAppBar(context, title, onSearch: onSearch),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}
