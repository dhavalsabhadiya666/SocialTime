import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinmetar_app/utils/constants.dart';

Widget dropdownWidget({String? hintText,ValueChanged<String?>? onChanged1,List<String>? lsit, var selectedVal } ){
  return     Container(
    height: 48,
    decoration: BoxDecoration(
      color: AppConstants.clrBlack26,
      borderRadius: BorderRadius.circular(12),
    ),
    child: DropdownButton<String>(
      borderRadius: BorderRadius.circular(12),
      isExpanded: true,
      underline: const SizedBox(),
      icon: const SizedBox(),
      dropdownColor: AppConstants.clrBlack26,
      // focusColor: Colors.white,
      value: selectedVal,
      //elevation: 5,
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: AppConstants.clrWhite,
      items: lsit!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              value,
              style: TextStyle(
                  color: AppConstants.clrWhite),
            ),
          ),
        );
      }).toList(),
      hint: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(
              hintText!,
              style: TextStyle(
                  color: AppConstants.clrBlack26,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.expand_more_outlined,
              color: AppConstants.clrWhite,
            )
          ],
        ),
      ),
      onTap: (){

      },
      onChanged: onChanged1
    ),
  );
}