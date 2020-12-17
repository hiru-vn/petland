import 'package:flutter/material.dart';
import 'package:petland/modules/my_pet/pick_my_pet_list.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/custom_list_tile.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PostStory extends StatefulWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(PostStory()));
  }

  @override
  _PostStoryState createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  bool _makePublic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Scaffold(
              appBar: innerAppBar(context, 'Pets story', actions: [
                GestureDetector(
                  onTap: () {
                    navigatorKey.currentState.maybePop();
                  },
                  child: SizedBox(
                    height: 30,
                    width: 70,
                    child: Center(
                      child: Text(
                        'Post',
                        style: ptBigTitle().copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'IMAGE AND VIDEOS',
                        style: ptBigTitle().copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Divider(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 110,
                        child: ImageRowPicker(
                          [
                            'https://media2.giphy.com/media/H4DjXQXamtTiIuCcRU/giphy.gif'
                          ],
                          onUpdateListImg: (listImg) {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: TextField(
                          maxLength: 200,
                          maxLines: null,
                          style: ptBigBody().copyWith(color: Colors.black54),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a status',
                            hintStyle: ptTitle().copyWith(
                                color: Colors.black38, letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Positioned(
              bottom: 0,
              width: deviceWidth(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildForm(),
                  SizedBox(
                    height: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatorKey.currentState.maybePop();
                    },
                    child: Container(
                      height: 53,
                      width: deviceWidth(context),
                      color: ptPrimaryColor(context),
                      child: Center(
                        child: Text(
                          'Post',
                          style: ptBigTitle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 3,
        ),
        InkWell(
          highlightColor: ptAccentColor(context),
          splashColor: ptPrimaryColor(context),
          onTap: () {
            PickMyPetListpage.navigate();
          },
          child: CustomListTile(
            leading: Icon(
              Icons.pets,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Select pet',
              style: ptTitle(),
            ),
            trailing: Icon(
              MdiIcons.arrowRightCircle,
              size: 20,
              color: ptPrimaryColor(context),
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 3),
                child: Icon(
                  MdiIcons.dogService,
                  color: Colors.pinkAccent,
                ),
              ),
              Expanded(
                child: TextFieldTags(
                  onTag: (val) {},
                  onDelete: (val) {},
                  textFieldStyler: TextFieldStyler(
                    hintText: 'Tags, activities, ...',
                    textStyle: ptTitle(),
                    helperText: null,
                    textFieldBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                    ),
                    textFieldEnabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                    ),
                    textFieldFocusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, color: Colors.transparent),
                    ),
                  ),
                  tagsStyler: TagsStyler(
                    tagTextStyle: ptTitle(),
                    tagDecoration: BoxDecoration(
                      color: ptPrimaryColor(context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    tagCancelIcon: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(Icons.cancel, size: 18.0, color: Colors.pink),
                    ),
                    tagPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 3,
        ),
        CustomListTile(
          leading: Icon(
            Icons.pets,
            color: Colors.pinkAccent,
          ),
          title: Text(
            'Make public',
            style: ptTitle(),
          ),
          trailing: Switch(
            activeColor: ptPrimaryColor(context),
            value: _makePublic,
            onChanged: (val) {
              setState(() {
                _makePublic = val;
              });
            },
          ),
        ),
      ],
    );
  }
}
