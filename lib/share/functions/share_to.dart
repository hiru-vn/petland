import '../import.dart';

void shareTo(BuildContext context) {
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
              child: SafeArea(
                child: Container(
                  decoration:
                      BoxDecoration(color: ptPrimaryColorLight(context)),
                  width: deviceWidth(context) - 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20).copyWith(bottom: 0),
                        child: Text('Chia sẻ', style: ptTitle()),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigatorKey.currentState.maybePop();
                              },
                              child: ShareItem(
                                img: 'assets/image/facebook.webp',
                                name: 'Facebook',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigatorKey.currentState.maybePop();
                              },
                              child: ShareItem(
                                img: 'assets/image/gmail.webp',
                                name: 'Gmail',
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigatorKey.currentState.maybePop();
                              },
                              child: ShareItem(
                                img: 'assets/image/workplace.webp',
                                name: 'Workplace',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
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
            SpacingBox(h: 2.5),
          ],
        );
      });
}

class ShareItem extends StatelessWidget {
  final String img;
  final String name;

  const ShareItem({Key key, this.img, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(img),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: ptSmall().copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
