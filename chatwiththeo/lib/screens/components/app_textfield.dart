import 'package:chatwiththeo/model/position_model.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {required this.textInputAction,
      required this.titleText,
      required this.labelText,
      required this.keyboardType,
      required this.controller,
      super.key,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.suffixIcon,
      this.onEditingComplete,
      this.autofocus,
      this.focusNode,
      this.enabled,
      this.minLines,
      this.useTextField,
      this.initData,
      this.lisData,
      this.onChangedFormSelect});

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final String titleText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final int? minLines;
  final bool? enabled;
  final bool? useTextField;
  final void Function()? onEditingComplete;
  final PositionModel? initData;
  final List<PositionModel>? lisData;
  final void Function(PositionModel)? onChangedFormSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: AppTheme.titleMedium
              .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 7.0,
                    spreadRadius: 0,
                    offset: const Offset(0, 3))
              ]),
          child: (useTextField ?? true)
              ? TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  autofocus: autofocus ?? false,
                  validator: validator,
                  obscureText: obscureText ?? false,
                  obscuringCharacter: '*',
                  enabled: enabled,
                  onEditingComplete: onEditingComplete,
                  minLines: minLines ?? 1,
                  maxLines: minLines ?? 1,
                  decoration: InputDecoration(
                    isDense: true,
                    suffixIcon: suffixIcon,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    fillColor: Colors.white,
                    labelText: labelText == '' ? null : labelText,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: Color(0xffD3D1C5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: Color(0xffD3D1C5),
                      ),
                    ),
                  ),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : DropdownMenu<PositionModel>(
                  // initialSelection: ColorLabel.green,
                  // controller: colorController,
                  // requestFocusOnTap is enabled/disabled by platforms when it is null.
                  // On mobile platforms, this is false by default. Setting this to true will
                  // trigger focus request on the text field and virtual keyboard will appear
                  // afterward. On desktop platforms however, this defaults to true.
                  requestFocusOnTap: false,
                  width: MediaQuery.of(context).size.width - 40,
                  enableSearch: false,
                  onSelected: (PositionModel? item) => onChangedFormSelect,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  controller: controller,
                  initialSelection: initData,
                  inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20)),
                  dropdownMenuEntries: (lisData ?? [])
                      .map<DropdownMenuEntry<PositionModel>>(
                          (PositionModel data) {
                    return DropdownMenuEntry<PositionModel>(
                      value: data,
                      label: data.positionName ?? "",
                      enabled: true,
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
