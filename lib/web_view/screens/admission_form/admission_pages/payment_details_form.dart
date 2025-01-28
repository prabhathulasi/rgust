import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_payment_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class PaymentDetailsForm extends StatefulWidget {
  final PageController pageController;
  const PaymentDetailsForm({super.key, required this.pageController});

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.blue.shade800,
    exportBackgroundColor: Colors.white,
  );
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Consumer<AdmissionPaymentProvider>(
          builder: (context, admissionPaymentConsumer, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.webrgustLogo,
                        width: size.width * 0.08),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppRichTextView(
                            title:
                                "Rajiv Gandhi University of Science and Technology"
                                    .toUpperCase(),
                            fontSize: size.width * 0.02,
                            fontWeight: FontWeight.bold),
                        AppRichTextView(
                          fontStyle: FontStyle.italic,
                          title: "A Brand for Quality Eduation",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppRichTextView(
                        title: "Payment Details",
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
                        value: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppRichTextView(
                          title: "Method of Payment ?",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Bank Deposit",
                      groupValue:
                          admissionPaymentConsumer.paymentMethodRadioValue,
                      onChanged: (String? value) {
                        admissionPaymentConsumer.setPaymentRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Bank Deposit",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Wire Transfer",
                      groupValue:
                          admissionPaymentConsumer.paymentMethodRadioValue,
                      onChanged: (String? value) {
                        admissionPaymentConsumer.setPaymentRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Wire Transfer",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Others",
                      groupValue:
                          admissionPaymentConsumer.paymentMethodRadioValue,
                      onChanged: (String? value) {
                        admissionPaymentConsumer.setPaymentRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Others",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppRichTextView(
                        title: "Name:",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: AppTextFormFieldWidget(
                        onSaved: (p0) => admissionPaymentConsumer.name = p0,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Name is required";
                          }
                        },
                        obscureText: false,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    AppRichTextView(
                        title: "Date:",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: AppTextFormFieldWidget(
                        onSaved: (p0) => admissionPaymentConsumer.date = p0,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Date is required";
                          }
                        },
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DottedBorder(
                        strokeCap: StrokeCap.butt,
                        color: AppColors.colorc7e,
                        strokeWidth: 2,
                        child: SizedBox(
                            height: 200.h,
                            width: size.width,
                            child: InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                  allowMultiple: false,
                                );
                                if (result != null) {
                                  PlatformFile file = result.files.first;
                                  admissionPaymentConsumer.addFile(
                                      file.name, base64Encode(file.bytes!));
                                } else {
                                  ToastHelper().errorToast(
                                      "Please select a file to upload");
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImagePath.uploadPdfLogo,
                                    width: 50.w,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  AppRichTextView(
                                    title: "Please Attach PDF file to Upload",
                                    textColor: AppColors.colorBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: DottedBorder(
                        strokeCap: StrokeCap.butt,
                        color: AppColors.colorc7e,
                        strokeWidth: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppRichTextView(
                                    title: "Signature",
                                    textColor: AppColors.colorBlack,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _controller.clear();
                                      },
                                      child: const Icon(Icons.clear,
                                          color: AppColors.colorRed))
                                ],
                              ),
                              Signature(
                                controller: _controller,
                                height: 160.h,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                admissionPaymentConsumer.selectedFileName == null
                    ? Container()
                    : Card(
                        child: ListTile(
                          title:
                              Text(admissionPaymentConsumer.selectedFileName!),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.colorRed,
                            ),
                            onPressed: () {
                              admissionPaymentConsumer.clearFile();
                            },
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<AdmissionLoginProvider>(
                    builder: (context, admissionLoginConsumer, child) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: AppElevatedButon(
                      title: "Submit",
                      buttonColor: AppColors.colorc7e,
                      onPressed: (context) async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          if (admissionPaymentConsumer.selectedFileName ==
                              null) {
                            ToastHelper().errorToast("Please upload a file");
                            return;
                          }
                          if (admissionPaymentConsumer
                                  .paymentMethodRadioValue ==
                              null) {
                            ToastHelper()
                                .errorToast("Please select a payment method");
                            return;
                          }
                          if (_controller.isEmpty) {
                            ToastHelper()
                                .errorToast("Please sign the signature");
                            return;
                          }
                              var applicationId =
                                  admissionLoginConsumer.applicationId;
                          var response = await admissionPaymentConsumer
                              .postAdmissionPaymentDetails(
                                  int.parse(applicationId!), _controller.toPngBytes().toString());
                          if (response.statusCode == 201) {
                            ToastHelper().sucessToast(
                                "Application Submitted Successfully");
                 admissionLoginConsumer.setPage(false);
                          } else {
                            ToastHelper().errorToast(response.body.toString());
                          }
                        }
                      },
                      textColor: AppColors.colorWhite,
                      height: 50.h,
                      width: 200.w,
                    ),
                  );
                })
              ],
            ),
          ),
        );
      }),
    );
  }
}
