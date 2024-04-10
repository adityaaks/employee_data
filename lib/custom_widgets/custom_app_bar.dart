import 'package:employee_data/constants/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  VoidCallback? onBackPress;
  List<Widget>? actions;


  CustomAppBar({this.title,this.actions,this.onBackPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true,
        leading:onBackPress!=null? IconButton(onPressed:onBackPress?? () {

        }, icon: Icon(Icons.arrow_back_ios)):Container(),
        title: Text(
          title??"",
          style: TextStyle(fontSize: font_18, fontWeight: FontWeight.bold),
        ),
        actions:actions??[],
        backgroundColor: Theme.of(context).secondaryHeaderColor);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height_40);

}
