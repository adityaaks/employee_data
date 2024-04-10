import 'package:employee_data/constants/export.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  TextEditingController? textController;
  FocusNode? focusNode;
  String? labelText;
  int? maxLength;
  FormFieldValidator<String>? validator;
  TextInputAction? textInputAction;
  ValueChanged<String>? onSubmitted;
  List<TextInputFormatter>? inputFormatter;
  TextInputType? textInputType;

  CustomTextFieldWidget(
      {this.textController,
      this.validator,
      this.focusNode,
      this.textInputType,
      this.maxLength,
      this.labelText,
      this.onSubmitted,
      this.textInputAction,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textController,
        focusNode: focusNode,autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,keyboardType:textInputType?? TextInputType.text,
        textInputAction: textInputAction??TextInputAction.next,
        onFieldSubmitted: onSubmitted,
        inputFormatters: inputFormatter,maxLength:maxLength ,
        decoration: InputDecoration(counterText: "",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: labelText ?? ""));
  }
}
