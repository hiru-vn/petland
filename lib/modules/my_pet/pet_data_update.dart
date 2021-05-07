import 'dart:io';

import 'package:petland/bloc/pet_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/pet_race.dart';
import 'package:petland/share/import.dart';
import 'package:petland/utils/file_util.dart';

class PetDataUpdatePage extends StatefulWidget {
  final String petId;
  final String type;

  const PetDataUpdatePage({
    Key key,
    this.petId,
    this.type,
  }) : super(key: key);

  static Future navigate({
    String petId,
    String type,
  }) {
    return navigatorKey.currentState.push(pageBuilder(PetDataUpdatePage(
      petId: petId,
      type: type,
    )));
  }

  @override
  _PetDataUpdatePageState createState() => _PetDataUpdatePageState();
}

class _PetDataUpdatePageState extends State<PetDataUpdatePage> {
  bool _isUpdate = false;
  PetBloc _petBloc;
  PetModel _pet;
  bool isLoading = false;
  TextEditingController petNameC = TextEditingController();

  @override
  void initState() {
    if (widget.petId != null) _isUpdate = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_petBloc == null) {
      _petBloc = Provider.of<PetBloc>(context);
      if (_isUpdate)
        _pet =
            _petBloc.pets.firstWhere((element) => element.id == widget.petId);
      else {
        _pet = PetModel(character: []);
        _petBloc.getAllPetRace(widget.type);
      }
      petNameC.text = _pet.name ?? '';
    }
    super.didChangeDependencies();
  }

  Future _save() async {
    _pet.name = petNameC.text;
    if (_pet.race == null) {
      showToast('Không đủ thông tin', context);
      return;
    }
    setState(() {
      isLoading = true;
    });
    if (_isUpdate) {
      final res = await _petBloc.updatePet(_pet);
      if (!res.isSuccess) {
        showToast(
            'Có lỗi xảy ra khi cập nhật thông tin, vui lòng thử lại', context);
      }
    } else {
      final res = await _petBloc.createPet(_pet);
      if (!res.isSuccess) {
        showToast('Có lỗi xảy ra khi gửi yêu cầu, vui lòng thử lại', context);
      }
    }
    setState(() {
      isLoading = false;
    });
    navigatorKey.currentState.maybePop();
  }

  Future _delete() async {
    setState(() {
      isLoading = true;
    });
    final confirm = await showConfirmImageDialog(
        context,
        'Bạn chắc chứ?',
        'Dữ liệu của ${_pet.name} sẽ không thể khôi phục lại.',
        'assets/image/pet_delete_dialog.jpg');
    if (confirm) {
      final res = await _petBloc.deletePet(_pet.id);
      if (!res.isSuccess) {
        showToast('Có lỗi xảy ra, vui lòng thử lại', context);
      }
      await navigatorKey.currentState.maybePop();
      await navigatorKey.currentState.maybePop();
    }
    setState(() {
      isLoading = false;
    });
  }

  _updateAvatar(String filePath) async {
    setState(() {
      _pet.avatar = loadingGif;
    });
    final url = await FileUtil.uploadFireStorage(File(filePath));
    setState(() {
      _pet.avatar = url;
    });
  }

  _updateCoverImage(String filePath) async {
    setState(() {
      _pet.coverImage = loadingGif;
    });
    final url = await FileUtil.uploadFireStorage(File(filePath));
    setState(() {
      _pet.coverImage = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: innerAppBar(context, 'Update Pet\'s data', actions: [
            if (_isUpdate)
              IconButton(
                  onPressed: _delete,
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ))
          ]),
          body: SingleChildScrollView(
            child: Column(children: [
              _buildHead(
                  imgUrl: _pet?.avatar,
                  imageCover: _pet?.coverImage,
                  petName: _pet?.name),
              SpacingBox(h: 3),
              _buildForm(),
              SpacingBox(h: 3),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: ExpandBtn(
                    text: 'Save',
                    onPress: _save,
                  ))
            ]),
          ),
        ),
        if (isLoading) kLoadingSpinner,
      ],
    );
  }

  _buildHead({String imageCover, String imgUrl, String petName}) {
    return Container(
      height: 180,
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 120,
            color: HexColor('#383838'),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.pets,
                    size: 100,
                    color: ptPrimaryColor(context),
                  ),
                ),
                Center(
                  child: Icon(
                    MdiIcons.camera,
                    size: 50,
                    color: Colors.white30,
                  ),
                ),
                if (imageCover != null)
                  GestureDetector(
                    onLongPress: () {
                      imagePicker(context,
                          onCameraPick: _updateCoverImage,
                          onImagePick: _updateCoverImage);
                    },
                    child: SizedBox(
                        width: deviceWidth(context),
                        child: ImageViewNetwork(url: imageCover)),
                  ),
              ],
            ),
          ),
          Positioned(
            left: deviceWidth(context) / 10,
            top: 65,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ptPrimaryColor(context),
                border: Border.all(width: 2.5, color: Colors.white),
              ),
              child: imgUrl != null
                  ? GestureDetector(
                      onLongPress: () {
                        imagePicker(context,
                            onCameraPick: _updateAvatar,
                            onImagePick: _updateAvatar);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: ImageViewNetwork(url: imgUrl)),
                    )
                  : GestureDetector(
                      onTap: () {
                        imagePicker(context,
                            onCameraPick: _updateAvatar,
                            onImagePick: _updateAvatar);
                      },
                      child: Icon(
                        MdiIcons.camera,
                        size: 70,
                        color: Colors.white30,
                      ),
                    ),
            ),
          ),
          Positioned(
            right: 15,
            left: deviceWidth(context) / 10 + 125,
            bottom: 10,
            child: TextFormField(
              controller: petNameC,
              style: ptBigTitle().copyWith(fontSize: 19.5),
              decoration: InputDecoration(
                hintText: 'Pet name',
                isDense: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildForm() {
    return Column(
      children: [
        Text(
          'BASIC DATA',
          style: ptBigTitle(),
        ),
        SpacingBox(h: 3),
        Divider(
          height: 3,
        ),
        InkWell(
          highlightColor: ptAccentColor(context),
          splashColor: ptPrimaryColor(context),
          onTap: () {
            PetRacePage.navigate(_isUpdate ? _pet?.race?.type : widget.type)
                .then((value) {
              if (value != null) _pet?.race = value;
            });
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListTile(
            title: Text(
              'RACE',
              style: ptTitle(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pet?.race != null) ...[
                  Text(
                    _pet?.race?.name ?? '',
                  ),
                  SizedBox(width: 10),
                ],
                Icon(
                  MdiIcons.arrowRightCircle,
                  size: 20,
                  color: ptPrimaryColor(context),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        InkWell(
          highlightColor: ptAccentColor(context),
          splashColor: ptPrimaryColor(context),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 20 * 365)),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Theme.of(context).primaryColor,
                  ),
                  child: child,
                );
              },
            ).then((value) => setState(() {
                  _pet?.birthday = value.toIso8601String();
                }));
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListTile(
            title: Text(
              'BIRTHDAY',
              style: ptTitle(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pet?.birthday != null) ...[
                  Text(Formart.formatToDate(DateTime.tryParse(_pet?.birthday))),
                  SizedBox(width: 10),
                ],
                Icon(
                  MdiIcons.calendar,
                  size: 20,
                  color: ptPrimaryColor(context),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        InkWell(
          highlightColor: ptAccentColor(context),
          splashColor: ptPrimaryColor(context),
          onTap: () {
            navigatorKey.currentState
                .push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PickerPage(
                  list: [
                    PickerPageModel(
                      Icon(
                        MdiIcons.genderMale,
                        color: ptPrimaryColor(context),
                      ),
                      'Male',
                      'MALE',
                    ),
                    PickerPageModel(
                      Icon(
                        MdiIcons.genderFemale,
                        color: Colors.pink,
                      ),
                      'Female',
                      'FEMALE',
                    ),
                  ],
                  title: 'Pet gender',
                ),
                transitionsBuilder: transitionUpBuilder,
              ),
            )
                .then((value) {
              setState(() {
                _pet?.gender = value;
              });
              FocusScope.of(context).requestFocus(FocusNode());
            });
          },
          child: ListTile(
            title: Text(
              'GENDER',
              style: ptTitle(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_pet?.gender == 'FEMALE' || _pet?.gender == null)
                  Icon(
                    MdiIcons.genderFemale,
                    size: 20,
                    color: Colors.pink,
                  ),
                if (_pet?.gender != 'FEMALE')
                  SizedBox(
                    width: 10,
                  ),
                if (_pet?.gender == 'MALE' || _pet?.gender == null)
                  Icon(
                    MdiIcons.genderMale,
                    size: 20,
                    color: ptPrimaryColor(context),
                  ),
              ],
            ),
          ),
        ),
        Divider(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: TextFieldTags(
            onTag: (val) {
              // if (_pet.character == null) _pet.character = [];
              // _pet.character.add(val);
              // setState(() {});
            },
            onDelete: (val) {
              // if (_pet.character == null) _pet.character = [];
              // _pet.character.remove(val);
              // setState(() {});
            },
            initialTags: _pet?.character,
            textFieldStyler: TextFieldStyler(
              hintText: 'CHARACTER',
              textStyle: ptTitle(),
              helperText: null,
              textFieldBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              textFieldEnabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              textFieldFocusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
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
        Divider(
          height: 3,
        ),
      ],
    );
  }
}
