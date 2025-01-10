/// status : true
/// message : "Data"
/// data : {"investor_id":373778,"profile_status":"Approved","max_investment_bucket":"50L","kyc_status":null,"nach":"NA","first_investment":"","nominee":"","family_details":"","kyc_details":"","personal_details":{"dob":"1993-12-28","gender":"Male","pan":"KAIPS2812H","name":"Kailash Suthar","email":"kailash.suthar@liquiloans.com","contact_number":"9166772812"},"address_details":[{"id":22093,"address_line_1":"Bhayandar East","address_line_2":null,"area":null,"city":"THANE","state":"MAHARASHTRA","pin_code":"401105","address_type":"Current","ownership_type":"Owned","created_at":"2022-07-22 11:53:41"}],"bank_details":[{"id":372775,"account_type":"Saving","bank_name":"ICICI BANK LIMITED","branch_name":"MUMBAI - THANE BELAPUR ROADu252cu00e1","ifsc":"ICIC0000541","account_number":"054101506351","account_holder_name":"KAILASH SUTHAR","is_default":"Yes","status":"Active","kyc_status":"Verified","created_at":"2022-07-26 11:39:57"}],"document_details":[{"id":39409,"file_name":"CHEQUE-4345-1658905357.png","file_path":"eyJ","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 12:32:38","updated_by_email":"kailash.suthar@liquiloans.com","file":"“Q5l\"","mime_type":"image/png"},{"id":39418,"file_name":"PANCARD-9992-1658910632.png","file_path":"ey","approval_status":"Pending","document_source":"Manual","document_type":"PAN Card","document_type_id":2,"document_category":"ProofOfIdentity","created_at":"2022-07-27 14:00:32","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVB","mime_type":"image/png"},{"id":39420,"file_name":"CHEQUE-7374-1658914960.png","file_path":"ey","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:12:40","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVQmCC","mime_type":"image/png"},{"id":39421,"file_name":"CHEQUE-8055-1658915348.png","file_path":"eyJp=","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:19:08","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBORCC","mime_type":"image/png"},{"id":39422,"file_name":"CHEQUE-8720-1658915395.png","file_path":"eyJ","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:19:55","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBQmCC","mime_type":"image/png"},{"id":39423,"file_name":"CHEQUE-4262-1658916083.png","file_path":"eyJpdiI6IQifQ==","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:31:23","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBORwkSuQmCC","mime_type":"image/png"},{"id":39424,"file_name":"AADHAARCARD-9197-1658916461.jpeg","file_path":"eyJpdiI6IlQ4MiJ9","approval_status":"Pending","document_source":"Manual","document_type":"Aadhaar Card","document_type_id":3,"document_category":"ProofOfAddress","created_at":"2022-07-27 15:37:41","updated_by_email":"kailash.suthar@liquiloans.com","file":"/9j/4AAn9n","mime_type":"image/jpeg"}],"agreement_details":{"agreement_status":"Signed"}}
/// code : 200

class CheckSignupStatusResponse {
  CheckSignupStatusResponse({
    this.status,
    this.message,
    this.signupStatusDetails,
    this.code,
  });

  CheckSignupStatusResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    signupStatusDetails = json['data'] != null
        ? json['data'] is List
            ? null
            : CheckSignupStatusModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  CheckSignupStatusModel? signupStatusDetails;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (signupStatusDetails != null) {
      map['data'] = signupStatusDetails?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// investor_id : 373778
/// profile_status : "Approved"
/// max_investment_bucket : "50L"
/// kyc_status : null
/// nach : "NA"
/// first_investment : ""
/// nominee : ""
/// family_details : ""
/// kyc_details : ""
/// personal_details : {"dob":"1993-12-28","gender":"Male","pan":"KAIPS2812H","name":"Kailash Suthar","email":"kailash.suthar@liquiloans.com","contact_number":"9166772812"}
/// address_details : [{"id":22093,"address_line_1":"Bhayandar East","address_line_2":null,"area":null,"city":"THANE","state":"MAHARASHTRA","pin_code":"401105","address_type":"Current","ownership_type":"Owned","created_at":"2022-07-22 11:53:41"}]
/// bank_details : [{"id":372775,"account_type":"Saving","bank_name":"ICICI BANK LIMITED","branch_name":"MUMBAI - THANE BELAPUR ROADu252cu00e1","ifsc":"ICIC0000541","account_number":"054101506351","account_holder_name":"KAILASH SUTHAR","is_default":"Yes","status":"Active","kyc_status":"Verified","created_at":"2022-07-26 11:39:57"}]
/// document_details : [{"id":39409,"file_name":"CHEQUE-4345-1658905357.png","file_path":"eyJ","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 12:32:38","updated_by_email":"kailash.suthar@liquiloans.com","file":"“Q5l\"","mime_type":"image/png"},{"id":39418,"file_name":"PANCARD-9992-1658910632.png","file_path":"ey","approval_status":"Pending","document_source":"Manual","document_type":"PAN Card","document_type_id":2,"document_category":"ProofOfIdentity","created_at":"2022-07-27 14:00:32","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVB","mime_type":"image/png"},{"id":39420,"file_name":"CHEQUE-7374-1658914960.png","file_path":"ey","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:12:40","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVQmCC","mime_type":"image/png"},{"id":39421,"file_name":"CHEQUE-8055-1658915348.png","file_path":"eyJp=","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:19:08","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBORCC","mime_type":"image/png"},{"id":39422,"file_name":"CHEQUE-8720-1658915395.png","file_path":"eyJ","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:19:55","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBQmCC","mime_type":"image/png"},{"id":39423,"file_name":"CHEQUE-4262-1658916083.png","file_path":"eyJpdiI6IQifQ==","approval_status":"Pending","document_source":"Manual","document_type":"Cheque","document_type_id":32,"document_category":"Banking","created_at":"2022-07-27 15:31:23","updated_by_email":"kailash.suthar@liquiloans.com","file":"iVBORwkSuQmCC","mime_type":"image/png"},{"id":39424,"file_name":"AADHAARCARD-9197-1658916461.jpeg","file_path":"eyJpdiI6IlQ4MiJ9","approval_status":"Pending","document_source":"Manual","document_type":"Aadhaar Card","document_type_id":3,"document_category":"ProofOfAddress","created_at":"2022-07-27 15:37:41","updated_by_email":"kailash.suthar@liquiloans.com","file":"/9j/4AAn9n","mime_type":"image/jpeg"}]
/// agreement_details : {"agreement_status":"Signed"}

class CheckSignupStatusModel {
  CheckSignupStatusModel({
    this.investorId,
    this.profileStatus,
    this.maxInvestmentBucket,
    this.kycStatus,
    this.nach,
    this.firstInvestment,
    this.nominee,
    this.familyDetails,
    this.kycDetails,
    this.personalDetails,
    this.addressDetails,
    this.bankDetails,
    this.documentDetails,
    this.agreementDetails,
  });

  CheckSignupStatusModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    profileStatus = json['profile_status'];
    maxInvestmentBucket = json['max_investment_bucket'];
    kycStatus = json['kyc_status'];
    nach = json['nach'];
    firstInvestment = json['first_investment'];
    nominee = json['nominee'];
    familyDetails = json['family_details'];
    kycDetails = json['kyc_details'];
    personalDetails = json['personal_details'] != null
        ? PersonalDetails.fromJson(json['personal_details'])
        : null;
    if (json['address_details'] != null) {
      addressDetails = [];
      json['address_details'].forEach((v) {
        addressDetails?.add(AddressDetails.fromJson(v));
      });
    }
    if (json['bank_details'] != null) {
      bankDetails = [];
      json['bank_details'].forEach((v) {
        bankDetails?.add(BankDetails.fromJson(v));
      });
    }
    if (json['document_details'] != null) {
      documentDetails = [];
      json['document_details'].forEach((v) {
        documentDetails?.add(DocumentDetails.fromJson(v));
      });
    }
    agreementDetails = json['agreement_details'] != null
        ? AgreementDetails.fromJson(json['agreement_details'])
        : null;
  }

  num? investorId;
  String? profileStatus;
  String? maxInvestmentBucket;
  dynamic kycStatus;
  String? nach;
  String? firstInvestment;
  String? nominee;
  String? familyDetails;
  String? kycDetails;
  PersonalDetails? personalDetails;
  List<AddressDetails>? addressDetails;
  List<BankDetails>? bankDetails;
  List<DocumentDetails>? documentDetails;
  AgreementDetails? agreementDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['profile_status'] = profileStatus;
    map['max_investment_bucket'] = maxInvestmentBucket;
    map['kyc_status'] = kycStatus;
    map['nach'] = nach;
    map['first_investment'] = firstInvestment;
    map['nominee'] = nominee;
    map['family_details'] = familyDetails;
    map['kyc_details'] = kycDetails;
    if (personalDetails != null) {
      map['personal_details'] = personalDetails?.toJson();
    }
    if (addressDetails != null) {
      map['address_details'] = addressDetails?.map((v) => v.toJson()).toList();
    }
    if (bankDetails != null) {
      map['bank_details'] = bankDetails?.map((v) => v.toJson()).toList();
    }
    if (documentDetails != null) {
      map['document_details'] =
          documentDetails?.map((v) => v.toJson()).toList();
    }
    if (agreementDetails != null) {
      map['agreement_details'] = agreementDetails?.toJson();
    }
    return map;
  }
}

