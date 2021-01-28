import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/share/import.dart';

class AddBirthdayPage extends StatefulWidget {
  final PetModel pet;
  AddBirthdayPage(this.pet);
  static navigate(PetModel pet) {
    return navigatorKey.currentState.push(pageBuilder(AddBirthdayPage(pet)));
  }

  @override
  _AddBirthdayPageState createState() => _AddBirthdayPageState();
}

class _AddBirthdayPageState extends State<AddBirthdayPage> {
  bool _checkCreatePost = false;
  RecordBloc _recordBloc;
  DateTime date;
  List<String> images = [];
  List<String> videos = [];
  bool isLoading = false;

  @override
  void initState() {
    date = DateTime.tryParse(widget.pet.birthday ?? '');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_recordBloc == null) {
      _recordBloc = Provider.of<RecordBloc>(context);
    }
    super.didChangeDependencies();
  }

  _addBirthday() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (date == null || images.length + videos.length == 0) {
        showToast('Chưa có đủ thông tin', context);
        return;
      }
      final res = await _recordBloc.createBirthdayRecord(widget.pet.id, images,
          videos, date.toIso8601String(), _checkCreatePost);
      if (res.isSuccess) {
        showToast('Đã lưu vào profile của pet', context, isSuccess: true);
        navigatorKey.currentState.maybePop();
      } else {
        showToast(res.errMessage, context);
      }
    } catch (e) {} finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: innerAppBar(context, 'This birthday'),
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
                            images,
                            onUpdateListImg: (listImg) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
              ExpandRectangleButton(
                text: 'SAVE',
                onTap: _addBirthday,
              )
            ],
          ),
        ),
        if (isLoading) kLoadingSpinner
      ],
    );
  }
}
