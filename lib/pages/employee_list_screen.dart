import 'package:employee_data/constants/arguments.dart';
import 'package:employee_data/constants/export.dart';
import 'package:employee_data/custom_widgets/custom_app_bar.dart';
import 'package:employee_data/models/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<EmployeeModel> employeeList=<EmployeeModel>[];

  @override
  void initState() {
    getEmployeeList();
    super.initState();
  }
  getEmployeeList() async {
    await DatabaseHelper.getEmployeesList().then((value) {
      if(value!=null){
        setState(() {

          employeeList=value.map((e) => EmployeeModel.fromJson(e)).toList();
        });
        debugPrint(value.toString());
        debugPrint(employeeList.length.toString());
      }



    }).onError((error, stackTrace) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.employeeList,
      onBackPress: () {
        Navigator.pop(context);
      },
      actions: [Padding(
        padding: EdgeInsets.only(right: margin_15),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Text(AppStrings.add,style: TextStyle(fontSize: font_14,fontWeight: FontWeight.bold),)),
      )],),
      body: employeeList.isEmpty?_noDataWidget(): _bodyPageView(),
    );
  }

  _userImage({int? gender}) {
    return Container(
      padding: EdgeInsets.all(margin_5),
      decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.black),

    ),
      child: Icon(gender==keyMale?Icons.male_rounded:Icons.female,size: height_60,),
    );
  }

  _userList(List<EmployeeModel> pageItems) {
    return ListView.separated(
      shrinkWrap: true,physics: NeverScrollableScrollPhysics(),padding: EdgeInsets.all( margin_15),
      itemCount: pageItems.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(children: [
            _userImage(gender:pageItems[index].gender??1),
            SizedBox(width: width_15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pageItems[index].name??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: font_16),),
                  Text(pageItems[index].email??"",style: TextStyle(fontSize: font_13),),
                  Text("${pageItems[index].salaryPerMonth??""}/ Month",style: TextStyle(fontSize: font_13),),
                ],),
            )
          ],),);
      }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: height_15,);
    },);
  }

  _bodyPageView() {
    return PageView.builder(
      itemCount: (employeeList.length/3).ceil(),
      itemBuilder: (context, pageIndex) {
        final startIndex = pageIndex * 3;
        final endIndex = startIndex + 3;
        final pageItems = employeeList.sublist(startIndex, endIndex < employeeList.length ? endIndex : employeeList.length);
        return _userList(pageItems);
      },);
  }

  _noDataWidget() {
    return Center(child: Text(AppStrings.noEmployeesFound,style: TextStyle(fontWeight: FontWeight.bold,fontSize: font_18),));
  }
}
