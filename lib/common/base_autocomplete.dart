import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';
import 'base_button.dart';
import 'base_container.dart';
import 'base_empty_data_widget.dart';
import 'base_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'base_text.dart';

typedef OptionLabel = String? Function(dynamic value);
typedef OptionEqualToValue = bool Function(dynamic option, String query);

class MBAutocompleteFormField extends MBStatefulWidget {
  final String name;
  final String labelText;
  final dynamic initialValue;
  final List<dynamic> list;
  final OptionLabel getOptionLabel;
  final OptionEqualToValue isOptionEqualToValue;
  final String? Function(dynamic value) validator;
  final ValueChanged<dynamic> onChanged;

  const MBAutocompleteFormField({
    Key? key,
    required this.name,
    required this.initialValue,
    required this.labelText,
    required this.list,
    OptionLabel? getOptionLabel,
    OptionEqualToValue? isOptionEqualToValue,
    required this.validator,
    required this.onChanged,
  })  : getOptionLabel = getOptionLabel ?? _defaultGetOptionLabel,
        isOptionEqualToValue =
        (isOptionEqualToValue ?? _defaultIsOptionEqualToValue),
        super(key: key);

  static String? _defaultGetOptionLabel(dynamic value) => value as String?;

  static bool _defaultIsOptionEqualToValue(dynamic option, query) =>
      ((option as String?)?.toLowerCase().contains(query.toLowerCase()) ??
          false) ==
          true;

  @override
  MBState<MBAutocompleteFormField> createState() => _AutocompleteFormFieldState();
}

class _AutocompleteFormFieldState extends MBState<MBAutocompleteFormField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String query = '';

  @override
  void initState() {
    // TODO: implement initState
    if (widget.initialValue != null) {
      _controller.text = widget.getOptionLabel(widget.initialValue) ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (FormFieldState field) {
        final bool hasError = field.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                  labelText: widget.labelText,
                  errorText: hasError ? field.errorText : null,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey,
                    ),
                  )),
              onTap: _openAutocomplete,
              readOnly: true,
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
          ],
        );
      },
    );
  }

  void _openAutocomplete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MBText(
            localization.select,
            fontWeight: AppFonts.black,
            textAlign: TextAlign.center,
            color: AppColors.black,
            fontSize: 14,
          ),
          content: Wrap(
            runSpacing: 20,
            children: [
              AutocompleteDialogList(
                labelText: widget.labelText,
                list: widget.list,
                getOptionLabel: widget.getOptionLabel,
                isOptionEqualToValue: widget.isOptionEqualToValue,
                onChanged: widget.onChanged,
                controller: _controller,
              ),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: Row(
                  children: [
                    Expanded(
                      child: MBButton(
                        onPressed: () {
                          pop();
                        },
                        text: localization.cancel,
                        fontSize: 16,
                        fontWeight: AppFonts.black,
                        background: AppColors.gray_100,
                        color: AppColors.black,
                      ),
                    ),
                    20.ws,
                    Expanded(
                      child: MBButton(
                        onPressed: () {
                          pop();
                        },
                        text: localization.oK,
                        fontSize: 16,
                        fontWeight: AppFonts.black,
                        background: AppColors.primaryColor,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class AutocompleteDialogList extends MBStatefulWidget {
  final String labelText;
  final List<dynamic> list;
  final String? Function(dynamic value) getOptionLabel;
  final bool Function(dynamic option, String query) isOptionEqualToValue;
  final ValueChanged<dynamic> onChanged;
  final TextEditingController controller;

  static String get id {
    const Type type = AutocompleteDialogList;
    return '$type';
  }

  const AutocompleteDialogList(
      {required this.labelText,
        required this.list,
        required this.controller,
        required this.getOptionLabel,
        required this.isOptionEqualToValue,
        required this.onChanged,
        Key? key})
      : super(key: key);

  @override
  MBState<AutocompleteDialogList> createState() =>
      _AutocompleteDialogListState();
}

class _AutocompleteDialogListState extends MBState<AutocompleteDialogList> {
  final FocusNode _focusNode = FocusNode();
  String query = '';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.list
        .where((item) => widget.isOptionEqualToValue(item, query))
        .toList();
    return SizedBox(
      width: 0.8.sw,
      height: 0.5.sh, // // Adjust the height as needed
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: widget.labelText,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey,
                  ),
                )),
            onChanged: _onSearchTextChanged,
          ),
          16.hs,
          Expanded(
            child: list.isNotEmpty
                ? ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              // Disable scrolling
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final option = list[index];
                return MBContainer(
                  // color: AppColors.gray_100,
                    borderWidth: 1,
                    borderColor: AppColors.gray_200,
                    child: ListTile(
                      title: MBText(widget.getOptionLabel(option)),
                      onTap: () {
                        widget.controller.text =
                            widget.getOptionLabel(option) ?? "";
                        _focusNode.requestFocus();
                        widget.onChanged(list[index]);
                        pop();
                      },
                    ));
              },
              shrinkWrap: true, // Enable shrinkWrap to wrap the content
            )
                : const MBEmptyDataWidget(),
          ),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      query = value;
    });
  }
}
