

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../theme.dart';
import 'incident_report_model.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() =>
      _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController incidentDescriptionController = TextEditingController();


  int? _radioValue = 1;

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = appTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
            ),
          ),
          title: FxText.titleMedium("Report Crime", fontWeight: 600),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: FxSpacing.nTop(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                  const EdgeInsets.only(left: 0, right: 20, top: 0, bottom: 12),
                  child: FxText.titleMedium("Personal", fontWeight: 600),
                ),
                TextFormField(
                  controller: firstNameController ,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: theme.inputDecorationTheme.border,
                    enabledBorder: theme.inputDecorationTheme.border,
                    focusedBorder: theme.inputDecorationTheme.focusedBorder,
                    prefixIcon: Icon(MdiIcons.accountOutline, size: 24),
                  ),
                  // onChanged: (value)
                  // {
                  //   setState(() {
                  //     firstName = value;
                  //   });
                  // },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: lastNameController ,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon: Icon(MdiIcons.accountOutline, size: 24),
                    ),
                  ),
                ),

                Row(

                  children: <Widget>[
                    FxText.bodyLarge("Gender", fontWeight: 600),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Radio(
                        value: 1,
                        activeColor: theme.colorScheme.primary,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                    ),
                    FxText.titleSmall("Male",
                        color: theme.colorScheme.onBackground.withAlpha(240),
                        letterSpacing: 0.2,
                        fontWeight: 500),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Radio(
                        value: 2,
                        activeColor: theme.colorScheme.primary,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                      ),
                    ),
                    FxText.titleSmall("Female",
                        color: theme.colorScheme.onBackground.withAlpha(240),
                        letterSpacing: 0.2,
                        fontWeight: 500),
                  ],
                ),























                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: FxText.titleMedium("Contact", fontWeight: 600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: emailAddressController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon: Icon(
                        MdiIcons.emailOutline,
                        size: 24,
                      ),
                    ),
                    // onChanged: (value)
                    // {
                    //   emailAddress = value;
                    // },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: contactNumberController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon: Icon(
                        MdiIcons.phoneOutline,
                        size: 24,
                      ),
                    ),
                    // onChanged: (value)
                    // {
                    //   setState(() {
                    //     contactNumber = value;
                    //   });
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child:
                  FxText.titleMedium("Incident Report Details", fontWeight: 600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: incidentDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Describe your Incident",
                      isDense: true,
                      filled: true,
                      fillColor: theme.colorScheme.background,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 5,
                    maxLines: 10,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withAlpha(28),
                          blurRadius: 4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: /*ElevatedButton(
                        onPressed: () async {

                            IncidentReportModel report = IncidentReportModel(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              emailAddress: emailAddressController.text,
                              contactNumber: contactNumberController.text,
                              gender: _radioValue == 1 ? 'Male' : 'Female',
                              incidentDescription: incidentDescriptionController
                                  .text,
                            );

                            // Validate returns true if the form is valid, or false otherwise.


                            try {
                              await FirebaseFirestore.instance.collection(
                                  'incident_reports').add(report.toMap());
                              // Show a success message to the user
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Incident report saved successfully'),),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Error saving incident report')),
                              );
                            }
                            *//*        // Access the entered data from the instance variables
                          print(report.firstName);
                          print(report.lastName);
                          print(report.emailAddress);
                          print(report.contactNumber);
                          print(report.gender);
                          print(report.incidentDescription);*//*
                            // ... print other data ...
                          },
                        child: FxText.bodyMedium("REPORT",
                            fontWeight: 700,
                            letterSpacing: 0.2,
                            color: theme.colorScheme.onPrimary)),*/






                    ElevatedButton(
                      onPressed: () async {
                        // Trim spaces from input fields
                        String trimmedFirstName = firstNameController.text.trim();
                        String trimmedLastName = lastNameController.text.trim();
                        String trimmedEmailAddress = emailAddressController.text.trim();
                        String trimmedContactNumber = contactNumberController.text.trim();
                        String trimmedIncidentDescription = incidentDescriptionController.text.trim();



                        // Perform input validation
                        if (trimmedFirstName.isEmpty ||
                            trimmedLastName.isEmpty ||
                            trimmedEmailAddress.isEmpty ||
                            trimmedContactNumber.isEmpty ||
                            trimmedIncidentDescription.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields')),
                          );
                          return; // Stop further execution
                        }

                        // Validate First Name (Should not contain numbers)
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(trimmedFirstName)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid First Name')),
                          );
                          return; // Stop further execution
                        }

                        // Validate Last Name (Should not contain numbers)
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(trimmedLastName)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid Last Name')),
                          );
                          return; // Stop further execution
                        }

                        // Validate Email Address
                        if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(trimmedEmailAddress)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid Email Address')),
                          );
                          return; // Stop further execution
                        }

                        //Validate Contact Number (Should be numbers and max length of 10)
                        // Validate Contact Number (Should be numbers, not a single digit, and length of 10)
                        if (!RegExp(r'^(?!0$)\d{10}$').hasMatch(trimmedContactNumber)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid Contact Number')),
                          );
                          return; // Stop further execution
                        }

                        // If all validations pass, proceed with saving the data
                        IncidentReportModel report = IncidentReportModel(
                          firstName: trimmedFirstName,
                          lastName: trimmedLastName,
                          emailAddress: trimmedEmailAddress,
                          contactNumber: trimmedContactNumber,
                          gender: _radioValue == 1 ? 'Male' : 'Female',
                          incidentDescription: trimmedIncidentDescription,
                        );

                        try {
                          await FirebaseFirestore.instance.collection('incident_reports').add(report.toMap());
                          // Show a success message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Incident report saved successfully')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error saving incident report')),
                          );
                        }
                        //clear input fields
                        firstNameController.clear();
                        lastNameController.clear();
                        emailAddressController.clear();
                        contactNumberController.clear();
                        incidentDescriptionController.clear();

                      },
                      // Clear input fields


                      child: FxText.bodyMedium(
                        "REPORT",
                        fontWeight: 700,
                        letterSpacing: 0.2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
























                  ),
                )
              ],
            ),
          ),
        ));
  }
}