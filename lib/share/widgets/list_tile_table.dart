import 'package:petland/share/import.dart';

import 'custom_list_tile.dart';

class ListTileTableItemModel {
  final String title;
  final IconData iconData;
  final Function onTap;
  final bool isCheckType;
  final bool value;
  final String subtitle;
  final String trailingString;

  ListTileTableItemModel(this.title, this.iconData, this.onTap,
      {this.value = false,
      this.isCheckType = false,
      this.subtitle,
      this.trailingString});
}

class ListTileTable extends StatelessWidget {
  final List<ListTileTableItemModel> data;
  final String title;

  const ListTileTable({Key key, @required this.data, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    data.forEach((element) {
      widgets.addAll([
        ListTileTableItem(
          data: element,
        ),
        Divider(
          height: 1,
          color: ptLineColor(context),
        ),
      ]);
    });
    widgets.removeLast();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 3),
            child: Text(
              title,
              style: ptTitle(),
            ),
          ),
        ...widgets,
      ],
    );
  }
}

class ListTileTableItem extends StatelessWidget {
  final ListTileTableItemModel data;

  const ListTileTableItem({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: data.onTap,
      leading: data.iconData != null ? Icon(data.iconData) : SizedBox.shrink(),
      title: Row(
        children: [
          Text(data.title),
          Spacer(),
          if (data.trailingString != null)
            Text(
              data.trailingString,
              style: ptTitle(),
            )
        ],
      ),
      trailing: data.isCheckType
          ? Switch(value: data.value, onChanged: (val) {})
          : data.trailingString != null
              ? null
              : Icon(Icons.chevron_right),
      subtitle: data.subtitle != null
          ? Text(
              data.subtitle,
              style: ptSmall(),
            )
          : null,
    );
  }
}
