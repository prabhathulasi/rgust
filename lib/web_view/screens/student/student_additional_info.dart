import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/student_model.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
import 'package:rugst_alliance_academia/data/provider/file_upload_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/pdf_generate/student_personal_profile.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudentAdditionalInfoView extends StatefulWidget {
  final StudentDetail studentDetail;
  const StudentAdditionalInfoView({super.key, required this.studentDetail});

  @override
  State<StudentAdditionalInfoView> createState() =>
      _StudentAdditionalInfoViewState();
}

String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
String flavorName = FlavorConfig.instance.variables["flavorName"];

class _StudentAdditionalInfoViewState extends State<StudentAdditionalInfoView> {
  bool isHovered = false;
  showPDfView(BuildContext context, PdfController pdfController) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          PdfView(
            controller: pdfController,
          ),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: AppColors.colorc7e,
                    child: Icon(Icons.close, color: AppColors.color0ec),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileUploadProvider =
        Provider.of<FileUploadProvider>(context, listen: false);
            final commonProvider =
        Provider.of<CommonProvider>(context , listen: false);
    Future getMediaList() async {
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
        var result = await fileUploadProvider.getMediaFileById(
            token, widget.studentDetail.iD!);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    uploadImage(String formType) async {
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
        fileUploadProvider.setLoading(true);
        // Define headers (if needed)
        final headers = <String, String>{
          'Authorization': 'Bearer $token', // Add any headers you need
        };
        final body = {
          "Formtype": formType
        };
        final request = http.MultipartRequest(
            'POST',
            flavorName == "dev"
                ? Uri.parse("$flavorUrl/upload/id=${widget.studentDetail.iD}")
                : Uri.https(flavorUrl, '/upload/id=${widget.studentDetail.iD}'))
          ..headers.addAll(headers)
          ..fields.addAll(body)
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              fileUploadProvider.bytesFromPicker!,
              filename: fileUploadProvider.selectedFileName,
            ),
          );

