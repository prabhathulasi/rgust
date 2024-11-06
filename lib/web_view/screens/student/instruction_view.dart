

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';

class StudentInstructionView extends StatefulWidget {
final String ? token;
final String ? dobInput;
final String ? imageEncoded;
final String? gender;
final List<int>? selectedCourse;
  const   StudentInstructionView({super.key,required this.token,required this.dobInput,  required this.imageEncoded,required this.gender, this.selectedCourse});

  @override
  State<StudentInstructionView> createState() => _StudentInstructionViewState();
}
bool loading = false;
class _StudentInstructionViewState extends State<StudentInstructionView> {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
     final programProvider = Provider.of<ProgramProvider>(context);
          final commonProvider = Provider.of<CommonProvider>(context);
    return  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
           
            const Text(
              "1. I confirm that all the information provided is accurate and up to date to the best of my knowledge.",
              
            ),
            const Text(
              "2. I ensure that there are no duplicate entries or redundant information in the submitted data.",
              
            ),
            const Text(
              "3. The provided image adheres to the requirement of a white background as specified for identification purposes.",
              
            ),
            const Text(
              "4. I have verified that there are no errors or inaccuracies in the information submitted, ensuring its correctness.",
              
            ),
            const Text(
              "5. I affirm that the information submitted maintains its integrity and authenticity without manipulation or misrepresentation.",
              
            ),
            const Text(
              "6. The image submitted complies with the mandated criteria, ensuring clarity and adherence to guidelines.",
              
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                AppElevatedButon(
                    title: "Submit",
                    buttonColor: AppColors.colorc7e,
                    textColor: AppColors.colorWhite,
                    height: 60.h,
                    width: 130.w,
                    loading:loading,
                    onPressed: (context) async {
                 setState(() {
                   loading= true;
                 });
                      var result = await studentProvider.addStudent(
                        widget.token!,
                        programId: int.parse(programProvider.selectedDept!),
                        classId: int.parse(programProvider.selectedClass!),
                        admissionDate:commonProvider.doaController,
                        studentType: programProvider.isNewStudent==1? "Regular":"Transfer",
                        batch: programProvider.selectedBatch!,
                        registerNo:
                            studentProvider.studentRegisterNumberController!,
                        gender: widget.gender!,
                        dob: widget.dobInput!,
                        userImage: widget.imageEncoded!,
                        selectedCourseList: widget.selectedCourse!
                      );
                      

                      if (result != null) {
                        if (context.mounted) {
                          setState(() {
                            loading= false;
                          });
                          Navigator.pop(context);
                                 Navigator.pop(context);
                        }
                      }else{
                        setState(() {
                          loading= false;
                        });
                      }
                    }),
                SizedBox(
                  width: 10.w,
                ),
                AppElevatedButon(
                    title: "Close",
                    buttonColor: AppColors.colorc7e,
                    textColor: AppColors.colorWhite,
                    height: 50.h,
                    width: 130.w,
                    
                    onPressed: (context) async {
                 
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      );
  }
}