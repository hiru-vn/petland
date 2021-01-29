import 'package:flutter/material.dart';
import 'package:petland/model/pet.dart';
import 'package:petland/modules/my_pet/records/add_vaccine.dart';
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
  @override
  Widget build(BuildContext context) {
    final list = [];
    return Scaffold(
      backgroundColor: ptBackgroundColor(context),
      appBar: innerAppBar(context, 'Vaccines'),
      body: Column(
        children: [
          Expanded(
            child: list.length != 0
                ? ListView(
                    children: [],
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
                          style: ptBigBody().copyWith(color: Colors.black54),
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
            onTap: () {
              AddVaccinePage.navigate(widget.pet);
            },
          )
        ],
      ),
    );
  }
}
