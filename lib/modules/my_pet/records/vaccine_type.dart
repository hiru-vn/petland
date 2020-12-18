import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class VaccineTypePage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(VaccineTypePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Select vaccine'),
      body: ListView(
        children: [
          InkWell(
            highlightColor: ptAccentColor(context),
            splashColor: ptPrimaryColor(context),
            onTap: () {
              navigatorKey.currentState.maybePop();
            },
            child: ListTile(
              title: Text(
                'Vaccine phòng bệnh Dại',
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
              navigatorKey.currentState.maybePop();
            },
            child: ListTile(
              title: Text(
                'Vaccine phòng bệnh Giảm Bạch Cầu',
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
              navigatorKey.currentState.maybePop();
            },
            child: ListTile(
              title: Text(
                'Vaccine phòng bệnh Viêm mũi',
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
              navigatorKey.currentState.maybePop();
            },
            child: ListTile(
              title: Text(
                'Vaccine phòng bệnh do Herpervirus',
              ),
            ),
          ),
          Divider(
            height: 3,
          ),
          Divider(
            height: 3,
          ),
          InkWell(
            highlightColor: ptAccentColor(context),
            splashColor: ptPrimaryColor(context),
            onTap: () {
              navigatorKey.currentState.maybePop();
            },
            child: ListTile(
              title: Text(
                'Vắc xin tổng hợp',
              ),
            ),
          ),
          Divider(
            height: 3,
          ),
        ],
      ),
    );
  }
}
