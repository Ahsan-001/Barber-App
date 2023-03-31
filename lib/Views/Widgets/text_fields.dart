import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAirField extends StatelessWidget {
  TextAirField({
    Key? key,
    this.controlller,
    required this.title,
    this.validators,
    this.inputType,
    this.onchange,
    this.ontap,
    this.isReadOnly,
    this.obscure,
    this.suffix,
    this.prefix,
    this.hintText,
    this.lines,
    this.formater,
  }) : super(key: key);

  final TextEditingController? controlller;
  final String title;
  final TextInputType? inputType;
  final String? Function(String?)? validators;
  final Function(String)? onchange;
  final VoidCallback? ontap;
  final bool? isReadOnly;
  final bool? obscure;
  final Widget? suffix;
  final String? hintText;
  final String? prefix;
  final int? lines;
  final List<TextInputFormatter>? formater;

  final InputBorder noBorderWithRadius = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formater,
      obscureText: obscure ?? false,
      readOnly: isReadOnly ?? false,
      validator: validators,
      controller: controlller,
      cursorColor: kMainColor,
      keyboardType: inputType,
      textAlign: TextAlign.start,
      onChanged: onchange,
      maxLines: lines,
      onTap: ontap,
      style: const TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        prefixText: prefix,
        border: InputBorder.none,
        filled: true,
        fillColor: kWhiteColor,
        hintText: hintText,
        label: Text(title),
        labelStyle: const TextStyle(
          fontSize: 16.0,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        errorStyle: const TextStyle(
          color: kMainColor,
        ),
        errorBorder: errorOutlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        // enabledBorder: OutlineInputBorder(),
        // enabledBorder: noBorderWithRadius,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        suffixIcon: suffix,
      ),
    );
  }
}

final OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: kErrorColor, width: 2),
);

final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: kGreyColor, width: 2),
);

class DropDownField extends StatelessWidget {
  const DropDownField({
    Key? key,
    required this.listOfSelection,
    required this.onchange,
    required this.hint,
    required this.title,
    // this.validators,
  }) : super(key: key);

  final List<String> listOfSelection;
  final Function(String?)? onchange;
  final String hint;
  final String title;
  // final String? Function(String?)? validators;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' ' + title, style: kBoldText),
        const SizedBox(height: 4),
        DropdownButtonFormField2(
          // isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
          ),
          style: const TextStyle(fontSize: 15.0, color: kBlackColor),
          hint: Text(hint, style: const TextStyle(fontSize: 14)),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
              size: 30,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            height: 30,
            padding: EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          items: listOfSelection
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onchange,
        ),
      ],
    );
  }
}
