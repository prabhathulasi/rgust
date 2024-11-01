import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_detailed_layout/alerts/update_fees_detail_alert.dart';

import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/student_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/update_student_details/update_student_detail.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:u_credit_card/u_credit_card.dart';

class StudentDetailView extends StatefulWidget {
  final int studentId;

  const StudentDetailView({
    super.key,
    required this.studentId,
  });

  @override
  State<StudentDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<StudentDetailView> {
  String? password;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  showAddAlertDialog(BuildContext context, StudentDetail details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          UpdateStudentDetails(studentDetails: details),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0.sp,
                    backgroundColor: AppColors.colorc7e,
                    child: CircleAvatar(
                        backgroundColor: AppColors.colorWhite,
                        radius: 12.sp,
                        child:
                            const Icon(Icons.close, color: AppColors.colorRed)),
                  ),
                )),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  Future<void> remainderDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 350.h,
              width: 400.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                      title: "Fees Remainder",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      textStyle: TextStyle(fontSize: 15.sp),
                      maxLines: 5,
                      inputDecoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(fontSize: 15.sp),
                          border: const OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        AppElevatedButon(
                          title: "Send",
                          borderColor: AppColors.colorWhite,
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 150.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorWhite,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AppElevatedButon(
                          title: "Cancel",
                          borderColor: AppColors.colorWhite,
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 150.w,
                          onPressed: (context) {
                            Navigator.pop(context);
                          },
                          textColor: AppColors.colorWhite,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final programProvider =
        Provider.of<ProgramProvider>(context, listen: false);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    Future getStudentDetail() async {
      var token = await getTokenAndUseIt();
      if (token == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else if (token == "Token Expired") {
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result =
            await studentProvider.getStudentDetailById(widget.studentId, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return FutureBuilder(
        future: getStudentDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitSpinningLines(
                color: AppColors.colorc7e,
              ),
            );
          } else {
            return Consumer<StudentProvider>(
                builder: (context, studentConsumer, child) {
              final studentData =
                  studentConsumer.studentDetailModel.studentDetail!;
              return Padding(
                padding: EdgeInsets.all(3.0.sp),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.colorc7e, width: 3.w),
                                color: AppColors.colorWhite,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0.w),
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 60.sp,
                                                backgroundImage: MemoryImage(
                                                    base64Decode(studentData
                                                        .userImage!)),
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: InkWell(
                                                  onTap: () async {
                                                    programProvider
                                                        .clearAllTemp();
                                                    studentProvider
                                                        .clearStudentTemp();

                                                    showAddAlertDialog(
                                                        context, studentData);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15.sp,
                                                    backgroundColor:
                                                        AppColors.color582,
                                                    child: CircleAvatar(
                                                      radius: 13.sp,
                                                      backgroundColor:
                                                          AppColors.colorWhite,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 15.sp,
                                                          color: AppColors
                                                              .color582,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Tooltip(
                                                message: studentData
                                                    .mobileNumber
                                                    .toString(),
                                                child: const Icon(
                                                  Icons.phone,
                                                  color: AppColors.colorc7e,
                                                )),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Tooltip(
                                                message: studentData.email,
                                                child: const Icon(
                                                  Icons.mail,
                                                  color: AppColors.colorc7e,
                                                )),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Tooltip(
                                                message: studentData.dOB,
                                                child: const Icon(
                                                  Icons.cake,
                                                  color: AppColors.colorc7e,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    IntrinsicWidth(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 18.0.h, left: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                AppRichTextView(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  title:
                                                      studentData.firstName! +
                                                          studentData.lastName!,
                                                  fontSize: 24.sp,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                                Icon(
                                                  studentData.gender == "Male"
                                                      ? Icons.male
                                                      : Icons.female,
                                                  color: AppColors.colorc7e,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Student Type: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title:
                                                      studentData.studentType!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: studentData
                                                              .currentProgramId ==
                                                          300
                                                      ? "Clinical Rotation: "
                                                      : "Current Class: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData
                                                              .currentProgramId ==
                                                          300
                                                      ? studentData
                                                          .rotationName!
                                                      : studentData
                                                          .currentClassName!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Joining Date: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData
                                                      .admissionDate!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                AppRichTextView(
                                                  title: "Student Id: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData.studentId!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                AppRichTextView(
                                                  title:
                                                      "Emergency Contact Number: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData
                                                      .emergencyContact!
                                                      .toString(),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                AppRichTextView(
                                                  title: "Passport Number: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData
                                                      .passportNumber!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: [
                                                AppRichTextView(
                                                  title: "Qualification: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                AppRichTextView(
                                                  title: studentData
                                                      .qualification!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor: AppColors.colorc7e,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: AppColors.colorc7e,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 80.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Home Address: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                Flexible(
                                                  child: AppRichTextView(
                                                    maxLines: 3,
                                                    title: studentData.address!,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w800,
                                                    textColor:
                                                        AppColors.colorc7e,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 18.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Mailing Address: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                Flexible(
                                                  child: AppRichTextView(
                                                    maxLines: 3,
                                                    title: studentData
                                                        .mailingAddress!,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w800,
                                                    textColor:
                                                        AppColors.colorc7e,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 18.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Created By: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                Flexible(
                                                  child: AppRichTextView(
                                                    maxLines: 2,
                                                    title:
                                                        studentData.createdBy!,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w800,
                                                    textColor:
                                                        AppColors.colorc7e,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 18.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Created at: ",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorGrey,
                                                ),
                                                Flexible(
                                                  child: AppRichTextView(
                                                    maxLines: 2,
                                                    title: DateFormat.yMMMd()
                                                        .format(DateTime.parse(
                                                            studentData
                                                                .createdAt!)),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w800,
                                                    textColor:
                                                        AppColors.colorc7e,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Consumer<FeesProvider>(
                            builder: (context, feesConsumer, child) {
                              return Expanded(
                                flex: 1,
                                child: studentData.studentFees!.isEmpty
                                    ?  InkWell(
                                          onTap: () async {
                                            var token = await getTokenAndUseIt();
                                            if (token == null) {
                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else if (token == "Token Expired") {
                                              ToastHelper().errorToast(
                                                  "Session Expired Please Login Again");
                              
                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else {
                                              feesConsumer.getFeesByid(token,
                                                  studentData.currentProgramId!);
                                            }
                                            if (context.mounted) {
                                              showUpdateFeesDialog(
                                                  context, studentData);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.colorWhite,
                                                border: Border.all(
                                                    color: AppColors.colorc7e,
                                                    width: 3)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Column(
                                                children: [
                                                  AppRichTextView(
                                                    title: 'Alert!',
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: AppColors.colorRed,
                                                  ),
                                                  Lottie.asset(
                                                      LottiePath
                                                          .whiteNotificationLottie,
                                                      height: size.height * 0.15,
                                                      repeat: false),
                                                  AppRichTextView(
                                                    textAlign: TextAlign.center,
                                                    title:
                                                        'Please Update Student Fees Details',
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: AppColors.colorc7e,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.colorWhite,
                                          border: Border.all(
                                              color: AppColors.colorc7e,
                                              width: 3.w),
                                        ),
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            enlargeCenterPage: true ,
                                              enableInfiniteScroll: false),
                                          items: studentData.studentFees!
                                              .map((item) => Center(
                                                child: CreditCardUi(
                                                  onTap: () async{
                                                      var token = await getTokenAndUseIt();
                                            if (token == null) {
                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else if (token == "Token Expired") {
                                              ToastHelper().errorToast(
                                                  "Session Expired Please Login Again");
                              
                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else {
                                              feesConsumer.getFeesByid(token,
                                                  studentData.currentProgramId!);
                                            }
                                            if (context.mounted) {
                                              showUpdateFeesDialog(
                                                  context, studentData);
                                            }
                                                  },
                                                      className: item.className!,
                                                      topLeftColor:
                                                          AppColors.colorc7e,
                                                      creditCardType:
                                                          CreditCardType.none,
                                                      shouldMaskCardNumber: false,
                                                      balance: double.parse(item
                                                          .amountInUsd
                                                          .toString()),
                                                      showBalance: true,
                                                      doesSupportNfc: false,
                                                      cardType: CardType.other,
                                                      showValidFrom: false,
                                                      showValidThru: false,
                                                      cardHolderFullName:
                                                          '${studentData.firstName!} ${studentData.lastName!}',
                                                      cardNumber:
                                                          'Due: \$${item.amountInUsd}',
                                                      validThru: '10/24',
                                                    ),
                                              ))
                                              .toList(),
                                        )),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Expanded(
                        child: StudentTabView(
                      studentDetail: studentData,
                    ))
                  ],
                ),
              );
            });
          }
        });
  }
}
