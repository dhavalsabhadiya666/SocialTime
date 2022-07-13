import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';


Widget textFieldWidget({TextEditingController? controller,ValueChanged<String>? onChanged,TextInputType? keyboardType,String? hint ,Widget? prefixIcon,Widget? suffixIcon,Color? fillColor,FormFieldValidator<String>? validator,FormFieldSetter<String>? onSaved}){
  return Container(
    //height: 50,
    child: TextFormField(
      style: const TextStyle(color: AppConstants.clrWhite),
      controller: controller,
      validator: validator,
      onSaved:onSaved ,
      onChanged: onChanged,

      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10,left: 10),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppConstants.clrBlack26),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppConstants.clrBlack26),
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppConstants.clrBlack26),
          ) ,
          focusColor: AppConstants.clrTransparent,
          filled: true,
          hintStyle: const TextStyle(color: AppConstants.clrLightGreyTxt),
          hintText: hint,
          fillColor: fillColor),

    ),
  );
}
