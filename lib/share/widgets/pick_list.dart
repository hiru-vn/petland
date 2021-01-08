import 'package:petland/share/import.dart';

// show a list of string options
// when user tap on one, excute a callback function with string value as param

void pickList(BuildContext context,
    {String closeText,
    String title,
    @required List<String> options,
    @required Function(String) onPicked}) {
  if (options == null) return;
  showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: deviceHeight(context) * 0.75),
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      decoration:
                          BoxDecoration(color: ptPrimaryColorLight(context)),
                      width: deviceWidth(context) - 30,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20).copyWith(bottom: 10),
                            child: Text(title ?? 'Chọn', style: ptTitle()),
                          ),
                          ...options?.map(
                            (e) => InkWell(
                              onTap: () => navigatorKey.currentState.maybePop(),
                              child: OptionItem(
                                text: e,
                                color: ptPrimaryColorLight(context),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ExpandBtn(
                color: ptPrimaryColorLight(context),
                textColor: Colors.black,
                text: 'Cancel',
                height: 50,
                onPress: () => navigatorKey.currentState.maybePop(),
              ),
            ),
            SpacingBox(h: 4),
          ],
        );
      });
}

class OptionItem extends StatelessWidget {
  final Color color;
  final String text;

  const OptionItem({Key key, this.color, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.maxFinite,
      color: color ?? ptPrimaryColorLight(context),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(20).copyWith(bottom: 0, top: 0),
          child: Text(text),
        ),
      ),
    );
  }
}
