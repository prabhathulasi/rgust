import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pdfx/pdfx.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/file_upload_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudentAdditionalInfoView extends StatefulWidget {
  final int studentId;
  const StudentAdditionalInfoView({super.key, required this.studentId});

  @override
  State<StudentAdditionalInfoView> createState() =>
      _StudentAdditionalInfoViewState();
}

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
        var result =
            await fileUploadProvider.getMediaFileById(token, widget.studentId);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    uploadImage() async {
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
        final request = http.MultipartRequest(
            'POST',
            Uri.parse(
                "http://localhost:3014/upload/id=${widget.studentId}"))
          ..headers.addAll(headers)
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              fileUploadProvider.bytesFromPicker!,
              filename: fileUploadProvider.selectedFileName,
            ),
          );

        final response = await request.send();
        if (response.statusCode == 200) {
           fileUploadProvider.setLoading(false);
          fileUploadProvider.setSelectedFileName();
          await getMediaList();
          setState(() {});
          print('File uploaded successfully');
        } else {
           fileUploadProvider.setLoading(false);
          // Handle errors
          print('Error uploading file: ${response.statusCode}');
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
                        
                var data= fileUploadProvider.mediaFileModel.files;
                return data == null ||
                        data.isEmpty
                    ?  Center(
                      child: Lottie.asset(LottiePath.noDocLottie)
                    ): Wrap(
                        spacing: 8.0, // Spacing between items horizontally
            runSpacing: 8.0, // Spacing between rows vertically
            children: data.map((e) {
                        Uint8List pdfData = base64Decode(e.data!);
                    
                        final pdfController = PdfController(
                          viewportFraction: 2.0,
                          document: PdfDocument.openData(pdfData),
                        );

              return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                                         Card(
                                          elevation: 5.0,
                                           child: Container(
                                                                color: AppColors.colorc7e,
                                                                height: 200.h,
                                                                width: 130.w,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                                                                  child: PdfView(
                                                                    controller: pdfController,
                                                                  ),
                                                                )),
                                         ),
                                         SizedBox(height: 10.0.h,),
                                         AppRichTextView(
                                                    title: e.name!,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w800,
                                                    textColor: AppColors.colorBlack,
                                                  ),
                    
                        ],
                      ),
                    );
                
            }).toList(),
                    );
                 
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.color0ec,

        child:fileUploadProvider.isLoading== false? const Icon(Icons.add_photo_alternate,color: AppColors.colorc7e,): const CircularProgressIndicator(),
        onPressed: () async {
          showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text("Upload Restrictions"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Please ensure that your file meets the following restrictions:",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Text("1. File size should not be more than 50KB."),
          Text("2. File type should be PDF only."),
          Text("3. The filename should not contain special characters, spaces, or symbols"),
          Text("4. Ensure the document is legible and not corrupted"),
          Text("5. Do not upload copyrighted or confidential materials"),
          Text("6. File names should be unique and descriptive"),
          Text("7. Do not upload offensive or inappropriate content."),
          Text("8. Files should not contain viruses or malware."),
       

          // Add more restriction statements as needed
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async{
             FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
            allowMultiple: false,
          );
          if (result != null) {
            if (result.files.first.size <= 50 * 1024) {
              fileUploadProvider.setFileData(
                  result); 
                  uploadImage();// Update the selected file data and name
            } else {
              ToastHelper().errorToast("Selected file must be less than 50KB.");
            }
          }
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("OK"),
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
