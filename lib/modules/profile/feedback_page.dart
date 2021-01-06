import 'package:petland/share/import.dart';

class FeedbackPage extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(FeedbackPage()));
  }

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: 'Feedback',
        automaticallyImplyLeading: true,
        actions: [
          Image.asset(
            'assets/image/logo.png',
            height: 27,
            width: 27,
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/feedback_bg.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 20,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/image/cat1.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              bottom: 100,
              left: 55,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50].withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  maxLines: null,
                  style: ptBigBody().copyWith(color: Colors.black54),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintMaxLines: 10,
                    hintText:
                        'Write here thoughts you want to tell us, can be bugs, proposals or anything else. We look forward to hearing from you!',
                    hintStyle: ptBody()
                        .copyWith(color: Colors.black54, letterSpacing: 1),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 35,
              child: RaisedButton(
                onPressed: () {
                  navigatorKey.currentState.maybePop();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text(
                    'Send',
                    style: ptBigTitle().copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
