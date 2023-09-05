import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_radiobutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:rugst_alliance_academia/widgets/dummy_data.dart';
import 'package:scalable_data_table/scalable_data_table.dart';

class AddFacultyView extends StatefulWidget {
  const AddFacultyView({super.key});

  @override
  State<AddFacultyView> createState() => _AddFacultyViewState();
}

class _AddFacultyViewState extends State<AddFacultyView> {
  String? roleValue;
  String? courseValue;
  String? positionValue;
  String? team;
  String? startDate;
  String? teamLead;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? salary;
  String? dob;
  String? address;
  bool isSwitched = false;
  bool loading = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  List<Gender> genders = [];

  @override
  void initState() {
    genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    super.initState();
  }

  // //sign up new user
  // signUp(User user) async {
  //   try {
  //     var result = await _emailAuth.createAccountRequest(
  //         user.name!, user.email, user.password);

  //     log(result.toString());
  //     if (context.mounted) {
  //       // Navigator.pushNamed(context, '/');

  //       Fluttertoast.showToast(msg: "Account Created Successfully");
  //     }
  //   } on MyException catch (e) {
  //     log(e.toString());
  //     Fluttertoast.showToast(msg: e.message);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Add New Faculty",
                        textColor: AppColors.color927,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                title: "PROFILE IMAGE",
                                textColor: AppColors.color927,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800),
                            SizedBox(
                              height: 10.h,
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.color927,
                              radius: 60.sp,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 60.sp,
                                  color: AppColors.color582,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            AppRichTextView(
                                title: "Change Profile Image",
                                textColor: AppColors.color582,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                title: "Class",
                                textColor: AppColors.colorBlack,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 60.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Class",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: roleValue,
                                          items: <String>['MD1', 'MD2', 'MD3']
                                              .map((String val) =>
                                                  DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(
                                                      val,
                                                      style: TextStyle(
                                                        color: val == roleValue
                                                            ? AppColors
                                                                .colorWhite
                                                            : AppColors
                                                                .color927,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          hint: const Text(
                                            'Please Select the Class',
                                            style: TextStyle(
                                                color: AppColors.colorWhite),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              roleValue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            AppRichTextView(
                                title: "Employee Id",
                                textColor: AppColors.color927,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 60.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Employee Id",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      enable: false,
                                      textStyle: const TextStyle(
                                          color: AppColors.colorWhite),
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => team = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "2023/0100/0126",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                title: "Date of Admission",
                                textColor: AppColors.color927,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 60.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Starts On",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => startDate = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "21.12.2022",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 60.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Course",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: courseValue,
                                          items: <String>[
                                            'Physics',
                                            'Chemistry',
                                            'Pathology',
                                            "Anatomy"
                                          ]
                                              .map((String val) =>
                                                  DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(
                                                      val,
                                                      style: TextStyle(
                                                        color:
                                                            val == courseValue
                                                                ? AppColors
                                                                    .colorWhite
                                                                : AppColors
                                                                    .color927,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          hint: const Text(
                                            'Please Select the Course',
                                            style: TextStyle(
                                                color: AppColors.colorWhite),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              courseValue = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppRichTextView(
                        title: "Student Personal Details".toUpperCase(),
                        textColor: AppColors.colorBlack,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "First Name",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => firstName = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Prabha",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Last Name",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => lastName = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Karan",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Email Address",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   return EmailFormFieldValidator.validate(
                                      //       value);
                                      // },
                                      onSaved: (p0) => email = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "prabha709@gmail.com",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Mobile Number",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   return MobileNumberValidator.validate(
                                      //       value);
                                      // },
                                      onSaved: (p0) => mobile = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "+917305822599",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "DOB",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => dob = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "02.04.1996",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          children: [
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Gender",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: genders.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                for (var gender in genders) {
                                                  gender.isSelected = false;
                                                }
                                                genders[index].isSelected =
                                                    true;
                                              });
                                            },
                                            child: AppRadioButton(
                                              gender: genders[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Address",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => address = p0,
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Chennai, India",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: AppColors.color927,
                              height: 120.sp,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        maxLines: 5,
                                        title: "Education qualification",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => salary = int.parse(p0!),
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Bachelor of Engineering",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: AppColors.color927,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Salary",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      // textValidator: (value) {
                                      //   if (value == null) {
                                      //     return "This Field is Required";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      onSaved: (p0) => salary = int.parse(p0!),
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "000000",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // SignInWithEmailButton(
                    //     caller: client,
                    //     onSignedIn: () {
                    //       Fluttertoast.showToast(
                    //           msg: "Account Created Successfully");
                    //     }),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppElevatedButon(
                              title: "Save",
                              buttonColor: AppColors.color927,
                              textColor: AppColors.colorWhite,
                              height: 50.h,
                              width: 120.w,
                              loading: loading,
                              onPressed: (context) async {
                                if (roleValue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please Select the role");
                                } else if (courseValue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please Select the Department");
                                } else if (positionValue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please Select the Position");
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    // Save the form
                                    _formKey.currentState!.save();

                                    // try {
                                    //   Employee employee = Employee(
                                    //       firstname: firstName!,
                                    //       lastname: lastName!,
                                    //       email: email!,
                                    //       phone: mobile!,
                                    //       gender: "male",
                                    //       address: address!,
                                    //       role: roleValue!,
                                    //       team: team!,
                                    //       onboarding: startDate!,
                                    //       teamlead: teamLead!,
                                    //       image: "",
                                    //       companyid:
                                    //           sessionManager.signedInUser!.id!,
                                    //       dob: dob!,
                                    //       salary: salary!,
                                    //       salarystatus: "unPaid");
                                    //   await api.create(employee);
                                    //   Fluttertoast.showToast(
                                    //       msg: "Employee Added Sucessfully");
                                    //   _formKey.currentState!.reset();
                                    // } catch (e) {
                                    //   Fluttertoast.showToast(msg: e.toString());
                                    // }
                                  }
                                }
                              }),
                          SizedBox(
                            width: 10.h,
                          ),
                          AppElevatedButon(
                            title: "Cancel",
                            buttonColor: AppColors.color927,
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 120.w,
                            loading: loading,
                            onPressed: (context) {
                              setState(() {
                                loading = true;
                              });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const VerticalDivider(),
              Expanded(
                  child: Column(
                children: [
                  roleValue == null
                      ? Container()
                      : Expanded(
                          child: FutureBuilder<List<User>>(
                            future: createUsers(),
                            builder: (context, snapshot) => ScalableDataTable(
                              loadingBuilder: (p0) {
                                return SpinKitSpinningLines(
                                  color: AppColors.color927,
                                  size: 90.sp,
                                );
                              },
                              header: DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                                child: ScalableTableHeader(
                                  columnWrapper: columnWrapper,
                                  children: const [
                                    Text("Subject Code"),
                                    Text('Course Name'),
                                    Text('Credits'),
                                    Text("Assigned Lecturer")
                                  ],
                                ),
                              ),
                              rowBuilder: (context, index) {
                                final user = snapshot.data![index];
                                return ScalableTableRow(
                                  columnWrapper: columnWrapper,
                                  color: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent),
                                  children: [
                                    Text('${user.index}.'),
                                    Text(user.name),
                                    Text(user.points.toString()),
                                    Text(user.surname),
                                    const Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.color927,
                                    ),
                                  ],
                                );
                              },
                              emptyBuilder: (context) =>
                                  const Text('No users yet...'),
                              itemCount: snapshot.data?.length ?? -1,
                              minWidth:
                                  500, // max(MediaQuery.of(context).size.width, 1000),
                              textStyle: TextStyle(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                          ),
                        )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget columnWrapper(BuildContext context, int columnIndex, Widget child) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    switch (columnIndex) {
      case 0:
        return Container(
          width: 120,
          padding: padding,
          child: child,
        );
      case 1:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      case 2:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      case 3:
        return Container(
          width: 170,
          padding: padding,
          child: child,
        );
      case 4:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      default:
        return Expanded(
          child: Container(
            padding: padding,
            child: child,
          ),
        );
    }
  }
}
