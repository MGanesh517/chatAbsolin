import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonComponents {
  static Column defaultTextField(context,
      {TextEditingController? controller,
      String? title = '',
      String? hintText,
      String? errorText,
      String? initialValue,
      bool? readOnly = false,
      bool? enable = true,
      bool? filled = false,
      Widget? prefixIcon,
      Widget? suffixIcon,
      int? maxLength,
      // int? maxLines,
      // int? minLines,
      bool? obscureText = false,
      List<TextInputFormatter>? inputFormatters,
      TextInputAction? textInputAction,
      TextInputType? keyboardType,
      FocusNode? focusNode,
      TextCapitalization? textCapitalization,
      TextAlign? textAlign = TextAlign.left,
      InputDecoration? decoration,
      validator,
      void Function(String?)? onSaved,
      void Function()? onTap,
      void Function()? onEditingComplete,
      void Function(String)? onChange,
      void Function(String)? onFieldSubmitted}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                  Container(
                    height: 8,
                  ),
                ],
              )
            : Container(),
        TextFormField(
          autofocus: false,
          maxLength: maxLength,
          readOnly: readOnly!,
          enabled: enable,
          initialValue: initialValue,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          focusNode: focusNode,
          textInputAction: textInputAction,
          // maxLines: maxLines,
          // minLines: minLines,
          textAlign: textAlign!,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          cursorColor: Theme.of(context).colorScheme.primary,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              // contentPadding: EdgeInsets.symmetric(horizontal: 0),
              // label: Text(
              //   title!,
              //   style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w500, fontSize: 12),
              // ),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              // floatingLabelAlignment: FloatingLabelAlignment.start,
              counterText: '',
              hintText: hintText,
              errorStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.red),
              hintStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              suffixIconConstraints: BoxConstraints(minHeight: 10, minWidth: 10, maxHeight: 20, maxWidth: 60),
              prefixIconConstraints: BoxConstraints(minHeight: 10, minWidth: 10, maxHeight: 20, maxWidth: 100),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide.none),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: BorderSide.none)),
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onTap: onTap,
          validator: validator,
          onEditingComplete: onEditingComplete,
        ),
        errorText != null
            ? Column(
                children: [
                  Container(
                    height: 2,
                  ),
                  Text(
                    errorText,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: Colors.red),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  static Column defaultDropdownSearch<T>(context,
      {Key? key,
      //   TextEditingController? controller,
      String? title,
      String? hintText,
      bool? enabled,
      List<T>? items,
      validator,
      Future<List<T>> Function(String)? asyncItems,
      compareFn,
      itemAsString,
      selectedItem,
      onChanged,
      itemBuilder,
      bool? showTitle = true}) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: showTitle == true ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w500, fontSize: 10)),
            Container(height: 8),
          ],
        ),
      ),
      DropdownSearch<T>(
          autoValidateMode: AutovalidateMode.onUserInteraction,
          asyncItems: asyncItems ?? asyncItems,
          items: items ?? [],
          key: ValueKey(title),
          dropdownButtonProps: const DropdownButtonProps(icon: Icon(Icons.keyboard_arrow_down)),
          // clearButtonProps:  ClearButtonProps(isVisible: true),
          validator: validator,
          compareFn: compareFn,
          enabled: enabled ?? true,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
              // border: OutlineInputBorder(
              //     borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer), borderRadius: BorderRadius.circular(15)),
              // labelText: title,
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              hintStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Select $title",
              // filled: true,
              // fillColor: Colors.grey[100],
            ),
          ),
          popupProps: PopupPropsMultiSelection.modalBottomSheet(
              showSelectedItems: true,
              showSearchBox: true,
              itemBuilder: itemBuilder,
              fit: FlexFit.tight,
              searchFieldProps: const TextFieldProps(
                  decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0xffFAFAFF),
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Theme.of(context).colorScheme.primaryContainer), borderRadius: BorderRadius.circular(15)),
                suffixIcon: Icon(Icons.search),
                // labelText: 'Search Here',
                // labelStyle:  TextStyle(fontSize: 16),
                // floatingLabelAlignment: FloatingLabelAlignment.start,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Search Here',
              )),
              modalBottomSheetProps: ModalBottomSheetProps(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  )),
              title: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  // boxShadow:  [BoxShadow(color: Theme.of(context).colorScheme.secondary, blurRadius: 10.0)],
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              )),
          itemAsString: itemAsString,
          selectedItem: selectedItem,
          onChanged: onChanged),
      // const SizedBox(height: 24)
    ]);
  }
}
