import 'package:google_fonts/google_fonts.dart';
import 'package:petland/share/import.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final List<Widget> actions;
  final Color bgColor;
  final Widget leading;

  MyAppBar({this.actions, this.bgColor, this.leading});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: leading,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 27,
              width: 27,
              child: Image.asset('assets/image/logo.png')),
          SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'PetLand',
              style: GoogleFonts.allertaStencil(
                  letterSpacing: 0.2,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: ptPrimaryColor(context)),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }
}

innerAppBar(BuildContext context, String title,
        {List<Widget> actions, Function(String) onSearch}) =>
    AppBar(
      elevation: 0,
      backgroundColor: ptPrimaryColor(context),
      title: Text(
        title,
        style: GoogleFonts.nunito(
            color: Colors.white, fontWeight: FontWeight.w400),
      ),
      leading: GestureDetector(
        onTap: () {
          navigatorKey.currentState.maybePop();
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
              child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
        ),
      ),
      centerTitle: true,
      actions: actions,
      bottom: onSearch != null ? SearchBar() : null,
    );
