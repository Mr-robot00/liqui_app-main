import 'package:liqui_app/global/config/responses/index.dart';
import 'package:liqui_app/global/networking/api_service.dart';
import 'api_path.dart';
import 'graph_api_service.dart';

class MyRepositories {
  Future<CommonResponse> checkSignupFlow({Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getCheckSignupFlowUrl, query: query);
    return CommonResponse.fromJson(response);
  }

  Future<AppVersionResponse> checkAppVersion(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getCheckAppVersion, query: query);
    return AppVersionResponse.fromJson(response);
  }

  Future<SendOtpResponse> sendOTP(dynamic body,
      {bool accountExist = true}) async {
    final response = await apiService.postRequest(
        accountExist ? postSendSignInOTPUrl : postSendSignupOTPUrl, body);
    return SendOtpResponse.fromJson(response);
  }

  Future<DashboardSummaryResponse> dashboardSummary(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getDashboardSummaryUrl, query: query);
    return DashboardSummaryResponse.fromJson(response);
  }

  Future<TransactionsResponse> transactions(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getTransactionsUrl, query: query);
    return TransactionsResponse.fromJson(response);
  }

  Future<CheckSignupStatusResponse> checkSignupFlowStatus(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getCheckSignupFlowUrl, query: query);
    return CheckSignupStatusResponse.fromJson(response);
  }

  Future<InvestorRoleDetailsResponse> investorRoleDetails(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getInvestorDetailsUrl, query: query);
    return InvestorRoleDetailsResponse.fromJson(response);
  }

  Future<InvestorDetailsResponse> investorDetails(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getInvestorDataUrl, query: query);
    return InvestorDetailsResponse.fromJson(response);
  }

  Future<VerifySignInOtpResponse> verifySignInOtp(dynamic body) async {
    final response = await apiService.postRequest(postVerifySignInOTPUrl, body);
    return VerifySignInOtpResponse.fromJson(response);
  }

  Future<CommonResponse> verifySignUpOtp(dynamic body) async {
    final response = await apiService.postRequest(postVerifySignupOTPUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<PanCardDetailsResponse> verifyPanCard(dynamic body) async {
    final response = await apiService.postRequest(postVerifyPanUrl, body);
    return PanCardDetailsResponse.fromJson(response);
  }

  Future<VerifyIFSCResponse> verifyIFSC(dynamic body) async {
    final response = await apiService.postRequest(postVerifyIFSCUrl, body);
    return VerifyIFSCResponse.fromJson(response);
  }

  Future<VerifyBankResponse> verifyBankDetails(dynamic body) async {
    final response = await apiService.postRequest(postVerifyBankUrl, body);
    return VerifyBankResponse.fromJson(response);
  }

  Future<VerifyPinCodeResponse> verifyPinCode(dynamic body) async {
    final response = await apiService.postRequest(postVerifyPinCodeUrl, body);
    return VerifyPinCodeResponse.fromJson(response);
  }

  Future<AddBankAccountResponse> addBankAccount(dynamic body) async {
    final response = await apiService.postRequest(postCreateBankingUrl, body);
    return AddBankAccountResponse.fromJson(response);
  }

  Future<AddAddressResponse> addAddress(dynamic body) async {
    final response = await apiService.postRequest(postCreateAddressUrl, body);
    return AddAddressResponse.fromJson(response);
  }

  Future<VerifyCKYCResponse> verifyCKYC(dynamic body) async {
    final response = await apiService.postRequest(postVerifyCKYCUrl, body);
    return VerifyCKYCResponse.fromJson(response);
  }

  Future<CreateInvestorResponse> createInvestor(dynamic body) async {
    final response = await apiService.postRequest(postCreateInvestorUrl, body);
    return CreateInvestorResponse.fromJson(response);
  }

  Future<InvestorHierarchyResponse> investorHierarchy({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getInvestorHierarchy, query: query);
    return InvestorHierarchyResponse.fromJson(response);
  }

  Future<MinMaxInvestmentResponse> maxInvestmentAmount(
      {Map<String, dynamic>? query}) async {
    final response =
        await apiService.getRequest(getMaxInvestmentAmount, query: query);
    return MinMaxInvestmentResponse.fromJson(response);
  }

  Future<MinMaxInvestmentResponse> minMaxInvestmentAmount(dynamic body) async {
    final response =
        await apiService.postRequest(getMinMaxInvestmentAmount, body);
    return MinMaxInvestmentResponse.fromJson(response);
  }

  Future<BasicDetailResponse> fetchBasicDetail({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getInvestorProfileUrl, query: query);
    return BasicDetailResponse.fromJson(response);
  }

  Future<ReferralResponse> fetchReferralUrl({
    Map<String, dynamic>? query,
  }) async {
    final response = await apiService.getRequest(getReferralUrl, query: query);
    return ReferralResponse.fromJson(response);
  }

  Future<BankAccountsResponse> fetchInvestorBankDetails({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getInvestorBanksUrl, query: query);
    return BankAccountsResponse.fromJson(response);
  }

  Future<DocumentListResponse> fetchDocumentList({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getKYCDocumentListTUrl, query: query);
    // return BasicDetailResponse.fromJson(response);
    return DocumentListResponse.fromJson(response);
  }

  Future<CommonResponse> uploadKYCDocuments(dynamic body) async {
    final response =
        await apiService.postRequest(postUploadKYCDocumentUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> deleteBankApiCall(dynamic body) async {
    final response = await apiService.postRequest(postDeleteBankUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> logOutApiCall(dynamic body) async {
    final response = await apiService.postRequest(postLogOutUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<CommonResponse> changeDefaultBankingApiCall(dynamic body) async {
    final response =
        await apiService.postRequest(postChangeDefaultBankUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<CreateWithdrawRequestResponse> createWithdrawalRequest(
      dynamic body) async {
    final response =
        await apiService.postRequest(postCreateWithdrawalRequestUrl, body);
    return CreateWithdrawRequestResponse.fromJson(response);
  }

  Future<SendOtpResponse> sendTxnOTP(dynamic body) async {
    final response =
        await apiService.postRequest(postSendTxnVerificationOTPUrl, body);
    return SendOtpResponse.fromJson(response);
  }

  Future<CommonResponse> postVerifyTxnOtp(dynamic body) async {
    final response = await apiService.postRequest(postVerifyTxnOTPUrl, body);
    return CommonResponse.fromJson(response);
  }

  Future<InvestorSchemeResponse> getInvestorSchemes({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getInvestorSchemesUrl, query: query);
    return InvestorSchemeResponse.fromJson(response);
  }

  Future<GetReturnsResponse> getReturns({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getReturnAmountUrl, query: query);
    return GetReturnsResponse.fromJson(response);
  }

  Future<SignAgreementResponse> signAgreement(dynamic body) async {
    final response = await apiService.postRequest(postSignAgreementUrl, body);
    return SignAgreementResponse.fromJson(response);
  }

  Future<TransactionDetailsResponse> transactionDetail({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getTransactionHistoryUrl, query: query);
    return TransactionDetailsResponse.fromJson(response);
  }

  Future<MakePaymentResponse> createPaymentPayload(dynamic body) async {
    final response =
        await apiService.postRequest(postCreateInvestorPaymentUrl, body);
    return MakePaymentResponse.fromJson(response);
  }

  Future<UpdateInvestorGenderResponse> updateInvestor(dynamic body) async {
    final response = await apiService.postRequest(postUpdateGenderUrl, body);
    return UpdateInvestorGenderResponse.fromJson(response);
  }

  Future<AppConfigResponse> appConfig(dynamic body) async {
    final response = await graphApiService.postRequest(postAppConfigUrl, body);
    return AppConfigResponse.fromJson(response);
  }

  Future<InvestmentSummaryResponse> investmentSummary({
    Map<String, dynamic>? query,
  }) async {
    final response =
        await apiService.getRequest(getInvestmentSummary, query: query);
    return InvestmentSummaryResponse.fromJson(response);
  }

  Future<DownloadPassbookResponse> downloadPassbook(dynamic body) async {
    final response =
        await apiService.postRequest(postDownloadPassbookUrl, body);
    return DownloadPassbookResponse.fromJson(response);
  }
}

final myRepo = MyRepositories();
