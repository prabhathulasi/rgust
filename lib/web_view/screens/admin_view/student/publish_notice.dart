import 'dart:developer';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:rugst_alliance_academia/data/provider/publish_notice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class PublishNotice extends StatefulWidget {
  const PublishNotice({super.key});

  @override
  State<PublishNotice> createState() => _PublishNoticeState();
}

class _PublishNoticeState extends State<PublishNotice> {
  final QuillEditorController controller = QuillEditorController();
  final _backgroundColor = Colors.white;
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _toolbarColor = Colors.grey.shade200;

  final _toolbarIconColor = Colors.black87;

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<PublishNoticeProvider>(
        builder: (context, publishNoticeConsumer, child) {
      return Column(
        children: [
          ToolBar(
            toolBarColor: _toolbarColor,
            padding: const EdgeInsets.all(8),
            iconSize: 25,
            iconColor: _toolbarIconColor,
            activeIconColor: Colors.greenAccent.shade400,
            controller: controller,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            customButtons: [
              InkWell(
                  onTap: () async {
                    publishNoticeConsumer.pickPdfFile();
                  },
                  child: const Icon(
                    Icons.attach_email,
                    color: Colors.black,
                  )),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: QuillHtmlEditor(
                          text:
                              "<h1>Hello</h1>This is a quill html editor example 😊",
                          hintText: 'Hint text goes here',
                          controller: controller,
                          isEnabled: true,
                          minHeight: size.height,
                          textStyle: _editorTextStyle,
                          hintTextStyle: _hintTextStyle,
                          hintTextAlign: TextAlign.start,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          hintTextPadding: EdgeInsets.zero,
                          backgroundColor: _backgroundColor,
                          onFocusChanged: (hasFocus) {
                            debugPrint('Quill editor focus: $hasFocus');
                            if (hasFocus) {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Remove focus from TextField
                            }
                          },
                          onTextChanged: (text) =>
                              debugPrint('widget text change $text'),
                          onEditorCreated: () =>
                              debugPrint('Editor has been loaded'),
                          onEditingComplete: (s) =>
                              debugPrint('Editing completed $s'),
                          onEditorResized: (height) =>
                              debugPrint('Editor resized $height'),
                          onSelectionChanged: (sel) =>
                              debugPrint('${sel.index},${sel.length}'),
                          loadingBuilder: (context) {
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 0.4,
                            ));
                          },
                        ),
                      ),
                      publishNoticeConsumer.attachedFiles.isEmpty
                          ? Container()
                          : Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DottedBorder(
                                    color: AppColors.colorc7e,
                                    strokeWidth: 2.w,
                                    dashPattern: const [10, 5],
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(8.sp),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: publishNoticeConsumer
                                          .attachedFiles.length,
                                      itemBuilder: (context, index) {
                                        final file = publishNoticeConsumer
                                            .attachedFiles[index];
                                        return Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Container(
                                            width: 200.w,
                                            padding: EdgeInsets.all(8.0.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.colorWhite,
                                              borderRadius:
                                                  BorderRadius.circular(8.sp),
                                              border: Border.all(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.attach_file,
                                                    color: AppColors.color446,
                                                    size: 20.sp),
                                                SizedBox(width: 5.w),
                                                Expanded(
                                                  child: AppRichTextView(
                                                      maxLines: 3,
                                                      title: file['name'],
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(width: 5.w),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Handle file removal
                                                    publishNoticeConsumer
                                                        .removeFile(index);
                                                  },
                                                  child: Icon(Icons.close,
                                                      color: AppColors.colorRed,
                                                      size: 20.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Card(
                      color: AppColors.colorWhite,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Consumer<StudentProvider>(
                              builder: (context, studentConsumer, child) {
                            return SizedBox(
                              height: size.height,
                              child: Column(
                                children: [
                                  Container(
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 18.0.w, right: 18.w),
                                      child: AppTextFormFieldWidget(
                                        focusNode: publishNoticeConsumer
                                            .textFieldFocusNode,
                                        // key: textFieldKey,
                                        onChanged: (p0) {
                                          if (p0.isEmpty) {
                                            studentConsumer
                                                .setEnableFilter(false);
                                          } else {
                                            studentConsumer
                                                .setEnableFilter(true);
                                            studentConsumer.filterStudent(p0);
                                          }
                                        },
                                        textStyle: GoogleFonts.oswald(
                                            color: AppColors.colorBlack,
                                            fontSize: 15.sp),
                                        inputDecoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.search,
                                              color: AppColors.colorBlack,
                                              size: 25.sp,
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Search by Name",
                                            hintStyle: GoogleFonts.oswald(
                                                color: AppColors.colorBlack,
                                                fontSize: 15.sp)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  studentConsumer.filteredEnable == true
                                      ? ListView.builder(
                                          itemCount: studentConsumer
                                              .filteredList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var studentData = studentConsumer
                                                .filteredList[index];
                                            return ListTile(
                                              leading: CircleAvatar(
                                                radius: 20.sp,
                                                backgroundColor:
                                                    AppColors.color446,
                                                child: Text(
                                                  studentData.firstName![0]
                                                      .toUpperCase(),
                                                  style: GoogleFonts.oswald(
                                                      color:
                                                          AppColors.colorWhite,
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                              title: Text(
                                                "${studentData.firstName!} ${studentData.lastName!}",
                                                style: GoogleFonts.oswald(
                                                    color: AppColors.colorBlack,
                                                    fontSize: 16.sp),
                                              ),
                                              trailing: Checkbox(
                                                activeColor: AppColors.color446,
                                                value:
                                                    studentConsumer.isSelected(
                                                        studentData.iD!),
                                                onChanged: (value) {
                                                  studentConsumer
                                                      .toggleStudentSelection(
                                                          studentData.iD!);
                                                },
                                              ),
                                            );
                                          },
                                        )
                                      : ListView.builder(
                                          itemCount: studentConsumer
                                              .studentModel.studentList!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                radius: 20.sp,
                                                backgroundColor:
                                                    AppColors.color446,
                                                child: Text(
                                                  studentConsumer
                                                      .studentModel
                                                      .studentList![index]
                                                      .firstName![0]
                                                      .toUpperCase(),
                                                  style: GoogleFonts.oswald(
                                                      color:
                                                          AppColors.colorWhite,
                                                      fontSize: 18.sp),
                                                ),
                                              ),
                                              title: Text(
                                                "${studentConsumer.studentModel.studentList![index].firstName!} ${studentConsumer.studentModel.studentList![index].lastName!}",
                                                style: GoogleFonts.oswald(
                                                    color: AppColors.colorBlack,
                                                    fontSize: 16.sp),
                                              ),
                                              trailing: Checkbox(
                                                activeColor: AppColors.color446,
                                                value: studentConsumer
                                                    .isSelected(studentConsumer
                                                        .studentModel
                                                        .studentList![index]
                                                        .iD!),
                                                onChanged: (value) {
                                                  studentConsumer
                                                      .toggleStudentSelection(
                                                          studentConsumer
                                                              .studentModel
                                                              .studentList![
                                                                  index]
                                                              .iD!);
                                                },
                                              ),
                                            );
                                          },
                                        )
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Consumer<StudentProvider>(
                builder: (context, studentConsumer, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppElevatedButon(
                    title: "cancel",
                    onPressed: (context) {
                      studentConsumer.clearAllTempData();
                      publishNoticeConsumer.attachedFiles.clear();
                      Navigator.of(context).pop();
                    },
                    borderColor: AppColors.colorRed,
                    buttonColor: AppColors.colorWhite,
                    textColor: AppColors.colorRed,
                    width: 130.w,
                    height: 50.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  AppElevatedButon(
                    title: "Publish",
                    onPressed: (context) async {
                      if (studentConsumer.selectedIndexes.isEmpty) {
                        ToastHelper().errorToast(
                            "Please select atleast one student to publish notice");
                        return;
                      } else {
                        await publishNoticeConsumer.sendEmailRequest(
                          studentConsumer.selectedIndexes,
                          await controller.getText(),
                        );
                        studentConsumer.clearAllTempData();
                        publishNoticeConsumer.attachedFiles.clear();
                        Navigator.of(context).pop();
                      }

                      // log(await controller.getText());
                    },
                    borderColor: AppColors.color446,
                    buttonColor: AppColors.colorWhite,
                    textColor: AppColors.color446,
                    width: 130.w,
                    height: 50.h,
                  )
                ],
              );
            }),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      );
    });
  }
}

showNoticeAlert(BuildContext context) {
  // set up the AlertDialog
  Dialog alert = Dialog(
    child: StatefulBuilder(builder: (context, setState) {
      return Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: AppColors.colorWhite,
        child: const PublishNotice(),
      );
    }),
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
