import 'package:employee_data/constants/arguments.dart';

import 'package:employee_data/constants/export.dart';
import 'package:flutter/services.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? salaryPerMonthController;
  FocusNode? nameNode;
  FocusNode? emailNode;
  FocusNode? salaryPerMonthNode;
  List<GenderModel>? genderList;
  GenderModel? selectedGender;

  @override
  void initState() {
    initializeControllerAndNodes();
    genderList = <GenderModel>[
      GenderModel(id: keyMale, title: AppStrings.male),
      GenderModel(id: keyFemale, title: AppStrings.female),
    ];
    super.initState();
  }

  initializeControllerAndNodes() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    salaryPerMonthController = TextEditingController();
    nameNode = FocusNode();
    emailNode = FocusNode();
    salaryPerMonthNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.addEmployee,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(margin_15),
          child: Form(
            key: formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                _nameTextField(),
                SizedBox(height: height_15),
                _emailTextField(),
                SizedBox(height: height_15),
                _salaryTextField(),
                SizedBox(height: height_15),
                _genderDropDown(),
                SizedBox(height: height_15),
                _addButton(),
                SizedBox(height: height_15),
                _employeeListButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nameTextField() {
    return CustomTextFieldWidget(
      labelText: AppStrings.name,
      textController: nameController,
      maxLength: 40,
      focusNode: nameNode,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter ${AppStrings.name}";
        }
      },
      onSubmitted: (value) {
        emailNode?.requestFocus();
      },
    );
  }

  _emailTextField() {
    return CustomTextFieldWidget(
      labelText: AppStrings.email,
      textController: emailController,
      focusNode: emailNode,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter ${AppStrings.email}";
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value)) {
          return 'Please enter a valid ${AppStrings.email}';
        }
      },
      onSubmitted: (value) {
        salaryPerMonthNode?.requestFocus();
      },
    );
  }

  _salaryTextField() {
    return CustomTextFieldWidget(
      labelText: AppStrings.salaryPerMonth,
      textController: salaryPerMonthController,maxLength: 8,
      textInputType: TextInputType.number,
      focusNode: salaryPerMonthNode,inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter ${AppStrings.salaryPerMonth}";
        }
      },
    );
  }

  _genderDropDown() {
    return DropdownButtonFormField(
      value: selectedGender ?? null,
      hint: Text(AppStrings.gender),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      items: genderList?.map((GenderModel genderModel) {
        return DropdownMenuItem<GenderModel>(
            value: genderModel, child: Text(genderModel.title ?? ""));
      }).toList(),
      onChanged: (value) {
        selectedGender = value;
      },
    );
  }

  _addEmployee() async {
    Map<String, dynamic> map = <String, dynamic>{
      DatabaseValues.columnName: nameController?.text.trim(),
      DatabaseValues.columnEmail: emailController?.text.trim(),
      DatabaseValues.columnSalaryPerMonth:
          salaryPerMonthController?.text.trim(),
      DatabaseValues.columnGender: selectedGender?.id,
    };
    await DatabaseHelper.insertItemMap(model: map).then((value) {
      clearTextFields();
      Fluttertoast.showToast(msg: "Added Successfully");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    });
    // debugPrint(map.toString());
  }

  clearTextFields() {
    setState(() {
      formKey.currentState?.reset();
      nameController?.clear();
      emailController?.clear();
      salaryPerMonthController?.clear();
      selectedGender = null;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  _addButton() {
    return CustomButton(
      onPressed: () {
        if(formKey.currentState!.validate()){
          if(selectedGender!=null){
            print("Success");
            _addEmployee();
          }else{
            Fluttertoast.showToast(msg: "Please Choose ${AppStrings.gender}");
          }
        }

      },
      title: AppStrings.add,
    );
  }

  _employeeListButton() {
    return CustomButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeeListScreen(),
            ));
      },
      title: AppStrings.showEmployeeList,
    );
  }
}
