import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/bloc/post_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/model/post.dart';
import 'package:petland/modules/authentication/auth_bloc.dart';
import 'package:petland/modules/my_pet/pick_my_pet_list.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/textfield_tag/lib/src/main.dart';
import 'package:petland/utils/file_util.dart';

class PostStory extends StatefulWidget {
  static navigate() {
    navigatorKey.currentState.push(pageBuilder(PostStory()));
  }

  @override
  _PostStoryState createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  bool _makePublic = true;
  FocusNode _activityNode = FocusNode();
  PostBloc _postBloc;
  List<String> images = [];
  List<String> videos = [];
  List<String> tags = [];
  List<String> _allVideoAndImage = [];
  PetModel pet;
  TextEditingController _statusC = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future _upload(String filePath) async {
    try {
      _allVideoAndImage.add(loadingGif);
      setState(() {});
      final res = await FileUtil.uploadFireStorage(File(filePath),
          path:
              'posts/user_${AuthBloc.instance.userModel.id}/${Formart.formatToDate(DateTime.now(), seperateChar: '-')}');
      if (FileUtil.getFbUrlFileType(res) == FileType.image ||
          FileUtil.getFbUrlFileType(res) == FileType.gif) {
        images.add(res);
        _allVideoAndImage.add(res);
      }
      if (FileUtil.getFbUrlFileType(res) == FileType.video) {
        videos.add(res);
        _allVideoAndImage.add(res);
      }
      _allVideoAndImage.remove(loadingGif);
      setState(() {});
    } catch (e) {
      showToast(e.toString(), context);
    }
  }

  @override
  void didChangeDependencies() {
    if (_postBloc == null) {
      _postBloc = Provider.of<PostBloc>(context);
    }

    super.didChangeDependencies();
  }

  Future _submit() async {
    setState(() {
      isLoading = true;
    });
    final res = await _postBloc.createPost(PostModel(
        content: _statusC.text,
        images: images,
        videos: videos,
        petTags: [pet.id],
        tags: tags,
        makePublic: _makePublic));
    setState(() {
      isLoading = false;
    });
    if (!res.isSuccess) {
      showToast(res.errMessage, context);
    } else {
      showToast('Đăng thành công', context, isSuccess: true);
      _postBloc.getListPost();
      navigatorKey.currentState.maybePop();
    }
  }

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
                          _allVideoAndImage,
                          onUpdateListImg: (listImg) {
                            print('as');
                          },
                          onAddImg: _upload,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          maxLength: 200,
                          maxLines: null,
                          controller: _statusC,
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
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildForm(),
                    SizedBox(
                      height: 3.0,
                    ),
                    ExpandRectangleButton(
                      text: 'Post',
                      onTap: _submit,
                    ),
                    SizedBox(
                      height: _activityNode.hasFocus
                          ? MediaQuery.of(context).viewInsets.bottom
                          : 0,
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) kLoadingSpinner
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
            PickMyPetListpage.navigate().then((value) {
              if (value != null) {
                setState(() {
                  pet = value;
                });
              }
            });
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: CustomListTile(
            leading: Icon(
              Icons.pets,
              color: Colors.pinkAccent,
            ),
            title: Row(
              children: [
                Text(
                  'Select pet',
                  style: ptTitle(),
                ),
                Spacer(),
                Text(
                  pet?.name ?? '',
                  style: ptBody(),
                )
              ],
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
          padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  initialTags: tags,
                  onTag: (val) {},
                  focusNode: _activityNode,
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
                    tagTextStyle: ptTitle().copyWith(color: Colors.white),
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
