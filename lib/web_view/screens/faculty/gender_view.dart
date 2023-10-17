import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_radiobutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class GenderView extends StatefulWidget {
  final String ?gender;
  const GenderView({super.key, this.gender});

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
   List<Gender> genders = [];
    String? genderValue;
  @override
  void initState() {
        genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<FacultyProvider>(
                                    builder: (context, facultyGender, child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppRichTextView(
                                              title: "Gender",
                                              textColor: AppColors.colorWhite,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                         facultyGender.isGenderEdited == false? Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                AppRichTextView(
                                                  title:
                                                      widget.gender!,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: AppColors.color0ec,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    facultyGender.updateGender(true);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: AppColors.color0ec,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ):
                                          Expanded(
                                              child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: genders.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      for (var gender in genders) {
                                                        gender.isSelected = false;
                                                      }
                                                      genders[index].isSelected =
                                                          true;
                                                      genderValue =
                                                          genders[index].name;
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
                                      );
                                    }
                                  );
  }
}