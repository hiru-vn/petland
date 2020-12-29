import 'package:flutter/material.dart';
import 'package:petland/modules/my_pet/records/vaccine_type.dart';
import 'package:petland/share/import.dart';

class AddBirthdayPage extends StatefulWidget {
  static navigate() {
    return navigatorKey.currentState.push(pageBuilder(AddBirthdayPage()));
  }

  @override
  _AddBirthdayPageState createState() => _AddBirthdayPageState();
}

class _AddBirthdayPageState extends State<AddBirthdayPage> {
  bool _checkCreatePost = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'This birthday'),
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
                      VaccineTypePage.navigate();
                    },
                    child: ListTile(
                      title: Text(
                        'TYPE OF VACCINES',
                        style: ptTitle().copyWith(
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                            fontSize: 14),
                      ),
                      subtitle: Text('Vaccine phòng bệnh do Herpervirus'),
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
                        [
                          'https://media2.giphy.com/media/H4DjXQXamtTiIuCcRU/giphy.gif'
                        ],
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
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      );
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
                          Text('Select'),
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
            onTap: () {
              navigatorKey.currentState.maybePop();
            },
          )
        ],
      ),
    );
  }
}
