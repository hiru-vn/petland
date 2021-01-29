import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/birthday_event_model.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/records/add_birthday.dart';
import 'package:petland/modules/my_pet/records/detail_birthday.dart';
import 'package:petland/share/import.dart';

class BirthdayPage extends StatefulWidget {
  final PetModel pet;
  BirthdayPage(this.pet);
  static navigate(PetModel pet) {
    return navigatorKey.currentState.push(pageBuilder(BirthdayPage(pet)));
  }

  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  RecordBloc _recordBloc;
  List<BirthdayEventModel> events;

  @override
  void didChangeDependencies() {
    if (_recordBloc == null) {
      _recordBloc = Provider.of<RecordBloc>(context);
      _getEvent();
    }
    super.didChangeDependencies();
  }

  _getEvent() async {
    final res = await _recordBloc.getListBirthdayRecord(widget.pet.id);
    if (res.isSuccess) {
      setState(() {
        events = res.data;
      });
    } else {
      showToast(res.errMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: innerAppBar(
            context,
            'Birthday',
          ),
          body: Column(
            children: [
              Expanded(
                child: events != null && events.length != 0
                    ? ListView.separated(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final item = events[index];
                          return CustomListTile(
                            onTap: () =>
                                UpdateBirthdayPage.navigate(widget.pet, item),
                            leading: CircleAvatar(
                              backgroundImage: item.images.length > 0
                                  ? NetworkImage(item.images[0])
                                  : NetworkImage(widget.pet.avatar),
                            ),
                            title: Text(
                                '${DateTime.tryParse(item.date).year - DateTime.now().year} years old'),
                            subtitle: Text(item.content ?? ''),
                            trailing: Icon(
                              Icons.cake_outlined,
                              color: Colors.pink,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 3,
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                width: deviceWidth(context) / 1.2,
                                child: Image.asset(
                                    'assets/image/pet_birthday.jpg')),
                            SpacingBox(h: 2),
                            Text(
                              'Where you save birthday moments of your Pet',
                              style:
                                  ptBigBody().copyWith(color: Colors.black54),
                            ),
                            SpacingBox(h: 1),
                            Text(
                              'Click on the button below to celebrate',
                              style: ptBody().copyWith(color: Colors.black54),
                            ),
                            SpacingBox(h: 5),
                          ],
                        ),
                      ),
              ),
              ExpandRectangleButton(
                text: 'ADD NEW MOMENT',
                onTap: () {
                  AddBirthdayPage.navigate(widget.pet);
                },
              )
            ],
          ),
        ),
        if (events == null) kLoadingSpinner,
      ],
    );
  }
}