/// agreement_status : "Signed"

class AgreementDetails {
  AgreementDetails({
    this.agreementStatus,
  });

  AgreementDetails.fromJson(dynamic json) {
    agreementStatus = json['agreement_status'];
  }

  String? agreementStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agreement_status'] = agreementStatus;
    return map;
  }
}

/// id : 39409
/// file_name : "CHEQUE-4345-1658905357.png"
/// file_path : "eyJ"
/// approval_status : "Pending"
/// document_source : "Manual"
/// document_type : "Cheque"
/// document_type_id : 32
/// document_category : "Banking"
/// created_at : "2022-07-27 12:32:38"
/// updated_by_email : "kailash.suthar@liquiloans.com"
/// file : "“Q5l\""
/// mime_type : "image/png"

class DocumentDetails {
  DocumentDetails({
    this.id,
    this.fileName,
    this.filePath,
    this.approvalStatus,
    this.documentSource,
    this.documentType,
    this.documentTypeId,
    this.documentCategory,
    this.createdAt,
    this.updatedByEmail,
    this.file,
    this.mimeType,
  });

  DocumentDetails.fromJson(dynamic json) {
    id = json['id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    approvalStatus = json['approval_status'];
    documentSource = json['document_source'];
    documentType = json['document_type'];
    documentTypeId = json['document_type_id'];
    documentCategory = json['document_category'];
    createdAt = json['created_at'];
    updatedByEmail = json['updated_by_email'];
    file = json['file'];
    mimeType = json['mime_type'];
  }

  num? id;
  String? fileName;
  String? filePath;
  String? approvalStatus;
  String? documentSource;
  String? documentType;
  num? documentTypeId;
  String? documentCategory;
  String? createdAt;
  String? updatedByEmail;
  String? file;
  String? mimeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_name'] = fileName;
    map['file_path'] = filePath;
    map['approval_status'] = approvalStatus;
    map['document_source'] = documentSource;
    map['document_type'] = documentType;
    map['document_type_id'] = documentTypeId;
    map['document_category'] = documentCategory;
    map['created_at'] = createdAt;
    map['updated_by_email'] = updatedByEmail;
    map['file'] = file;
    map['mime_type'] = mimeType;
    return map;
  }
}

