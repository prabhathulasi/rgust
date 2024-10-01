import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/enum/enum.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_personal_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_widget/gender_widget.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class PersonalDetailForm extends StatelessWidget {
  final PageController pageController;
  const PersonalDetailForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();
    TextEditingController dobinput = TextEditingController();
    final ScrollController scrollController = ScrollController();
    var size = MediaQuery.sizeOf(context);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdmissionPersonalProvider>(
          builder: (context, admissionPersonalConsumer, child) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppRichTextView(
                        title: "Personal Details",
                        textColor: AppColors.colorc7e,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: size.width * 0.2,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.colorGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.sp),
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
                Row(
                  children: [
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
                                    .titleDropdownvalue,

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
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.firstName = p0,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]')),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.lastName = p0,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]')),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
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
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.email = p0,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (p0) =>
                                EmailFormFieldValidator.validate(p0),
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.contactNumber = p0,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[+0-9]')),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (p0) =>
                                MobileNumberValidator.validate(p0),
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorRed, width: 2.w)),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                prefixIcon:
                                    const Icon(Icons.contact_page_outlined),
                                hintText: "Contact Number",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
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
                                color: AppColors.colorWhite, fontSize: 13.sp),
                            controller: dobinput,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorRed, width: 2.w)),
                                prefixIcon: const Icon(Icons.calendar_month),
                                hintText: "Date of Birth",
                                hintStyle: GoogleFonts.roboto(
                                    color: AppColors.colorGrey),
                                border: const OutlineInputBorder()),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: const ColorScheme.dark(
                                            primary: AppColors.colorc7e,
                                            onPrimary: Colors.white,
                                            surface: AppColors.colorWhite,
                                            onSurface: AppColors.colorc7e,
                                          ),
                                          dialogBackgroundColor:
                                              AppColors.colorc7e,
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

                                // setState(() {
                                //   dobinput.text =
                                //       formattedDate; //set output date to TextField value.
                                // });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                                  buttonColor: admissionPersonalConsumer
                                              .selectedGender ==
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
                                  textColor: admissionPersonalConsumer
                                              .selectedGender ==
                                          GenderEnum.male
                                      ? AppColors.colorWhite
                                      : AppColors.colorBlack),
                              SizedBox(
                                width: 10.w,
                              ),
                              GenderWidget(
                                  title: "Female",
                                  buttonColor: admissionPersonalConsumer
                                              .selectedGender ==
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
                                  textColor: admissionPersonalConsumer
                                              .selectedGender ==
                                          GenderEnum.female
                                      ? AppColors.colorWhite
                                      : AppColors.colorBlack),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
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
                                  border:
                                      Border.all(color: AppColors.colorGrey),
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      admissionPersonalConsumer
                                                  .selectedCountry ==
                                              null
                                          ? AppRichTextView(
                                              title:
                                                  "Please Select the Country",
                                              fontSize: 12.sp,
                                              textColor: AppColors.colorGrey,
                                              fontWeight: FontWeight.w400)
                                          : AppRichTextView(
                                              title: admissionPersonalConsumer
                                                  .selectedCountry!,
                                              fontSize: 12.sp,
                                              textColor: AppColors.colorBlack,
                                              fontWeight: FontWeight.w400),
                                      const Icon(
                                          Icons.keyboard_arrow_down_outlined)
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                                  items: admissionPersonalConsumer
                                      .ethinicityItems
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
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
                                  border:
                                      Border.all(color: AppColors.colorGrey),
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
                                              title:
                                                  "Please Select the Country",
                                              fontSize: 12.sp,
                                              textColor: AppColors.colorGrey,
                                              fontWeight: FontWeight.w400)
                                          : AppRichTextView(
                                              title: admissionPersonalConsumer
                                                  .selectCitizenCountry!,
                                              fontSize: 12.sp,
                                              textColor: AppColors.colorBlack,
                                              fontWeight: FontWeight.w400),
                                      const Icon(
                                          Icons.keyboard_arrow_down_outlined)
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.passportNum = p0,
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.homeAddress = p0,
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
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
                            onSaved: (p0) => admissionPersonalConsumer.mailingAddress = p0,
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
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
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
                    SizedBox(
                      width: 20.w,
                    ),
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
                    SizedBox(
                      width: 15.w,
                    ),
                    admissionPersonalConsumer.radioValue == "No"
                        ? Flexible(
                            flex: 1,
                            child: AppTextFormFieldWidget(
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
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppRichTextView(
                          title: "Will you require a student visa?",
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Yes",
                      groupValue: admissionPersonalConsumer.visaRadioValue,
                      onChanged: (String? value) {
                        admissionPersonalConsumer.setVisaRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Yes",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "No",
                      groupValue: admissionPersonalConsumer.visaRadioValue,
                      onChanged: (String? value) {
                        admissionPersonalConsumer.setVisaRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "No",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 15.w,
                    ),
                    admissionPersonalConsumer.visaRadioValue == "No"
                        ? Flexible(
                            flex: 1,
                            child: AppTextFormFieldWidget(
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
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppRichTextView(
                          title:
                              "Do you speak any other language other than English?",
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Yes",
                      groupValue: admissionPersonalConsumer.langRadioValue,
                      onChanged: (String? value) {
                        admissionPersonalConsumer.setLangRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Yes",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "No",
                      groupValue: admissionPersonalConsumer.langRadioValue,
                      onChanged: (String? value) {
                        admissionPersonalConsumer.setLangRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "No",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 15.w,
                    ),
                    admissionPersonalConsumer.langRadioValue == "Yes"
                        ? Flexible(
                            flex: 1,
                            child: AppTextFormFieldWidget(
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
                            ),
                          )
                        : Container(),
                  ],
                ),
                admissionPersonalConsumer.moreLang.isEmpty
                    ? Container()
                    : Wrap(
                        children:
                            admissionPersonalConsumer.moreLang.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Chip(
                              label: Text(item),
                              deleteIcon: const Icon(Icons.close),
                              onDeleted: () {
                                admissionPersonalConsumer
                                    .removeMoreLangValue(item);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppRichTextView(
                          title:
                              "Do you have a disability for which additional assistance may be required?",
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
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Yes",
                      groupValue: admissionPersonalConsumer.disablityRadioValue,
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
                      groupValue: admissionPersonalConsumer.disablityRadioValue,
                      onChanged: (String? value) {
                        admissionPersonalConsumer
                            .setdisabilityRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "No",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 15.w,
                    ),
                    admissionPersonalConsumer.disablityRadioValue == "Yes"
                        ? Flexible(
                            flex: 1,
                            child: AppTextFormFieldWidget(
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
                            ),
                          )
                        : Container(),
                  ],
                ),

           admissionPersonalConsumer.titleDropdownvalue == null ? Container():    Align(
                  alignment: Alignment.bottomRight,
                  child: AppElevatedButon(
                    title: "Save & Continue",
                    buttonColor: AppColors.colorc7e,
                    onPressed: (context) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn);
                      }
                    },
                    textColor: AppColors.colorWhite,
                    height: 50.h,
                    width: 200.w,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
