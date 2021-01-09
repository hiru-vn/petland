import 'package:google_fonts/google_fonts.dart';
import 'package:petland/share/import.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final List<Widget> actions;
  final Color bgColor;
  final Widget leading;
  final String title;
  final bool automaticallyImplyLeading;
  final bool centerTitle;

  MyAppBar(
      {this.actions,
      this.bgColor,
      this.leading,
      this.title,
      this.centerTitle = false,
      this.automaticallyImplyLeading = false});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      centerTitle: centerTitle,
      title: Row(
        mainAxisSize: centerTitle ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (!automaticallyImplyLeading) ...[
            Image.asset(
              'assets/image/logo.png',
              height: 27,
              width: 27,
            ),
            SizedBox(
              width: 7,
            ),
          ],
          Text(
            title ?? 'PetLand',
            style: ptBigTitle().copyWith(
                color: bgColor != null ? Colors.white : Colors.black87),
          ),
        ],
      ),
      actions: actions,
    );
  }
}

innerAppBar(BuildContext context, String title,
        {List<Widget> actions,
        Function(String) onSearch,
        final Color bgColor}) =>
    AppBar(
      elevation: 0,
      backgroundColor: bgColor ?? ptPrimaryColor(context),
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
