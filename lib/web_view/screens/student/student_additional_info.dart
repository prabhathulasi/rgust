
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfx/pdfx.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/file_upload_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
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
uploadImage()async{
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
         // Define headers (if needed)
    final headers = <String, String>{
      'Authorization': 'Bearer $token', // Add any headers you need
    };
        final request = http.MultipartRequest('POST', Uri.parse("http://172.16.20.122:3014/upload/id=${widget.studentId}"))
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
                      fileUploadProvider.setSelectedFileName();
                   await getMediaList();
                   setState(() {
                     
                   });
                      print('File uploaded successfully');
                    } else {
                      // Handle errors
                      print('Error uploading file: ${response.statusCode}');
                    }

      }
}
 

    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: AppColors.colorc7e,
      child: FutureBuilder(
          future: getMediaList(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
               return Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 60.sp,
                ),
              );
            }else{
            print(fileUploadProvider.mediaFileModel.files.toString());  
return fileUploadProvider.mediaFileModel.files == null || fileUploadProvider.mediaFileModel.files!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                            allowMultiple: false,
                          );
                          if (result != null) {
                            if (result.files.first.size <= 50 * 1024) {
                              fileUploadProvider.setFileData(
                                  result); // Update the selected file data and name
                            } else {
                              ToastHelper().errorToast(
                                  "Selected file must be less than 50KB.");
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 25.sp,
                          backgroundColor: AppColors.colorWhite,
                          child: Icon(
                            Icons.file_open_outlined,
                            color: AppColors.colorc7e,
                            size: 35.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppRichTextView(
                        title: "Add Document",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                        textColor: AppColors.colorWhite,
                      ),
                      Consumer<FileUploadProvider>(
                          builder: (context, fileUploadProvider, child) {
                        return Column(
                          children: [
                            AppRichTextView(
                              title: fileUploadProvider.selectedFileName == null
                                  ? ""
                                  : fileUploadProvider.selectedFileName!,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorWhite,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            fileUploadProvider.selectedFileName == null
                                ? Container()
                                : AppElevatedButon(
                                    title: "Upload Document",
                                    height: 50.h,
                                    width: 250.w,
                                    borderColor: AppColors.colorWhite,
                                    buttonColor: AppColors.colorPurple,
                                    onPressed: (context) async{
uploadImage();
                                       

                                    },
                                    loading: fileUploadProvider.isLoading,
                                    textColor: AppColors.colorWhite,
                                  )
                          ],
                        );
                      }),
                    ],
                  )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,left: 8.0),
                      child: Consumer<FileUploadProvider>(
                        builder: (context, fileUploadProvider, child  ) {
                          return Row(
                            children: [
                    InkWell(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                  allowMultiple: false,
                                );
                                if (result != null) {
                                  if (result.files.first.size <= 50 * 1024) {
                                    fileUploadProvider.setFileData(
                                        result); // Update the selected file data and name
                                  } else {
                                    ToastHelper().errorToast(
                                        "Selected file must be less than 50KB.");
                                  }
                                }
                              },
                              child: CircleAvatar(
                                radius: 25.sp,
                                backgroundColor: AppColors.colorWhite,
                                child: Icon(
                                  Icons.file_open_outlined,
                                  color: AppColors.colorc7e,
                                  size: 35.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                          AppRichTextView(
                                    title: fileUploadProvider.selectedFileName == null
                                        ? ""
                                        : fileUploadProvider.selectedFileName!,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800,
                                    textColor: AppColors.colorWhite,
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  fileUploadProvider.selectedFileName == null
                                      ? Container()
                                      : AppElevatedButon(
                                          title: "Upload Document",
                                          height: 40.h,
                                          width: 250.w,
                                          borderColor: AppColors.colorWhite,
                                          buttonColor: AppColors.color0ec,
                                          onPressed: (context) async{
                    uploadImage();
                                             
                    
                                          },
                                          loading: fileUploadProvider.isLoading,
                                          textColor: AppColors.colorc7e,
                                        ),
                            ],
                          );
                        }
                      ),
                    ),
                    
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                          itemCount: fileUploadProvider.mediaFileModel.files!.length,
                          itemBuilder: (context, index) {
                           Uint8List pdfData=  base64Decode(fileUploadProvider.mediaFileModel.files![index].data!);
                      
                           final pdfController = PdfController(
                            viewportFraction: 2.0,
                      document: PdfDocument.openData(pdfData),
                    );
                            return Padding(
                              padding:  EdgeInsets.only(top:8.0.h,left: 8.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Column(
                                     children: [
                                       Expanded(
                                         child: Container(
                                          color: AppColors.color7ff,
                                                                         
                                          width: 250.w,
                                           child: PdfView(
                                                                     controller: pdfController,
                                                                   )
                                           
                                                 ),
                                       ),
                                               AppRichTextView(
                              title: fileUploadProvider.mediaFileModel.files![index].name!,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorWhite,
                            ),
                    
                                     ],
                                   ),
                                   
                                ],
                              ),
                            );
                          },
                        ),
                    ),
                  ],
                );
            }
            
          }),
    );
  }
}
