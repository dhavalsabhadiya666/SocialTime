import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';


Widget searchWidget({ValueChanged<String>? onSubmitted,ValueChanged<String>? onChanged,GestureTapCallback? onTap,TextEditingController? controller,String? hint ,Widget? prefixIcon,Widget? suffixIcon,Color? fillColor}){
  return Container(
    height: 50,
    child: TextField(
      style: const TextStyle(color: AppConstants.clrWhite),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10,left: 10),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppConstants.clrLightGreyTxt),
          ),
          focusColor: AppConstants.clrLightGreyTxt,
          filled: true,
          hintStyle: const TextStyle(color: AppConstants.clrLightGreyTxt),
          hintText: hint,
          fillColor: fillColor),onTap: onTap,
      onChanged:onChanged ,
      onSubmitted: onSubmitted,

    ),
  );
}
