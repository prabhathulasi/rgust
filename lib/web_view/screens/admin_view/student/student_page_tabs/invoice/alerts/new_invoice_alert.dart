import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/button_component.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/form_component.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/invoice_component.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/program_component.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/scholarship_component.dart';


import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewInvoiceView extends StatelessWidget {
  final StudentDetail? studentData;
  const AddNewInvoiceView({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final formKey = GlobalKey<FormState>();

    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      DateTime now = DateTime.now();
      return Container(
        color: AppColors.colorWhite,
        height: size.height,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 18.0.w),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const ProgramComponent(),
                        const ScholarshipComponent(),
                        const InvoiceComponent(),
                        const FormComponent(),
                        InvoiceButtonComponent(
                          studentId: studentData!.iD!,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: AppColors.colorBlack,
              width: 1.w,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppRichTextView(
                            title: "Generate Invoice",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack),
                        invoiceConsumer.invoiceList.isEmpty
                            ? SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                    child: AppRichTextView(
                                        title: "No Invoice",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorRed)),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImagePath.webrgustLogo,
                                            height: 100.h,
                                            width: 100.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                AppRichTextView(
                                                    title:
                                                        "Rajiv Gandhi University of Science and Technology",
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlue),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                AppRichTextView(
                                                    title:
                                                        "Department of Finance",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlack),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                AppRichTextView(
                                                    title: "Student Invoice",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlack),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Student Name",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  "${studentData!.firstName!} ${studentData!.lastName!}",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Invoice Date",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: DateFormat(
                                                      'yyyy-MM-dd – kk:mm')
                                                  .format(now)
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Registration#",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  " ${studentData!.studentId}",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Invoice#:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  "Rgust/${DateFormat("yyyy/MMM").format(DateTime.now())}/${invoiceConsumer.generateRandomString(5)}",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Program:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: "Pre-Medicine",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Scholarship Type:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: invoiceConsumer
                                                  .selectedScholarshipItem!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Details",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Regular Tution Fee",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Scholarship Amount",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Payable Amount",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            invoiceConsumer.invoiceList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20.w),
                                                        child: AppRichTextView(
                                                            maxLines: 3,
                                                            title: invoiceConsumer
                                                                .invoiceList[
                                                                    index]
                                                                .description,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            textColor: AppColors
                                                                .colorBlack),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AppRichTextView(
                                                          title: invoiceConsumer
                                                              .invoiceList[
                                                                  index]
                                                              .regularTuitionFee
                                                              .toString(),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .colorBlack),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AppRichTextView(
                                                          title:
                                                              "${invoiceConsumer.invoiceList[index].scholarshipAmount}",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .colorBlack),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AppRichTextView(
                                                          title:
                                                              "${invoiceConsumer.invoiceList[index].usd}",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .colorBlack),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: Container()),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Total USD",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: Container()),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: (invoiceConsumer
                                                        .invoiceList
                                                        .fold(
                                                            0,
                                                            (sum, item) =>
                                                                sum + item.usd))
                                                    .toString(),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title: "Total Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: (invoiceConsumer
                                                      .invoiceList
                                                      .fold(
                                                          0,
                                                          (sum, item) =>
                                                              sum + item.usd))
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title:
                                                  "Scholarship Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: (invoiceConsumer
                                                      .invoiceList
                                                      .fold(
                                                          0,
                                                          (sum, item) =>
                                                              sum +
                                                              item.scholarshipAmount))
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title: "Payable Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: (invoiceConsumer
                                                          .invoiceList
                                                          .fold(
                                                              0,
                                                              (sum, item) =>
                                                                  sum +
                                                                  item.usd) -
                                                      (invoiceConsumer
                                                          .invoiceList
                                                          .fold(
                                                              0,
                                                              (sum, item) =>
                                                                  sum +
                                                                  item.scholarshipAmount)))
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: AppRichTextView(
                                            textDecoration:
                                                TextDecoration.underline,
                                            title: "Important",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorBlack),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: AppRichTextView(
                                          maxLines: 2,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                          title:
                                              "1. This digital invoice is provided for record-keeping purposes only and is not intended to serve as an official or legal document.",
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: AppRichTextView(
                                          maxLines: 2,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                          title:
                                              "2. Submit a hard copy of you deposit slip to the Administrative Office for record keeping.",
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: AppRichTextView(
                                          maxLines: 2,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                          title:
                                              "3. This invoice reflects the annual tuition breakdown under the university's partial scholarship program.",
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: AppRichTextView(
                                          maxLines: 2,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                          title:
                                              "4. Students can download the digital invoice for their payment from the student app once the finance department has confirmed the payment.",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      invoiceConsumer
                                              .customMsgController.text.isEmpty
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AppTextFormFieldWidget(
                                                    textEditingController:
                                                        invoiceConsumer
                                                            .customMsgController,
                                                    obscureText: false,
                                                    inputDecoration:
                                                        InputDecoration(
                                                            hintText:
                                                                "Add Custom Message",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .colorGrey,
                                                            ),
                                                            border:
                                                                const OutlineInputBorder(),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .colorc7e,
                                                                    width:
                                                                        3.w))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                AppElevatedButon(
                                                  title: "save",
                                                  borderColor:
                                                      AppColors.color446,
                                                  buttonColor:
                                                      AppColors.colorWhite,
                                                  height: 50.h,
                                                  width: 100.w,
                                                  textColor: AppColors.color446,
                                                  onPressed: (context) {
                                                    invoiceConsumer
                                                        .setCustomMessageValue(
                                                            invoiceConsumer
                                                                .customMsgController
                                                                .text);
                                                  },
                                                )
                                              ],
                                            )
                                          : Align(
                                              alignment: Alignment.centerLeft,
                                              child: AppRichTextView(
                                                  maxLines: 10,
                                                  title: invoiceConsumer
                                                      .customMessage!,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorBlack),
                                            ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: AppRichTextView(
                                            textDecoration:
                                                TextDecoration.underline,
                                            fontStyle: FontStyle.italic,
                                            title:
                                                "Bank Information for Guyanese Students",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorBlack),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Name of University: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title:
                                                  "Rajiv Gandhi University of Science and Technology",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Name of Bank: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: "Demerara Bank Ltd",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Account Name: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title:
                                                  "Rajiv Gandhi University of Science and Technology",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Account#: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: "401-907-1",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AppRichTextView(
                                          title:
                                              "3rd Street, Cummingslodge, East Coast Demerara, Guyana",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      AppRichTextView(
                                          title: "Telephone#: +(592) 222-6076.",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      AppRichTextView(
                                          title:
                                              "email:financedepartment@rgust.edu.gy                     website: www.rgust.edu.gy",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      invoiceConsumer
                                              .customMsgController.text.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: Consumer<ProgramProvider>(
                                                  builder: (context,
                                                      programconsumer, child) {
                                                return AppElevatedButon(
                                                  loading: invoiceConsumer.isLoading,
                                                    title: "Generate",
                                                    borderColor:
                                                        AppColors.color446,
                                                    buttonColor:
                                                        AppColors.colorWhite,
                                                    height: 50.h,
                                                    width: 130.w,
                                                    textColor:
                                                        AppColors.color446,
                                                    onPressed: (context) async {
                                                      var token =
                                                          await getTokenAndUseIt();
                                                      if (token == null) {
                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else if (token ==
                                                          "Token Expired") {
                                                        ToastHelper().errorToast(
                                                            "Session Expired Please Login Again");

                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else {
                                                        var result =
                                                            await invoiceConsumer
                                                                .postFeeInvoice(
                                                                    studentData!
                                                                        .iD!,
                                                                    token,
                                                                    programconsumer
                                                                        .selectedYear);
                                                                        if(result!=null && context.mounted){
                                                                          Navigator.pop(context);
                                                                        }
                                                       
                                                      }
                                                    
                                                    });
                                              }),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}

showAddInvoiceAlert(BuildContext context, StudentDetail? studentData) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.colorWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Add New Invoice",
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
          Consumer<InvoiceProvider>(builder: (context, invoiceConsumer, child) {
            return InkWell(
              onTap: () {
                invoiceConsumer.clearInvoiceList();
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: AppColors.colorRed,
              ),
            );
          })
        ],
      ),
      content: AddNewInvoiceView(studentData: studentData));

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
