import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/model/vaccince_event_model.dart';
import 'package:petland/modules/my_pet/records/add_vaccine.dart';
import 'package:petland/modules/my_pet/records/detail_vaccine.dart';
import 'package:petland/share/import.dart';

class VaccinePage extends StatefulWidget {
  final PetModel pet;

  const VaccinePage({Key key, this.pet}) : super(key: key);
  static navigate(PetModel pet) {
    return navigatorKey.currentState.push(pageBuilder(VaccinePage(pet: pet)));
  }

  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  RecordBloc _recordBloc;
  List<VaccineEventModel> events;

  @override
  void didChangeDependencies() {
    if (_recordBloc == null) {
      _recordBloc = Provider.of<RecordBloc>(context);
      _getEvent();
    }
    super.didChangeDependencies();
  }

  _getEvent() async {
    final res = await _recordBloc.getListVaccineRecord(widget.pet.id);
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
          backgroundColor: ptBackgroundColor(context),
          appBar: innerAppBar(context, 'Vaccines'),
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
                                  DetailVaccinePage.navigate(widget.pet, item),
                              leading: Icon(
                                MdiIcons.needle,
                                size: 28,
                                color: ptPrimaryColor(context),
                              ),
                              title: Text('${item.vaccineType.name}'),
                              subtitle: Text(
                                Formart.formatToDate(
                                    DateTime.tryParse(item.date) ?? ''),
                              ));
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
                            Icon(
                              MdiIcons.needle,
                              size: 100,
                              color: ptPrimaryColor(context),
                            ),
                            SpacingBox(h: 2),
                            Text(
                              'Add vaccine for your pet here',
                              style:
                                  ptBigBody().copyWith(color: Colors.black54),
                            ),
                            SpacingBox(h: 1),
                            Text(
                              'Click on the button below to add some',
                              style: ptBody().copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
              ),
              ExpandRectangleButton(
                text: 'ADD NEW',
                onTap: () async {
                  final res = await AddVaccinePage.navigate(widget.pet);
                  if (res is VaccineEventModel) {
                    events.add(res);
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ),
        if (events == null) kLoadingSpinner
      ],
    );
  }
}
