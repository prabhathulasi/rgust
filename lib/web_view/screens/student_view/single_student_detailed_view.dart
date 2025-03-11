import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/file_upload_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/student_view/student_page_tabs/student_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleStudentDetailView extends StatefulWidget {
  const SingleStudentDetailView({super.key});

  @override
  State<SingleStudentDetailView> createState() =>
      _SingleStudentDetailViewState();
}

class _SingleStudentDetailViewState extends State<SingleStudentDetailView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final fileUploadProvider =
        Provider.of<FileUploadProvider>(context, listen: false);
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var studentId = prefs.getInt("userId");
        var result =
            await studentProvider.getSingleStudentDetailById(studentId!, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    Future getMediaList(int studentId) async {
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
        fileUploadProvider.mediaFileModel.files?.clear();
        var result =
            await fileUploadProvider.getStudentMediaFile(token, studentId);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 35.h,
        backgroundColor: AppColors.color446,
        title: AppRichTextView(
          title: "Student Profile",
          textColor: AppColors.colorWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: FutureBuilder(
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
                    studentConsumer.singleStudentDetailModel.studentDetail!;
                return Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Card(
                            child: SizedBox(
                              height: size.height,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Card(
                                            elevation: 3.0,
                                            color: AppColors.color446
                                                .withOpacity(0.01),
                                            child: Container(
                                                height: 158.h,
                                                width: 158.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: MemoryImage(
                                                          base64Decode(
                                                              studentData
                                                                  .userImage!),
                                                        )))),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                overflow: TextOverflow.ellipsis,
                                                title: studentData.firstName!
                                                        .toUpperCase() +
                                                    studentData.lastName!
                                                        .toUpperCase(),
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.color446,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  AppRichTextView(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    title: studentData
                                                        .mobileNumber
                                                        .toString(),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColors.colorBlack,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.email_outlined,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  AppRichTextView(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    title: studentData.email!,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColors.colorBlack,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.cake,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  AppRichTextView(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    title: studentData.dOB!,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                        AppColors.colorBlack,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Registration Number:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: studentData.studentId!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Student Type:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: studentData.studentType!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Current Class:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title:
                                                  studentData.currentClassName!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Admission Date:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: studentData.admissionDate!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Emergency Contact:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: studentData
                                                  .emergencyContact
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Passport Number:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title:
                                                  studentData.passportNumber!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Qualification:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              title: studentData.qualification!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Home Address:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              title: studentData.address!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title: "Mailing Address :",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color446,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppRichTextView(
                                              overflow: TextOverflow.ellipsis,
                                              title:
                                                  studentData.mailingAddress!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(10.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppRichTextView(
                                      overflow: TextOverflow.ellipsis,
                                      title: "Additional Documents",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.color446,
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.add,
                                        color: AppColors.color446),
                                    AppRichTextView(
                                      overflow: TextOverflow.ellipsis,
                                      title: "Add New Document",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorBlack,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Card(
                                  elevation: 3.0,
                                  child: SizedBox(
                                    height: 180.h,
                                    width: size.width,
                                    child: FutureBuilder(
                                        future: getMediaList(studentData.iD!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: SpinKitSpinningLines(
                                                color: AppColors.colorc7e,
                                              ),
                                            );
                                          } else {
                                            return Consumer<FileUploadProvider>(
                                                builder: (context,
                                                    fileUploadConsumer, child) {
                                              var data = fileUploadConsumer
                                                  .mediaFileModel.files;
                                              return data == null ||
                                                      data.isEmpty
                                                  ? Column(
                                                      children: [
                                                        Lottie.asset(
                                                            LottiePath
                                                                .noDocLottie,
                                                            repeat: false,
                                                            width: 100.w),
                                                        Expanded(
                                                          child:
                                                              AppRichTextView(
                                                            title:
                                                                "No Documents Available in the Record",
                                                            textColor: AppColors
                                                                .colorc7e,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                    child: Row(
                                                        children: data.map((e) {
                                                          Uint8List pdfData =
                                                              base64Decode(
                                                                  e.data!);
                                                    
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Card(
                                                              elevation: 10.0,
                                                              child: Container(
                                                                  height: 150.h,
                                                                  width: 120.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      border: Border.all(
                                                                          color: AppColors
                                                                              .colorBlack)),
                                                                  child: Transform
                                                                      .rotate(
                                                                    angle: -45,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          AppRichTextView(
                                                                        title: e
                                                                            .name!,
                                                                        fontSize:
                                                                            12.sp,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        textColor:
                                                                            AppColors.colorBlack,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                  );
                                            });
                                          }
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Expanded(
                                    child: SingleStudentTabs(
                                  studentDetail: studentData,
                                ))
                              ],
                            ),
                          ))
                    ],
                  ),
                );

                // return Padding(
                //   padding: EdgeInsets.all(3.0.sp),
                //   child: Column(
                //     children: [
                //       IntrinsicHeight(
                //         child: Container(
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: AppColors.colorc7e, width: 3.w),
                //             color: AppColors.colorWhite,
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.all(8.0.sp),
                //             child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Column(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.center,
                //                   children: [
                //                     Padding(
                //                       padding: EdgeInsets.only(left: 8.0.w),
                //                       child: Stack(
                //                         children: [
                //                           CircleAvatar(
                //                             radius: 60.sp,
                //                             backgroundImage: MemoryImage(
                //                                 base64Decode(studentData
                //                                     .userImage!)),
                //                           ),
                //                           Positioned(
                //                             right: 0,
                //                             bottom: 0,
                //                             child: InkWell(
                //                               onTap: () async {
                //                                 // programProvider
                //                                 //     .clearAllTemp();
                //                                 // studentProvider
                //                                 //     .clearStudentTemp();

                //                                 // showAddAlertDialog(
                //                                 //     context, studentData);
                //                               },
                //                               child: CircleAvatar(
                //                                 radius: 15.sp,
                //                                 backgroundColor:
                //                                     AppColors.color582,
                //                                 child: CircleAvatar(
                //                                   radius: 13.sp,
                //                                   backgroundColor:
                //                                       AppColors.colorWhite,
                //                                   child: Center(
                //                                     child: Icon(
                //                                       Icons.edit,
                //                                       size: 15.sp,
                //                                       color: AppColors
                //                                           .color582,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           )
                //                         ],
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       height: 10.h,
                //                     ),
                //                     Row(
                //                       children: [
                //                         Tooltip(
                //                             message: studentData
                //                                 .mobileNumber
                //                                 .toString(),
                //                             child: const Icon(
                //                               Icons.phone,
                //                               color: AppColors.colorc7e,
                //                             )),
                //                         SizedBox(
                //                           width: 5.w,
                //                         ),
                //                         Tooltip(
                //                             message: studentData.email,
                //                             child: const Icon(
                //                               Icons.mail,
                //                               color: AppColors.colorc7e,
                //                             )),
                //                         SizedBox(
                //                           width: 5.w,
                //                         ),
                //                         Tooltip(
                //                             message: studentData.dOB,
                //                             child: const Icon(
                //                               Icons.cake,
                //                               color: AppColors.colorc7e,
                //                             ))
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(
                //                   width: 20.w,
                //                 ),
                //                 IntrinsicWidth(
                //                   child: Padding(
                //                     padding: EdgeInsets.only(
                //                         top: 18.0.h, left: 10.h),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             AppRichTextView(
                //                               overflow:
                //                                   TextOverflow.ellipsis,
                //                               title:
                //                                   studentData.firstName! +
                //                                       studentData.lastName!,
                //                               fontSize: 24.sp,
                //                               fontWeight: FontWeight.bold,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                             Icon(
                //                               studentData.gender == "Male"
                //                                   ? Icons.male
                //                                   : Icons.female,
                //                               color: AppColors.colorc7e,
                //                             )
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 20.h,
                //                         ),
                //                         Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Student Type: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title:
                //                                   studentData.studentType!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: studentData
                //                                           .currentProgramId ==
                //                                       300
                //                                   ? "Clinical Rotation: "
                //                                   : "Current Class: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData
                //                                           .currentProgramId ==
                //                                       300
                //                                   ? studentData
                //                                       .rotationName!
                //                                   : studentData
                //                                       .currentClassName!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Joining Date: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData
                //                                   .admissionDate!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Student Id: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData.studentId!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             AppRichTextView(
                //                               title:
                //                                   "Emergency Contact Number: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData
                //                                   .emergencyContact!
                //                                   .toString(),
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Passport Number: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData
                //                                   .passportNumber!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(
                //                           height: 10.h,
                //                         ),
                //                         Row(
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Qualification: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             AppRichTextView(
                //                               title: studentData
                //                                   .qualification!,
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor: AppColors.colorc7e,
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 const VerticalDivider(
                //                   color: AppColors.colorc7e,
                //                 ),
                //                 Expanded(
                //                   child: Column(
                //                     children: [
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.only(top: 80.0.h),
                //                         child: Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Home Address: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             Flexible(
                //                               child: AppRichTextView(
                //                                 maxLines: 3,
                //                                 title: studentData.address!,
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w800,
                //                                 textColor:
                //                                     AppColors.colorc7e,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.only(top: 18.0.h),
                //                         child: Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Mailing Address: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             Flexible(
                //                               child: AppRichTextView(
                //                                 maxLines: 3,
                //                                 title: studentData
                //                                     .mailingAddress!,
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w800,
                //                                 textColor:
                //                                     AppColors.colorc7e,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.only(top: 18.0.h),
                //                         child: Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Created By: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             Flexible(
                //                               child: AppRichTextView(
                //                                 maxLines: 2,
                //                                 title:
                //                                     studentData.createdBy!,
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w800,
                //                                 textColor:
                //                                     AppColors.colorc7e,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.only(top: 18.0.h),
                //                         child: Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             AppRichTextView(
                //                               title: "Created at: ",
                //                               fontSize: 12.sp,
                //                               fontWeight: FontWeight.w800,
                //                               textColor:
                //                                   AppColors.colorGrey,
                //                             ),
                //                             Flexible(
                //                               child: AppRichTextView(
                //                                 maxLines: 2,
                //                                 title: DateFormat.yMMMd()
                //                                     .format(DateTime.parse(
                //                                         studentData
                //                                             .createdAt!)),
                //                                 fontSize: 12.sp,
                //                                 fontWeight: FontWeight.w800,
                //                                 textColor:
                //                                     AppColors.colorc7e,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 5.h,
                //       ),
                //       Expanded(

                //           child: SingleStudentTabs(
                //         studentDetail: studentData,
                //       )
                //       )
                //     ],
                //   ),
                // );
              });
            }
          }),
    );
  }
}
