import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/birthday_event_model.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/share/import.dart';

class UpdateBirthdayPage extends StatefulWidget {
  final PetModel pet;
  final BirthdayEventModel event;
  UpdateBirthdayPage(this.pet, this.event);
  static navigate(PetModel pet, BirthdayEventModel event) {
    return navigatorKey.currentState
        .push(pageBuilder(UpdateBirthdayPage(pet, event)));
  }

  @override
  _UpdateBirthdayPageState createState() => _UpdateBirthdayPageState();
}

class _UpdateBirthdayPageState extends State<UpdateBirthdayPage> {
  bool _checkCreatePost = false;
  RecordBloc _recordBloc;
  DateTime date;
  List<String> images = [];
  List<String> videos = [];
  List<String> _allVideoAndImage = [];
  TextEditingController _contentC = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    date = DateTime.tryParse(widget.event.date ?? widget.pet.birthday);
    _checkCreatePost = widget.event.publicity;
    images = widget.event.images;
    videos = widget.event.videos;
    _allVideoAndImage = [...images, ...videos];
    _contentC.text = widget.event.content;
    _contentC.text = 'Happy birthday ${widget.pet.name}';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_recordBloc == null) {
      _recordBloc = Provider.of<RecordBloc>(context);
    }
    super.didChangeDependencies();
  }

  Future _delete() async {
    setState(() {
      isLoading = true;
    });
    final confirm = await showConfirmImageDialog(
        context,
        'Bạn chắc chứ?',
        'Kỉ niệm bị xóa của ${widget.pet.name} sẽ không thể khôi phục lại.',
        'assets/image/pet_delete_dialog.jpg');
    if (confirm) {
      final res = await _recordBloc.deleteBirthdayEvent(widget.event.id);
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: innerAppBar(context, 'This birthday', actions: [
            IconButton(
              onPressed: _delete,
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ]),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Text(
                          'Upload images and videos',
                          style: ptTitle().copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          height: 110,
                          child: ImageRowPicker(
                            _allVideoAndImage,
                            onUpdateListImg: (listImg) {},
                            onAddImg: (img) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 3,
                      ),
                      InkWell(
                        highlightColor: ptAccentColor(context),
                        splashColor: ptPrimaryColor(context),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                          child: TextField(
                            controller: _contentC,
                            decoration: InputDecoration(
                                hintText: 'Happy birthday ${widget.pet.name}',
                                border: InputBorder.none),
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
                            firstDate:
                                DateTime.now().subtract(Duration(days: 500)),
                            lastDate: DateTime.now(),
                          ).then((value) => setState(() {
                                date = value;
                              }));
                        },
                        child: ListTile(
                          title: Text(
                            'DATE',
                            style: ptTitle().copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                                fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(date != null
                                  ? Formart.formatToDate(date)
                                  : 'Select'),
                              SizedBox(width: 10),
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
                      ListTile(
                        title: Text(
                          'CREATE PUBLIC POST',
                          style: ptTitle().copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                        trailing: Switch(
                          activeColor: ptPrimaryColor(context),
                          value: _checkCreatePost,
                          onChanged: (val) {
                            setState(() {
                              _checkCreatePost = val;
                            });
                          },
                        ),
                      ),
                      Divider(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLoading) kLoadingSpinner
      ],
    );
  }
}
