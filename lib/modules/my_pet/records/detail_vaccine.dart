
import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/model/vaccince_event_model.dart';
import 'package:petland/model/vaccine_type_model.dart';
import 'package:petland/modules/my_pet/records/vaccine_type.dart';
import 'package:petland/share/import.dart';

class DetailVaccinePage extends StatefulWidget {
  final PetModel pet;
  final VaccineEventModel event;

  const DetailVaccinePage({Key key, this.pet, this.event}) : super(key: key);
  static Future navigate(PetModel pet, VaccineEventModel event) {
    return navigatorKey.currentState.push(pageBuilder(DetailVaccinePage(
      pet: pet,
      event: event,
    )));
  }

  @override
  _DetailVaccinePageState createState() => _DetailVaccinePageState();
}

class _DetailVaccinePageState extends State<DetailVaccinePage> {
  bool _checkRemider = false;
  bool _checkCreatePost = false;
  VaccineTypeModel selectedVaccine;
  DateTime date;
  List<String> images = [];
  List<String> videos = [];
  List<String> _allVideoAndImage = [];
  TextEditingController _contentC = TextEditingController();
  bool isLoading = false;
  RecordBloc _recordBloc;

  @override
  void initState() {
    date = DateTime.tryParse(widget.event.date ?? widget.pet.birthday);
    _checkCreatePost = widget.event.publicity;
    images = widget.event.images;
    videos = widget.event.videos;
    _allVideoAndImage = [...images, ...videos];
    _contentC.text = widget.event.content;
    _contentC.text = 'Happy birthday ${widget.pet.name}';
    _checkCreatePost = widget.event.publicity;
    _checkRemider = widget.event.remider;
    selectedVaccine = widget.event.vaccineType;
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
          appBar: innerAppBar(context, 'New vaccine'),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        highlightColor: ptAccentColor(context),
                        splashColor: ptPrimaryColor(context),
                        onTap: () {
                          VaccineTypePage.navigate(widget.pet.race.type)
                              .then((value) => setState(() {
                                    selectedVaccine = value;
                                  }));
                        },
                        child: ListTile(
                          title: Text(
                            'TYPE OF VACCINES',
                            style: ptTitle().copyWith(
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                                fontSize: 14),
                          ),
                          subtitle: Text(selectedVaccine?.name ?? 'Cần chọn'),
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
                            onAddImg: (str) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                                hintText:
                                    'Tiêm vac-xin cho pet cưng ${widget.pet.name}',
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
                                DateTime.now().subtract(Duration(days: 300)),
                            lastDate: DateTime.now().add(Duration(days: 300)),
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
                              Text(Formart.formatToDate(date) ?? 'Select'),
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
                      ListTile(
                        title: Text(
                          'REMIDER',
                          style: ptTitle().copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                              fontSize: 14),
                        ),
                        trailing: Switch(
                          activeColor: ptPrimaryColor(context),
                          value: _checkRemider,
                          onChanged: (val) {
                            setState(() {
                              _checkRemider = val;
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
        if (isLoading) kLoadingSpinner,
      ],
    );
  }
}
