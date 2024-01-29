import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class CompleteForm extends StatefulWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  State<CompleteForm> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<CompleteForm> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    
  int startYear = DateTime.now().year -1; // Specify your start year
  int endYear = DateTime.now().year; // Specify your end year (current year)
    List<int> years = [];

    // Generate a list of years based on the start and end years
    for (int i = startYear; i <= endYear; i++) {
      years.add(i);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FormBuilder(
          key: _formKey,
          // enabled: false,
          onChanged: () {
            _formKey.currentState!.save();
            debugPrint(_formKey.currentState!.value.toString());
          },
          autovalidateMode: AutovalidateMode.disabled,
          //TODO have to remove these later
          initialValue: const {
            'movie_rating': 5,
            'best_language': 'Dart',
            'age': '13',
            'gender': 'Male',
            'languages_filter': ['Dart']
          },
          skipDisabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: AppRichTextView(
                    title: "Program Applying For".toUpperCase(),
                    fontSize: 20.sp,
                    
                    fontWeight: FontWeight.bold),
              ),
              // student Type
                   AppRichTextView(
                                     title: "Select Student Type",
                                     fontSize: 18.sp,
                                     fontWeight: FontWeight.bold),
              FormBuilderCheckboxGroup<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                     const InputDecoration(
                       border: InputBorder.none,
               ),
                name: 'Student Type',
            
                options: const [
                  FormBuilderFieldOption(value: 'Regular Student'),
                  FormBuilderFieldOption(value: 'Transfer Student'),
                ],
                onChanged: _onChanged,
                separator: const VerticalDivider(
                  width: 10,
                  thickness: 5,
                  color: Colors.red,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(1),
                  FormBuilderValidators.maxLength(3),
                ]),
              ),
