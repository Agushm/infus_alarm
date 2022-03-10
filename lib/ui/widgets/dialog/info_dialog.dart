// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

part of '../widgets.dart';

class InfoDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? onPressed;
  final String? btnText;

  InfoDialog(
      {Key? key,
      @required this.title,
      @required this.message,
      this.onPressed,
      this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close)),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(height: 20),
          onPressed != null
              ? MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Constants.primary,
                  onPressed: onPressed,
                  child:
                      Text('$btnText', style: TextStyle(color: Colors.white)))
              : SizedBox(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
