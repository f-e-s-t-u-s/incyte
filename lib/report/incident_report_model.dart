class IncidentReportModel {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String contactNumber;
  final String gender; // You can use "Male" or "Female"
  final String incidentDescription;

  IncidentReportModel({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.contactNumber,
    required this.gender,
    required this.incidentDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'contactNumber': contactNumber,
      'gender': gender,
      'incidentDescription': incidentDescription,
      // ... other properties ...
    };
  }
}
