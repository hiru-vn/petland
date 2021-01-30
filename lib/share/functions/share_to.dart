import 'package:petland/share/functions/down_load_url_file.dart';

import '../import.dart';
import 'package:social_share/social_share.dart';

void shareTo(BuildContext context,
    {String content = '', String image = '', String video}) {
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
                              onTap: () async {
                                try {
                                  showSimpleLoadingDialog(context);
                                  final file = await downLoadUrlFile(image);
                                  navigatorKey.currentState.maybePop();
                                  SocialShare.shareFacebookStory(
                                      file.path, "#ffffff", "#000000", image,
                                      appId: "3591217134294975");
                                  navigatorKey.currentState.maybePop();
                                } catch (e) {
                                  showToast('Lỗi: $e', context);
                                }
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
                              onTap: () async {
                                showSimpleLoadingDialog(context);
                                  final file = await downLoadUrlFile(image);
                                  navigatorKey.currentState.maybePop();
                                  SocialShare.shareInstagramStory(
                                      file.path, "#ffffff", "#000000", image,);
                                  navigatorKey.currentState.maybePop();
                              },
                              child: ShareItem(
                                img: 'assets/image/instagram.jpg',
                                name: 'Instagram',
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            GestureDetector(
                              onTap: () async {
                                  await SocialShare.shareWhatsapp(image);
                                  navigatorKey.currentState.maybePop();
                              },
                              child: ShareItem(
                                img: 'assets/image/whatsapp.png',
                                name: 'Whatsapp',
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