        final response = await request.send();
        var responseBody = await response.stream.bytesToString();
        var decodedData = json.decode(responseBody);
        if (response.statusCode == 200) {
          fileUploadProvider.setLoading(false);
          fileUploadProvider.setSelectedFileName();
          await getMediaList();
          setState(() {});
            ToastHelper().sucessToast("${decodedData["Message"]} ");
        } else {
          fileUploadProvider.setLoading(false);
          ToastHelper().errorToast("${decodedData["Message"]} ");
          // Handle errors
          print('Error uploading file: ${decodedData["Message"]}');
        }
      }
    }

    Future deleteMedia(int id) async {
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
        var result = await fileUploadProvider.delteMediabyId(
            token, id, widget.studentDetail.iD!);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,

        // color: AppColors.colorc7e,
        child: FutureBuilder(
            future: getMediaList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: AppColors.colorc7e,
                    size: 60.sp,
                  ),
                );
              } else {
                return Consumer<FileUploadProvider>(
                    builder: (context, fileUploadConsumer, child) {
                  var data = fileUploadConsumer.mediaFileModel.files;
                  return data == null || data.isEmpty
                      ? Center(child: Lottie.asset(LottiePath.noDocLottie))
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 18.w, top: 18.h),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                        .height,
                                                width: 600.w,
                                                child: Stack(
                                                  children: [
                                                    StudentPersonalProfile(
                                                      files: data,
                                                      studentData:
                                                          widget.studentDetail,
                                                    ),
                                                    Transform.translate(
                                                      offset:
                                                          Offset(10.w, -13.h),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: CircleAvatar(
                                                              radius: 14.0,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .colorc7e,
                                                              child: Icon(
                                                                  Icons.close,
                                                                  color: AppColors
                                                                      .color0ec),
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.summarize_outlined,
                                        color: AppColors.colorc7e,
                                      ),
                                    )),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left:8.0),
                              //   child: AppRichTextView(title: "Form A", fontSize: 20.sp, fontWeight: FontWeight.bold,textColor: AppColors.colorc7e,),
                              // ),
                              Wrap(
                                spacing:
                                    8.0, // Spacing between items horizontally
                                runSpacing:
                                    8.0, // Spacing between rows vertically
                                children: data.map((e) {
                                  Uint8List pdfData = base64Decode(e.data!);

                                  final pdfController = PdfController(
                                    viewportFraction: 2.0,
                                    document: PdfDocument.openData(pdfData),
                                  );

                                  return FocusedMenuHolder(
                                    openWithTap: true,
                                    onPressed: () {},
                                    menuWidth: 300.w,
                                    menuItems: [
                                      FocusedMenuItem(
                                          title: const Text("View"),
                                          trailingIcon:
                                              const Icon(Icons.visibility),
                                          onPressed: () {
                                            
                                            // Create a blob URL for the PDF
                                            final blob = html.Blob(
                                                [pdfData], 'application/pdf');
                                            final url = html.Url
                                                .createObjectUrlFromBlob(blob);

                                            // Open the blob URL in a new tab
                                            html.window.open(url, '_blank');
                                            // showPDfView(context, pdfController);
                                          }),
                                      FocusedMenuItem(
                                          title: const Text("Delete"),
                                          trailingIcon:
                                              const Icon(Icons.delete),
                                          onPressed: () {
                                            deleteMedia(e.iD!);
                                          }),
                                    ],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Card(
                                            elevation: 10.0,
                                            child: Container(
                                                height: 200.h,
                                                width: 130.w,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .colorBlack)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 8),
                                                  child: PdfView(
                                                    controller: pdfController,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.0.h,
                                          ),
                                          AppRichTextView(
                                            title: e.name!,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w800,
                                            textColor: AppColors.colorBlack,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorc7e,
        child: fileUploadProvider.isLoading == false
            ? const Icon(
                Icons.add_photo_alternate,
                color: AppColors.colorWhite,
              )
            : const CircularProgressIndicator(),
        onPressed: () async {
          commonProvider.updateSelectedOption("");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Please Select Form Type"),
                content: Row(
                  children: [
                    Expanded(
                      child: Consumer<CommonProvider>(
                        builder: (context, radioConsumer, child) {
                          return Wrap(
                           direction: Axis.horizontal,
                            children: [
                                RadioListTile<String>(
                                  activeColor: AppColors.colorc7e,
                                    title: const Text('Form A'),
                                    value: 'Form A',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                     radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                       RadioListTile<String>(
                           activeColor: AppColors.colorc7e,
                                    title: const Text('Form B'),
                                    value: 'Form B',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                     radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                       RadioListTile<String>(
                           activeColor: AppColors.colorc7e,
                                    title: const Text('Form C'),
                                    value: 'Form C',
                                    groupValue:radioConsumer.selectedOption,
                                    onChanged: (value) {
                                      radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                       RadioListTile<String>(
                           activeColor: AppColors.colorc7e,
                                    title: const Text('Form D'),
                                    value: 'Form D',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                      radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                       RadioListTile<String>(
                           activeColor: AppColors.colorc7e,
                                    title: const Text('Form E'),
                                    value: 'Form E',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                     radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                  RadioListTile<String>(
                                     activeColor: AppColors.colorc7e,
                                    title: const Text('Form F'),
                                    value: 'Form F',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                      radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                  RadioListTile<String>(
                                     activeColor: AppColors.colorc7e,
                                    title: const Text('Form G'),
                                    value: 'Form G',
                                    groupValue: radioConsumer.selectedOption,
                                    onChanged: (value) {
                                     radioConsumer
                            .updateSelectedOption(value!);
                                    },
                                  ),
                                  
                            ],
                          );
                        }
                      ),
                    ),
                    const Expanded(child:Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Please ensure that your file meets the following restrictions:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("1. File size should not be more than 100KB."),
                    Text("2. File type should be PDF only."),
                    Text(
                        "3. The filename should not contain special characters, spaces, or symbols"),
                    Text("4. Ensure the document is legible and not corrupted"),
                    Text(
                        "5. Do not upload copyrighted or confidential materials"),
                    Text("6. File names should be unique and descriptive"),
                    Text(
                        "7. Do not upload offensive or inappropriate content."),
                    Text("8. Files should not contain viruses or malware."),

                    // Add more restriction statements as needed
                  ],
                ), )
                  ],
                ),
                        actions: <Widget>[
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorc7e,
               
              ),
                    onPressed: () async {
                      if(commonProvider.selectedOption == ''){
ToastHelper().errorToast("Please Select the Form Type");
                      }else{
 FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                        allowMultiple: false,
                      );
                      if (result != null) {
                        if (result.files.first.size <= 100 * 1024) {
                          fileUploadProvider.setFileData(result);
                          uploadImage(commonProvider.selectedOption); // Update the selected file data and name
                        } else {
                          ToastHelper().errorToast(
                              "Selected file must be less than 100KB.");
                        }
                      }
                      Navigator.of(context).pop();
                      }
                       
                 
                    },
                    child: const Text("OK",style: TextStyle(color: AppColors.colorWhite),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              
              );
           
            },
          );
        },
      ),
    );
  }
}
