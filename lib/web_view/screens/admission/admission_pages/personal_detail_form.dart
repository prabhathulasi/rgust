import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_widget/gender_widget.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class PersonalDetailForm extends StatelessWidget {
  const PersonalDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();
    TextEditingController dobinput = TextEditingController();
    var size = MediaQuery.sizeOf(context);

    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppRichTextView(
                      title: "Title",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 10.h,
                  ),
                  Consumer<AdmissionProvider>(
                      builder: (context, admissionConsumer, child) {
                    return Container(
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
                            value: admissionConsumer.titleDropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionConsumer.titleItems
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionConsumer
                                  .setTitleDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
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
                    AppRichTextView(
                        title: "First Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
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
              ),
              SizedBox(
                width: 20.w,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Last Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
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
                  AppRichTextView(
                      title: "Marital Status",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
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
                          value: admissionConsumer.maritalDropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: admissionConsumer.maritalItems
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            admissionConsumer
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
                    AppRichTextView(
                        title: "Email Address",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
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
              ),
              SizedBox(
                width: 20.w,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Contact Number",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
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
                    AppRichTextView(
                        title: "DOB",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
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
                          prefixIcon: const Icon(Icons.calendar_month),
                          hintText: "Date of Birth",
                          hintStyle:
                              GoogleFonts.roboto(color: AppColors.colorGrey),
                          border: const OutlineInputBorder()),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
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
                    AppRichTextView(
                        title: "Gender",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        GenderWidget(
                          title: "Male",
                          buttonColor: AppColors.colorWhite,
                          buttonImage: IconPath.maleIcon,
                          height: 48.h,
                          width: 108.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorBlack,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GenderWidget(
                          title: "Female",
                          buttonColor: AppColors.colorWhite,
                          buttonImage: IconPath.femaleIcon,
                          height: 48.h,
                          width: 108.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorBlack,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GenderWidget(
                          title: "Others",
                          buttonColor: AppColors.colorWhite,
                          buttonImage: IconPath.othersIcon,
                          height: 48.h,
                          width: 108.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorBlack,
                        ),
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
                    AppRichTextView(
                        title: "Country of Birth",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                admissionConsumer.setCountryValue(
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
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: const TextStyle(
                                  color: Colors.blue,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                admissionConsumer.selectedCountry == null
                                    ? AppRichTextView(
                                        title: "Please Select the Country",
                                        fontSize: 12.sp,
                                        textColor: AppColors.colorGrey,
                                        fontWeight: FontWeight.w400)
                                    : AppRichTextView(
                                        title:
                                            admissionConsumer.selectedCountry!,
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
              ),
              SizedBox(
                width: 20.w,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Ethinicity",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    Consumer<AdmissionProvider>(
                        builder: (context, admissionConsumer, child) {
                      return Container(
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
                              value: admissionConsumer.ethinicityDropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: admissionConsumer.ethinicityItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionConsumer
                                    .setEthinicityDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                      );
                    }),
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
                    AppRichTextView(
                        title: "Country of Citizenship",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                admissionConsumer.setCitizenCountryValue(
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
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: const TextStyle(
                                  color: Colors.blue,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                admissionConsumer.selectCitizenCountry == null
                                    ? AppRichTextView(
                                        title: "Please Select the Country",
                                        fontSize: 12.sp,
                                        textColor: AppColors.colorGrey,
                                        fontWeight: FontWeight.w400)
                                    : AppRichTextView(
                                        title: admissionConsumer
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
              ),
              SizedBox(
                width: 20.w,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Passport Number",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
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
                    AppRichTextView(
                        title: "Permanent Home Address",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      maxLines: 5,
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorc7e, width: 2.w)),
                          hintText: "Enter Home Address",
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 12.sp, color: AppColors.colorGrey)),
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
                    AppRichTextView(
                        title: "Current Mailing Address",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      maxLines: 5,
                      obscureText: false,
                      inputDecoration: InputDecoration(
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
                    title: "Which country do you currently reside in?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionConsumer.radioValue,
                onChanged: (String? value) {
                  admissionConsumer.setRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.radioValue,
                onChanged: (String? value) {
                  admissionConsumer.setRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              SizedBox(
                width: 15.w,
              ),
              admissionConsumer.radioValue == "No"
                  ? Flexible(
                      flex: 1,
                      child: AppTextFormFieldWidget(
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText: "Enter Residing Country",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
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
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionConsumer.visaRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setVisaRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.visaRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setVisaRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              SizedBox(
                width: 15.w,
              ),
              admissionConsumer.visaRadioValue == "No"
                  ? Flexible(
                      flex: 1,
                      child: AppTextFormFieldWidget(
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText: "Enter Your Visa Type",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
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
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionConsumer.langRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setLangRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.langRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setLangRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              SizedBox(
                width: 15.w,
              ),
              admissionConsumer.langRadioValue == "Yes"
                  ? Flexible(
                      flex: 1,
                      child: AppTextFormFieldWidget(
                        textEditingController: textcontroller,
                        onFieldSubmitted: (p0) {
                          admissionConsumer.setMoreLangValue(p0);
                          textcontroller.clear();
                        },
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText: "Add More Languages",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      ),
                    )
                  : Container(),
            ],
          ),
          admissionConsumer.moreLang.isEmpty
              ? Container()
              : Wrap(
                  children: admissionConsumer.moreLang.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Chip(
                        label: Text(item),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () {
                          admissionConsumer.removeMoreLangValue(item);
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
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionConsumer.disablityRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setdisabilityRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.disablityRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setdisabilityRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              SizedBox(
                width: 15.w,
              ),
              admissionConsumer.disablityRadioValue == "Yes"
                  ? Flexible(
                      flex: 1,
                      child: AppTextFormFieldWidget(
                        maxLines: 3,
                        onFieldSubmitted: (p0) {
                          admissionConsumer.setMoreLangValue(p0);
                          textcontroller.clear();
                        },
                        obscureText: false,
                        inputDecoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.colorc7e, width: 2.w)),
                            hintText:
                                "Please outline this disablity and the assitance required",
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 12.sp, color: AppColors.colorGrey)),
                      ),
                    )
                  : Container(),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AppElevatedButon(
              title: "Save & Continue",
              buttonColor: AppColors.colorc7e,
              onPressed: (context) {
              admissionConsumer.setPersonalSectionValue(true);
              },
              textColor: AppColors.colorWhite,
              height: 50.h,
              width: 200.w,
            ),
          )
        ],
      );
    });
  }
}
