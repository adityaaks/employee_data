import 'package:employee_data/constants/export.dart';

class CustomButton extends StatelessWidget {
   VoidCallback? onPressed;
   String? title;
   CustomButton({this.title,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:onPressed?? () {

    },color:Theme.of(context).primaryColor,child: Text(title??"",style: TextStyle(color: Colors.white),),);
  }
}
