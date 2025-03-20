import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/enum/enum.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_personal_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/admission_form/admission_widget/gender_widget.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileApplicationPersonalDetail extends StatefulWidget {
  final PageController pageController;
  const MobileApplicationPersonalDetail(
      {super.key, required this.pageController});

  @override
  State<MobileApplicationPersonalDetail> createState() =>
      _MobileApplicationPersonalDetailState();
}

class _MobileApplicationPersonalDetailState
    extends State<MobileApplicationPersonalDetail> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();

    var size = MediaQuery.sizeOf(context);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdmissionPersonalProvider>(
          builder: (context, admissionPersonalConsumer, child) {
        // Create a list of all values to check for null
        List<String?> values = [
          admissionPersonalConsumer.titleDropdownvalue,
          admissionPersonalConsumer.maritalDropdownvalue,
          admissionPersonalConsumer.selectedCountry,
          admissionPersonalConsumer.ethinicityDropdownvalue,
          admissionPersonalConsumer.selectCitizenCountry,
          //radio value
          admissionPersonalConsumer.radioValue,
          admissionPersonalConsumer.visaRadioValue,
          admissionPersonalConsumer.langRadioValue,
          admissionPersonalConsumer.disablityRadioValue,
        ];
        // Check if all values are null
        bool allValuesNull = values.any((value) => value == null);

        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.webrgustLogo, width: 80.w),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                maxLines: 2,
                                title:
                                    "Rajiv Gandhi University of Science and Technology",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold),
                            AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "A Brand for Quality Eduation",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppRichTextView(
                          title: "Personal Details",
                          textColor: AppColors.colorc7e,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                      const Spacer(),
                      SizedBox(
                        width: size.width / 4,
                        child: LinearProgressIndicator(
                          backgroundColor: AppColors.colorGrey,
                          borderRadius: BorderRadius.circular(20.sp),
                          color: AppColors.colorc7e,
                          minHeight: 15.sp,
                          value: 0.1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  admissionPersonalConsumer.selectedMediaFile == null
                      ? DottedBorder(
                          strokeCap: StrokeCap.butt,
                          color: AppColors.colorc7e,
                          strokeWidth: 2,
                          child: SizedBox(
                              height: 130.h,
                              width: size.width,
                              child: InkWell(
                                onTap: () async {
                                  var bytesFromPicker =
                                      await ImagePickerWeb.getImageInfo;
                                  // Get the size of the base64 string in bytes
                                  if (bytesFromPicker != null) {
                                    // Convert the base64 dataUrl to a Uint8List
                                    String base64String = bytesFromPicker
                                        .base64!
                                        .split(',')
                                        .last; // Remove the `data:image/png;base64,` part
                                    Uint8List imageBytes =
                                        base64Decode(base64String);
                                    admissionPersonalConsumer.setMediaFileValue(
                                        base64.encode(imageBytes));
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImagePath.uploadPdfLogo,
                                      width: 40.w,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    AppRichTextView(
                                      title:
                                          "Please Attach Photo in PNG format",
                                      textColor: AppColors.colorBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              )),
                        )
                      : Container(
                          height: 130.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(base64Decode(
                                          admissionPersonalConsumer
                                              .selectedMediaFile!))
                                      as ImageProvider),
                              border: Border.all()),
                          child: InkWell(
                            onTap: () {
                              admissionPersonalConsumer.setClearFileValue();
                            },
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.close,
                                color: AppColors.colorRed,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Title",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGrey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,

                              // Initial Value
                              hint: AppRichTextView(
                                  title: "Select",
                                  fontSize: 10.sp,
                                  textColor: AppColors.colorGrey,
                                  fontWeight: FontWeight.w400),
                              value:
                                  admissionPersonalConsumer.titleDropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: admissionPersonalConsumer.titleItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionPersonalConsumer
                                    .setTitleDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "First Name",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setFirstName(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.firstName = p0,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) => FirstNameValidator.validate(p0),
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            prefixIcon: const Icon(Icons.person_outline),
                            hintText: "Enter First Name",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Last Name",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setLastName(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.lastName = p0,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) => LastNameValidator.validate(p0),
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            prefixIcon: const Icon(Icons.person_outline),
                            hintText: "Enter Last Name",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Marital Status",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGrey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,

                              // Initial Value
                              hint: AppRichTextView(
                                  title: "Select",
                                  fontSize: 10.sp,
                                  textColor: AppColors.colorGrey,
                                  fontWeight: FontWeight.w400),
                              value: admissionPersonalConsumer
                                  .maritalDropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: admissionPersonalConsumer.maritalItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionPersonalConsumer
                                    .setMaritalDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Email Address",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setEmail(p0);
                        },
                        onSaved: (p0) => admissionPersonalConsumer.email = p0,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) => EmailFormFieldValidator.validate(p0),
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: "Enter Email Address",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Contact Number",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setContactNumber(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.contactNumber = p0,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) => MobileNumberValidator.validate(p0),
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            prefixIcon: const Icon(Icons.contact_page_outlined),
                            hintText: "Contact Number",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "DOB",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This DOB is Required";
                          } else {
                            return null;
                          }
                        },
                        style: GoogleFonts.roboto(
                            backgroundColor: AppColors.colorWhite,
                            color: AppColors.colorBlack,
                            fontSize: 13.sp),
                        controller: admissionPersonalConsumer.dobinput,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            prefixIcon: const Icon(Icons.calendar_month),
                            hintText: "Date of Birth",
                            hintStyle:
                                GoogleFonts.roboto(color: AppColors.colorGrey),
                            border: const OutlineInputBorder()),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: AppColors.colorc7e,
                                        onPrimary: Colors.white,
                                        surface: AppColors.colorWhite,
                                        onSurface: AppColors.colorc7e,
                                      ),
                                      dialogBackgroundColor: AppColors.colorc7e,
                                    ),
                                    child: child!);
                              },
                              barrierDismissible: false,
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1900), //- not to allow to choose before today.
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            //formatted date output using intl package =>  2021-03-16
                            admissionPersonalConsumer.dobinput!.text =
                                formattedDate;
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Gender",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          GenderWidget(
                              title: "Male",
                              buttonColor:
                                  admissionPersonalConsumer.selectedGender ==
                                          GenderEnum.male
                                      ? AppColors.colorc7e
                                      : AppColors.colorWhite,
                              buttonImage: IconPath.maleIcon,
                              height: 48.h,
                              width: 108.w,
                              onPressed: (context) {
                                admissionPersonalConsumer
                                    .setGender(GenderEnum.male);
                              },
                              textColor:
                                  admissionPersonalConsumer.selectedGender ==
                                          GenderEnum.male
                                      ? AppColors.colorWhite
                                      : AppColors.colorBlack),
                          SizedBox(
                            width: 10.w,
                          ),
                          GenderWidget(
                              title: "Female",
                              buttonColor:
                                  admissionPersonalConsumer.selectedGender ==
                                          GenderEnum.female
                                      ? AppColors.colorc7e
                                      : AppColors.colorWhite,
                              buttonImage: IconPath.femaleIcon,
                              height: 48.h,
                              width: 108.w,
                              onPressed: (context) {
                                admissionPersonalConsumer
                                    .setGender(GenderEnum.female);
                              },
                              textColor:
                                  admissionPersonalConsumer.selectedGender ==
                                          GenderEnum.female
                                      ? AppColors.colorWhite
                                      : AppColors.colorBlack),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Country of Birth",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  admissionPersonalConsumer.setCountryValue(
                                      country.displayNameNoCountryCode);

                                  print(
                                      'Select country: ${country.displayNameNoCountryCode}');
                                },

                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),

                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorc7e,
                                            width: 2.w)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorRed,
                                            width: 2.w)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: const TextStyle(
                                    color: AppColors.colorc7e,
                                    fontSize: 18,
                                  ),
                                ));
                          },
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorGrey),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  admissionPersonalConsumer.selectedCountry ==
                                          null
                                      ? AppRichTextView(
                                          title: "Please Select the Country",
                                          fontSize: 12.sp,
                                          textColor: AppColors.colorGrey,
                                          fontWeight: FontWeight.w400)
                                      : AppRichTextView(
                                          title: admissionPersonalConsumer
                                              .selectedCountry!,
                                          fontSize: 12.sp,
                                          textColor: AppColors.colorBlack,
                                          fontWeight: FontWeight.w400),
                                  const Icon(Icons.keyboard_arrow_down_outlined)
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Ethinicity",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorGrey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,

                              // Initial Value
                              hint: AppRichTextView(
                                  title: "Select",
                                  fontSize: 10.sp,
                                  textColor: AppColors.colorGrey,
                                  fontWeight: FontWeight.w400),
                              value: admissionPersonalConsumer
                                  .ethinicityDropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: admissionPersonalConsumer.ethinicityItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionPersonalConsumer
                                    .setEthinicityDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Country of Citizenship",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                showPhoneCode: false,
                                onSelect: (Country country) {
                                  admissionPersonalConsumer
                                      .setCitizenCountryValue(
                                          country.displayNameNoCountryCode);

                                  print(
                                      'Select country: ${country.displayNameNoCountryCode}');
                                },

                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorc7e,
                                            width: 2.w)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorRed,
                                            width: 2.w)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: const TextStyle(
                                    color: AppColors.colorc7e,
                                    fontSize: 18,
                                  ),
                                ));
                          },
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorGrey),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  admissionPersonalConsumer
                                              .selectCitizenCountry ==
                                          null
                                      ? AppRichTextView(
                                          title: "Please Select the Country",
                                          fontSize: 12.sp,
                                          textColor: AppColors.colorGrey,
                                          fontWeight: FontWeight.w400)
                                      : AppRichTextView(
                                          title: admissionPersonalConsumer
                                              .selectCitizenCountry!,
                                          fontSize: 12.sp,
                                          textColor: AppColors.colorBlack,
                                          fontWeight: FontWeight.w400),
                                  const Icon(Icons.keyboard_arrow_down_outlined)
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Passport Number",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setPassportNum(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.passportNum = p0,
                        validator: (p0) => PassportNumbValidator.validate(p0),
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            prefixIcon: const Icon(Icons.onetwothree),
                            hintText: "Enter Passport Number",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Permanent Home Address",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setHomeAddress(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.homeAddress = p0,
                        validator: (p0) => AddressValidator.validate(p0),
                        maxLines: 5,
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText: "Enter Home Address",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Current Mailing Address",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextFormFieldWidget(
                        onChanged: (p0) {
                          admissionPersonalConsumer.setMailingAddress(p0);
                        },
                        onSaved: (p0) =>
                            admissionPersonalConsumer.mailingAddress = p0,
                        validator: (p0) => AddressValidator.validate(p0),
                        maxLines: 5,
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorRed, width: 2.w)),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText: "Enter Current Address",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppRichTextView(
                                title:
                                    "Are you currently residing in your home country?",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "Yes",
                            groupValue: admissionPersonalConsumer.radioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer.setRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "Yes",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "No",
                            groupValue: admissionPersonalConsumer.radioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer.setRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "No",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      admissionPersonalConsumer.radioValue == "No"
                          ? AppTextFormFieldWidget(
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.colorc7e,
                                          width: 2.w)),
                                  hintText: "Enter Residing Country",
                                  hintStyle: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: AppColors.colorGrey)),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                              title: "Will you require a student visa?",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: 5.w,
                          ),
                          AppRichTextView(
                              textColor: AppColors.colorRed,
                              title: "*",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "Yes",
                            groupValue:
                                admissionPersonalConsumer.visaRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setVisaRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "Yes",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "No",
                            groupValue:
                                admissionPersonalConsumer.visaRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setVisaRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "No",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      admissionPersonalConsumer.visaRadioValue == "No"
                          ? AppTextFormFieldWidget(
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.colorc7e,
                                          width: 2.w)),
                                  hintText: "Enter Your Visa Type",
                                  hintStyle: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: AppColors.colorGrey)),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: AppRichTextView(
                                maxLines: 2,
                                title:
                                    "Do you speak any other language other than English?",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                                textColor: AppColors.colorRed,
                                title: "*",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "Yes",
                            groupValue:
                                admissionPersonalConsumer.langRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setLangRadioValue(value!);
                            },
                          ),
                          Flexible(
                            child: AppRichTextView(
                                title: "Yes",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "No",
                            groupValue:
                                admissionPersonalConsumer.langRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setLangRadioValue(value!);
                              admissionPersonalConsumer.clearMoreLangValue();
                            },
                          ),
                          Flexible(
                            child: AppRichTextView(
                                title: "No",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      admissionPersonalConsumer.langRadioValue == "Yes"
                          ? AppTextFormFieldWidget(
                              textEditingController: textcontroller,
                              onFieldSubmitted: (p0) {
                                admissionPersonalConsumer.setMoreLangValue(p0);
                                textcontroller.clear();
                              },
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.colorc7e,
                                          width: 2.w)),
                                  hintText: "Add More Languages",
                                  hintStyle: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: AppColors.colorGrey)),
                            )
                          : Container(),
                      admissionPersonalConsumer.moreLang.isEmpty
                          ? Container()
                          : Wrap(
                              direction: Axis.horizontal,
                              children: admissionPersonalConsumer.moreLang
                                  .map((item) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Chip(
                                      label: Text(item),
                                      deleteIcon: const Icon(Icons.close),
                                      onDeleted: () {
                                        admissionPersonalConsumer
                                            .removeMoreLangValue(item);
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: AppRichTextView(
                                maxLines: 2,
                                title:
                                    "Do you have a disability for which additional assistance may be required? ",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                                textColor: AppColors.colorRed,
                                title: "*",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "Yes",
                            groupValue:
                                admissionPersonalConsumer.disablityRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setdisabilityRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "Yes",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "No",
                            groupValue:
                                admissionPersonalConsumer.disablityRadioValue,
                            onChanged: (String? value) {
                              admissionPersonalConsumer
                                  .setdisabilityRadioValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "No",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      admissionPersonalConsumer.disablityRadioValue == "Yes"
                          ? AppTextFormFieldWidget(
                              maxLines: 3,
                              onFieldSubmitted: (p0) {
                                admissionPersonalConsumer.setMoreLangValue(p0);
                                textcontroller.clear();
                              },
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.colorc7e,
                                          width: 2.w)),
                                  hintText:
                                      "Please outline this disablity and the assitance required",
                                  hintStyle: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: AppColors.colorGrey)),
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  allValuesNull == true ||
                          admissionPersonalConsumer.selectedMediaFile == null
                      ? Container()
                      : Center(
                          child: Consumer<AdmissionLoginProvider>(builder:
                              (context, admissionLoginConsumer, child) {
                            return AppElevatedButon(
                              loading: admissionPersonalConsumer.isLoading,
                              title: "Save & Continue",
                              buttonColor: AppColors.colorc7e,
                              onPressed: (context) async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  var applicationId =
                                      prefs.getString("ApplicationId");

                                  log("applicationId$applicationId");
                                  var response = await admissionPersonalConsumer
                                      .postAdmissionPersonalDetails(
                                          int.parse(applicationId!));
                                  if (response.statusCode == 201) {
                                    widget.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        curve: Curves.easeIn);
                                  } else {
                                    ToastHelper()
                                        .errorToast(response.body.toString());
                                  }
                                } else {
                                  ToastHelper().errorToast(
                                      "Please Fill the Required Fields");
                                }
                              },
                              textColor: AppColors.colorWhite,
                              height: 40.h,
                              width: 200.w,
                            );
                          }),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
