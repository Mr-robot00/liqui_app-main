const prodBaseUrl = 'https://router.liquiloans.com/';
const stgBaseUrl = 'https://api-router.liquiloan.in/';
//base url for the app
const debugMode = true;
const baseUrl = debugMode ? stgBaseUrl : prodBaseUrl;

// auth and send OTP API
const getCheckSignupFlowUrl = 'o/web/supply/InvSignUpFlowCheck';
const getCheckAppVersion = 'o/web/GetAppVersion';
const postSendSignupOTPUrl = 'o/web/supply/SendOtp';
const postSendSignInOTPUrl = 'o/web/api-auth/sendOtp';
const postVerifySignupOTPUrl = 'o/web/supply/VerifyOtp';
const postVerifySignInOTPUrl = 'o/web/api-auth/login';
const getInvestorDetailsUrl = 'i/inv/api-auth/user';
const getSignupFlowStatusUrl = 'i/inv/GetInvestorSignUpFlowStatus';
const postSendTxnVerificationOTPUrl = 'i/inv/GetOtpForTxnVerification';
const postVerifyTxnOTPUrl = 'i/inv/verifyTxnReqestOtp';
const postVerifyCKYCUrl = 'o/web/supply/VerifyCkyc';

//--------------------------------****-----****-----****----------------------------------------------//

//create Investor API
const postCreateInvestorUrl = 'o/web/supply/CreateInvestor';
const postVerifyPanUrl = 'o/web/supply/VerifyPan';
const postVerifyPinCodeUrl = 'i/inv/VerifyPincode';
const postCreateAddressUrl = 'i/inv/CreateInvestorAddress';
const postUpdateAddressUrl = 'i/inv/UpdateInvestorAddress';
const postUpdateGenderUrl = 'i/inv/UpdateInvestor';
const postVerifyIFSCUrl = 'i/inv/VerifyIfsc';
const postVerifyBankUrl = 'i/inv/VerifyBank';
const postCreateBankingUrl = 'i/inv/CreateBanking';
const getKYCDocumentListTUrl = 'i/inv/GetInvestorDocumentList';
const postUploadKYCDocumentUrl = 'i/inv/UploadInvestorDocumentsEnc';
const postSignAgreementUrl = 'i/inv/SignAgreement';

//--------------------------------****-----****-----****----------------------------------------------//

// after Successful Login/Register API
const getDashboardSummaryUrl = 'i/inv/GetDashboardSummary';
const getInvestorHierarchy = 'i/inv/GetInvestorHirarchy';
const getMaxInvestmentAmount = 'i/inv/GetMaxInvestmentAmount';
const getMinMaxInvestmentAmount = 'i/inv/GetMinMaxInvestmentAmount';
const getInvestorDataUrl = 'i/inv/GetInvestor';
const getInvestorSchemesUrl = 'i/inv/GetInvestorSchemes';
const getReturnAmountUrl = 'i/inv/GetAmountReturnsSchedule';
const postCreateWithdrawalRequestUrl = 'i/inv/CreateWithdrawalRequest';
const postCreateInvestorPaymentUrl = 'i/inv/CreateInvestmentPaymentGateway';
const getTransactionsUrl = 'i/inv/GetTransactionList';
const getInvestorBanksUrl = 'i/inv/GetInvestorBanking';
const getInvestorProfileUrl = 'i/inv/GetInvestorProfile';
const postChangeDefaultBankUrl = 'i/inv/ChangeDefaultBanking';
const postDeleteBankUrl = 'i/inv/DeleteBanking';
const getReferralUrl = 'i/inv/GetReferralUrl';
const getTransactionHistoryUrl = 'i/inv/GetTransactionHistory';
const getInvestmentSummary = 'i/inv/GetInvestmentSummary';
const postLogOutUrl = 'i/inv/api-auth/logout';

//--------------------------------****-----****-----****----------------------------------------------//

//not using right now
const createInvestorRequest = 'i/inv/CreateInvestmentRequest';
const getCashLedgerUrl = 'i/inv/GetCashLedger?investor_id=';
const getInvestmentSummaryDetailedUrl =
    'i/inv/GetInvestmentSummaryDetailed?investor_id=';
const getInvestmentSummaryUrl = 'i/inv/GetInvestmentSummary?investor_id=';
const postDownloadPassbookUrl = 'i/inv/GetPassbook';

//--------------------------------****-----****-----****----------------------------------------------//

// hyGraph api
const cmsBaseUrl = "https://api-ap-south-1.hygraph.com/";
const postAppConfigUrl = "v2/clfrqd1tc14c501undgm9cnpc/master";

//--------------------------------****-----****-----****----------------------------------------------//
