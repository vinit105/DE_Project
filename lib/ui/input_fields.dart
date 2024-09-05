import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? isMax;
  final bool? isInputNumber;
  final bool? isMAX;
  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.isMax,
      this.controller,
      this.widget,
      this.isInputNumber,
      this.isMAX});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                // color: Get.isDarkMode ? Colors.white : Colors.black
                color: Colors.black),
          ),
          Container(
            height: 52,
            padding: const EdgeInsets.only(left: 14.0),
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade600, width: 01.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    //length can be modified
                    maxLength: isMax == true
                        ? 255
                        : isMAX == true
                            ? 12
                            : null,
                    readOnly: widget == null ? false : true,
                    inputFormatters: isMAX == true
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                    autofocus: false,
                    keyboardType:
                        isInputNumber == true ? TextInputType.number : null,
                    cursorColor: Colors.black,
                    controller: controller,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    decoration: InputDecoration(
                      //counter text is showing the number of characters left....
                      counterText: "",
                      hintText: hint,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            //color: Colors.backgroundColor

                            // color: Theme.of(context).colorScheme.background,
                            width: 0,
                            color: Colors.transparent),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            //color: Colors.backgroundColor
                            width: 0,
                            color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