/// id : 372775
/// account_type : "Saving"
/// bank_name : "ICICI BANK LIMITED"
/// branch_name : "MUMBAI - THANE BELAPUR ROADu252cu00e1"
/// ifsc : "ICIC0000541"
/// account_number : "054101506351"
/// account_holder_name : "KAILASH SUTHAR"
/// is_default : "Yes"
/// status : "Active"
/// kyc_status : "Verified"
/// created_at : "2022-07-26 11:39:57"

class BankDetails {
  BankDetails({
    this.id,
    this.accountType,
    this.bankName,
    this.branchName,
    this.ifsc,
    this.accountNumber,
    this.accountHolderName,
    this.isDefault,
    this.status,
    this.kycStatus,
    this.createdAt,
  });

  BankDetails.fromJson(dynamic json) {
    id = json['id'];
    accountType = json['account_type'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    ifsc = json['ifsc'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    isDefault = json['is_default'];
    status = json['status'];
    kycStatus = json['kyc_status'];
    createdAt = json['created_at'];
  }

  num? id;
  String? accountType;
  String? bankName;
  String? branchName;
  String? ifsc;
  String? accountNumber;
  String? accountHolderName;
  String? isDefault;
  String? status;
  String? kycStatus;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['account_type'] = accountType;
    map['bank_name'] = bankName;
    map['branch_name'] = branchName;
    map['ifsc'] = ifsc;
    map['account_number'] = accountNumber;
    map['account_holder_name'] = accountHolderName;
    map['is_default'] = isDefault;
    map['status'] = status;
    map['kyc_status'] = kycStatus;
    map['created_at'] = createdAt;
    return map;
  }
}

/// id : 22093
/// address_line_1 : "Bhayandar East"
/// address_line_2 : null
/// area : null
/// city : "THANE"
/// state : "MAHARASHTRA"
/// pin_code : "401105"
/// address_type : "Current"
/// ownership_type : "Owned"
/// created_at : "2022-07-22 11:53:41"

class AddressDetails {
  AddressDetails({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.area,
    this.city,
    this.state,
    this.pinCode,
    this.addressType,
    this.ownershipType,
    this.createdAt,
  });

  AddressDetails.fromJson(dynamic json) {
    id = json['id'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pin_code'];
    addressType = json['address_type'];
    ownershipType = json['ownership_type'];
    createdAt = json['created_at'];
  }

  num? id;
  String? addressLine1;
  dynamic addressLine2;
  dynamic area;
  String? city;
  String? state;
  String? pinCode;
  String? addressType;
  String? ownershipType;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['area'] = area;
    map['city'] = city;
    map['state'] = state;
    map['pin_code'] = pinCode;
    map['address_type'] = addressType;
    map['ownership_type'] = ownershipType;
    map['created_at'] = createdAt;
    return map;
  }
}

/// dob : "1993-12-28"
/// gender : "Male"
/// pan : "KAIPS2812H"
/// name : "Kailash Suthar"
/// email : "kailash.suthar@liquiloans.com"
/// contact_number : "9166772812"

class PersonalDetails {
  PersonalDetails({
    this.dob,
    this.gender,
    this.pan,
    this.name,
    this.email,
    this.contactNumber,
  });

  PersonalDetails.fromJson(dynamic json) {
    dob = json['dob'];
    gender = json['gender'];
    pan = json['pan'];
    name = json['name'];
    email = json['email'];
    contactNumber = json['contact_number'];
  }

  String? dob;
  String? gender;
  String? pan;
  String? name;
  String? email;
  String? contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dob'] = dob;
    map['gender'] = gender;
    map['pan'] = pan;
    map['name'] = name;
    map['email'] = email;
    map['contact_number'] = contactNumber;
    return map;
  }
}
