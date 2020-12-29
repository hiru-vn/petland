import 'package:flutter/material.dart';
import 'package:petland/modules/my_pet/records/add_birthday.dart';
import 'package:petland/share/import.dart';

class BirthdayPage extends StatelessWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(BirthdayPage()));
  }

  @override
  Widget build(BuildContext context) {
    final list = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: innerAppBar(context, 'Birthday'),
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
                        SizedBox(
                            width: deviceWidth(context) / 1.2,
                            child:
                                Image.asset('assets/image/pet_birthday.jpg')),
                        SpacingBox(h: 2),
                        Text(
                          'Where you save birthday moments of your Pet',
                          style: ptBigBody().copyWith(color: Colors.black54),
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
              AddBirthdayPage.navigate();
            },
          )
        ],
      ),
    );
  }
}
