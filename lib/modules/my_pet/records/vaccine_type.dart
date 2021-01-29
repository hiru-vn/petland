import 'package:flutter/material.dart';
import 'package:petland/bloc/record_bloc.dart';
import 'package:petland/model/vaccine_type_model.dart';
import 'package:petland/share/import.dart';

class VaccineTypePage extends StatefulWidget {
  final String raceType;
  VaccineTypePage(this.raceType);
  static Future navigate(String raceType) {
    return navigatorKey.currentState
        .push(pageBuilder(VaccineTypePage(raceType)));
  }

  @override
  _VaccineTypePageState createState() => _VaccineTypePageState();
}

class _VaccineTypePageState extends State<VaccineTypePage> {
  RecordBloc _recordBloc;
  List<VaccineTypeModel> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_recordBloc == null) {
      _recordBloc = Provider.of<RecordBloc>(context);
      getList();
    }
    super.didChangeDependencies();
  }

  Future getList() async {
    final res = await _recordBloc.getListVaccineType(widget.raceType);
    if (res.isSuccess) {
      setState(() {
        list = res.data;
      });
    } else {
      showToast(res.errMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: innerAppBar(context, 'Select vaccine'),
      body: list == null
          ? kLoadingSpinner
          : ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return InkWell(
                  highlightColor: ptAccentColor(context),
                  splashColor: ptPrimaryColor(context),
                  onTap: () {
                    navigatorKey.currentState.maybePop(item);
                  },
                  child: ListTile(
                    title: Text(
                      item.name,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 3,
              ),
            ),
    );
  }
}