const Divider(),
              // Programme
                 AppRichTextView(
                  title: "Programme Applying for",
                  fontSize: 18.sp,
                  
                  fontWeight: FontWeight.bold),
              FormBuilderCheckboxGroup<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    const InputDecoration( border: InputBorder.none,),
                name: 'Program',
               
                options: const [
                  FormBuilderFieldOption(value: 'Doctor of Medicine'),
                  FormBuilderFieldOption(value: 'Pre Medicals'),
                ],
                onChanged: _onChanged,
                separator: const VerticalDivider(
                  width: 10,
                  thickness: 5,
                  color: Colors.red,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(1),
                  FormBuilderValidators.maxLength(3),
                ]),
              ),
              const Divider(),
              //Select Year 
                AppRichTextView(
                                  title: "Semester Applying For",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                                  SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: FormBuilderDropdown<int>(
                    
                      isDense: true,
                      isExpanded: true,
                      name: 'Year',
                      decoration: const InputDecoration(
                  hintText: "Year"
                      ),
                      validator: FormBuilderValidators.compose(
                        
                          [FormBuilderValidators.required()]),
                      items: years
                          .map((year) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: year,
                                child: Text(year.toString()),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          (_formKey.currentState?.fields['Year']?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                  ),
                  SizedBox(width: 10.w,),
                    Expanded(
                      child: FormBuilderCheckboxGroup<String>(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration:
                      const InputDecoration(border: InputBorder.none),
                                      name: 'Semester',
                                      // initialValue: const ['Dart'],
                                      options: const [
                                        FormBuilderFieldOption(value: 'January'),
                                        FormBuilderFieldOption(value: 'May'),
                                        FormBuilderFieldOption(value: 'September'),
                                      ],
                                      onChanged: _onChanged,
                                      separator: const VerticalDivider(
                                        width: 10,
                                        thickness: 5,
                                        color: Colors.red,
                                      ),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.minLength(1),
                                        FormBuilderValidators.maxLength(3),
                                      ]),
                                    ),
                    ),
                ],
              ),

            
            
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: AppRichTextView(
                    title: "Previous Enrolment".toUpperCase(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: AppRichTextView(
                      title:
                          "Have you previously applied to study, or enroll at Rajiv Gandhi Univeristy of Science and Technology(RGUST) or one of its predecessor colleges?",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,)),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                initialValue: null,
                name: 'Previous Enrolment',
                onChanged: _onChanged,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                options: [
                  'Yes',
                  'No',
                ]
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),
           
              const Divider(),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: AppRichTextView(
                    title:
                        "${"Personal Details".toUpperCase()} (As they appear on your passport where applicable)",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'First Name',
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  // suffixIcon: _ageHasError
                  //     ? const Icon(Icons.error, color: Colors.red)
                  //     : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    !(_formKey.currentState?.fields['First Name']?.validate() ??
                        false);
                  });
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.max(70),
                ]),
                // initialValue: '12',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'Last Name',
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  // suffixIcon: _ageHasError
                  //     ? const Icon(Icons.error, color: Colors.red)
                  //     : const Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (val) {
                  setState(() {
                    !(_formKey.currentState?.fields['Last Name']?.validate() ??
                        false);
                  });
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.max(70),
                ]),
                // initialValue: '12',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'Previous Name',
                decoration: const InputDecoration(
                  labelText: 'Previous Name',
                ),
                onChanged: (val) {
                  setState(() {
                    !(_formKey.currentState?.fields['Previous Name']
                            ?.validate() ??
                        false);
                  });
                },
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.max(70),
                ]),

                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AppRichTextView(
                    title:
                        "If Your Academic Records are Submitted in Another Name, Please Provide Certified Evidence of Change of Name",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text("Attach"))),
              Column(
                children: <Widget>[
                  const SizedBox(height: 15),
                  FormBuilderDateTimePicker(
                    name: 'date',
                    initialEntryMode: DatePickerEntryMode.calendar,
                    initialValue: DateTime.now(),
                    inputType: InputType.both,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _formKey.currentState!.fields['date']
                              ?.didChange(null);
                        },
                      ),
                    ),
                    initialTime: const TimeOfDay(hour: 8, minute: 0),
                    // locale: const Locale.fromSubtags(languageCode: 'fr'),
                  ),
                  FormBuilderDropdown<String>(
                    name: 'gender',
                    decoration: InputDecoration(
                      
                      labelText: 'Gender',
                      suffix: _genderHasError
                          ? const Icon(Icons.error)
                          : const Icon(Icons.check),
                      hintText: 'Select Gender',
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              alignment: AlignmentDirectional.topStart,
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _genderHasError = !(_formKey
                                .currentState?.fields['gender']
                                ?.validate() ??
                            false);
                      });
                    },
                    valueTransformer: (val) => val?.toString(),
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'CitizenShip',
                    decoration: const InputDecoration(
                      labelText: 'Country of CitizenShip',
                    ),
                    onChanged: (val) {
                      setState(() {
                        !(_formKey.currentState?.fields['CitizenShip']
                                ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(70),
                    ]),

                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'Passport',
                    decoration: const InputDecoration(
                      labelText: 'Passport Number',
                    ),
                    onChanged: (val) {
                      setState(() {
                        !(_formKey.currentState?.fields['Passport']
                                ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(70),
                    ]),

                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'Birth',
                    decoration: const InputDecoration(
                      labelText: 'Country of Birth',
                    ),
                    onChanged: (val) {
                      setState(() {
                        !(_formKey.currentState?.fields['Birth']?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(70),
                    ]),

                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
               
               SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AppRichTextView(
                    title:
                        "Which Country do you Currently Reside In?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
               FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'Country Reside In',
                    decoration: const InputDecoration(
                      labelText: 'My Country of Citizenship is',
                    ),
                    onChanged: (val) {
                      setState(() {
                        !(_formKey.currentState?.fields['Birth']?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(70),
                    ]),

                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                       SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AppRichTextView(
                    title:
                        "Will you be studying on a student visa ?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
            
                ),
                initialValue: null,
                name: 'student visa',
                onChanged: _onChanged,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                options: [
                  'Yes',
                  'No',
                ]
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),

                  SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AppRichTextView(
                    title:
                        "Do you speak a language other than English at you Permanent home address?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                border: InputBorder.none
            
                ),
                initialValue: null,
                name: 'Eng Lang',
                onChanged: _onChanged,
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                options: [
                  'Yes',
                  'No',
                ]
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),
                  FormBuilderCheckbox(
                    name: 'accept_terms',
                    initialValue: false,
                    onChanged: _onChanged,
                    title: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                            // Flutter doesn't allow a button inside a button
                            // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                            /*
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('launch url');
                              },
                            */
                          ),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.equal(
                      true,
                      errorText:
                          'You must accept terms and conditions to continue',
                    ),
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.always,
                    name: 'age',
                    decoration: InputDecoration(
                      labelText: 'Age',
                      suffixIcon: _ageHasError
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _ageHasError = !(_formKey.currentState?.fields['age']
                                ?.validate() ??
                            false);
                      });
                    },
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ]),
                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  FormBuilderRadioGroup<String>(
                    decoration: const InputDecoration(
                      labelText: 'My chosen language',
                    ),
                    initialValue: null,
                    name: 'best_language',
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text(lang),
                            ))
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                  ),
                  FormBuilderSwitch(
                    title: const Text('I Accept the terms and conditions'),
                    name: 'accept_terms_switch',
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  FormBuilderCheckboxGroup<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: 'The language of my people'),
                    name: 'languages',
                    // initialValue: const ['Dart'],
                    options: const [
                      FormBuilderFieldOption(value: 'Dart'),
                      FormBuilderFieldOption(value: 'Kotlin'),
                      FormBuilderFieldOption(value: 'Java'),
                      FormBuilderFieldOption(value: 'Swift'),
                      FormBuilderFieldOption(value: 'Objective-C'),
                    ],
                    onChanged: _onChanged,
                    separator: const VerticalDivider(
                      width: 10,
                      thickness: 5,
                      color: Colors.red,
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1),
                      FormBuilderValidators.maxLength(3),
                    ]),
                  ),
                  FormBuilderFilterChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: 'The language of my people'),
                    name: 'languages_filter',
                    selectedColor: Colors.red,
                    options: const [
                      FormBuilderChipOption(
                        value: 'Dart',
                        avatar: CircleAvatar(child: Text('D')),
                      ),
                      FormBuilderChipOption(
                        value: 'Kotlin',
                        avatar: CircleAvatar(child: Text('K')),
                      ),
                      FormBuilderChipOption(
                        value: 'Java',
                        avatar: CircleAvatar(child: Text('J')),
                      ),
                      FormBuilderChipOption(
                        value: 'Swift',
                        avatar: CircleAvatar(child: Text('S')),
                      ),
                      FormBuilderChipOption(
                        value: 'Objective-C',
                        avatar: CircleAvatar(child: Text('O')),
                      ),
                    ],
                    onChanged: _onChanged,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(1),
                      FormBuilderValidators.maxLength(3),
                    ]),
                  ),
                  FormBuilderChoiceChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText:
                            'Ok, if I had to choose one language, it would be:'),
                    name: 'languages_choice',
                    initialValue: 'Dart',
                    options: const [
                      FormBuilderChipOption(
                        value: 'Dart',
                        avatar: CircleAvatar(child: Text('D')),
                      ),
                      FormBuilderChipOption(
                        value: 'Kotlin',
                        avatar: CircleAvatar(child: Text('K')),
                      ),
                      FormBuilderChipOption(
                        value: 'Java',
                        avatar: CircleAvatar(child: Text('J')),
                      ),
                      FormBuilderChipOption(
                        value: 'Swift',
                        avatar: CircleAvatar(child: Text('S')),
                      ),
                      FormBuilderChipOption(
                        value: 'Objective-C',
                        avatar: CircleAvatar(child: Text('O')),
                      ),
                    ],
                    onChanged: _onChanged,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value["Previous Enrolment"].toString());
                        } else {
                           debugPrint(_formKey.currentState?.value["Previous Enrolment"].toString());
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
