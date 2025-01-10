import 'package:get/get.dart';
import 'package:liqui_app/global/config/bindings/index.dart';
import 'package:liqui_app/global/config/pages/index.dart';
import 'package:liqui_app/global/widgets/index.dart';

List<GetPage> pageRoutes = [
  GetPage(
    name: splashScreen,
    page: () => const Splash(),
    binding: SplashBindings(),
  ),
  GetPage(
    name: loginScreen,
    page: () => const Login(),
    binding: LoginBindings(),
  ),
  GetPage(
    name: homeScreen,
    page: () => const Home(),
    binding: HomeBindings(),
  ),
  GetPage(
    name: selectFolioScreen,
    page: () => const SelectFolio(),
    binding: HierarchyBindings(),
  ),
  GetPage(
    name: dashboardScreen,
    page: () => const Dashboard(),
    binding: DashboardBindings(),
  ),
  GetPage(
    name: transactionsScreen,
    page: () => const Transactions(),
    binding: TransactionsBindings(),
  ),
  GetPage(
    name: profileScreen,
    page: () => const Profile(),
    binding: ProfileBindings(),
  ),
  GetPage(
    name: basicDetailsScreen,
    page: () => const BasicDetails(),
  ),
  GetPage(
    name: myProfileScreen,
    page: () => const MyProfile(),
  ),
  GetPage(
    name: bankAccountsScreen,
    page: () => const BankAccounts(),
    binding: BankAccountBindings(),
  ),
  GetPage(
    name: myAddressScreen,
    page: () => const MyAddress(),
    binding: MyAddressBindings(),
  ),
  GetPage(
    name: withdrawFundScreen,
    page: () => const WithdrawFund(),
    binding: WithdrawFundBindings(),
  ),
  GetPage(
    name: verifyWithdrawRequestScreen,
    page: () => const VerifyWithdrawRequest(),
    binding: VerifyWithdrawRequestBindings(),
  ),
  GetPage(
    name: transactionStatusScreen,
    page: () => const TransactionStatus(),
    binding: TransactionStatusBindings(),
  ),
  GetPage(
    name: testScreen,
    page: () => const Test(),
    binding: TestBindings(),
  ),
  GetPage(
    name: otpScreen,
    page: () => const Otp(),
    binding: OtpBindings(),
  ),
  GetPage(
    name: createInvestorScreen,
    page: () => const CreateInvestor(),
    binding: CreateInvestorBindings(),
  ),
  GetPage(
    name: addBankAccountScreen,
    page: () => const AddBankAccount(),
    binding: AddBankAccountBindings(),
  ),
  GetPage(
    name: addAddressScreen,
    page: () => const AddAddress(),
    binding: AddAddressBinding(),
  ),
  GetPage(
      name: signInAgreementScreen,
      page: () => const SignAgreement(),
      binding: SignAgreementBindings()),
  GetPage(
    name: paymentGatewayScreen,
    page: () => const MakePayment(),
    binding: MakePaymentBindings(),
  ),
  GetPage(
    name: depositFundsScreen,
    page: () => const DepositFunds(),
    binding: DepositFundsBindings(),
  ),
  GetPage(
    name: uploadPanScreen,
    page: () => const UploadPan(),
  ),
  GetPage(
    name: uploadBankDocumentScreen,
    page: () => const UploadBankDocument(),
    parameters: const {"doc_type": "Banking"},
    binding: UploadBankDocumentBinding(),
  ),
  GetPage(
    name: uploadPanDocumentScreen,
    page: () => const UploadPanDocument(),
    parameters: const {"doc_type": "Proof of Identity"},
    binding: UploadPanDocumentBinding(),
  ),
  GetPage(
    name: uploadAddressDocumentScreen,
    page: () => const UploadAddressDocument(),
    parameters: const {"doc_type": "Proof Of Address"},
    binding: UploadAddressDocumentBinding(),
  ),
  GetPage(
    name: transactionDetailScreen,
    page: () => const TransactionDetails(),
    binding: TransactionsDetailBindings(),
  ),
  GetPage(
    name: transactionDetailTwoScreen,
    page: () => TransactionDetailTwo(),
    binding: TransactionsDetailBindings(),
  ),
  GetPage(
      name: introScreen, page: () => const Intro(), binding: IntroBindings()),
  GetPage(
    name: webViewScreen,
    page: () => const MyWebView(),
    binding: MyWebViewBindings(),
  ),
  GetPage(
    name: webViewScreen,
    page: () => const MyWebView(),
    binding: MyWebViewBindings(),
  ),
  GetPage(
    name: portfolioTransactionScreen,
    page: () => const PortfolioTransaction(),
    binding: PortfolioTransactionBindings(),
  ),
  GetPage(
    name: portfolioTransactionDetailScreen,
    page: () => const PortfolioTransactionDetail(),
  ),
];

//Page route names
const String splashScreen = '/splash';
const String introScreen = '/intro';
const String loginScreen = '/login';
const String otpScreen = '/otp';
const String homeScreen = '/home';
const String selectFolioScreen = '/selectFolio';
const String dashboardScreen = '/dashboard';
const String transactionsScreen = '/transactions';
const String webViewScreen = '/webView';
const String createInvestorScreen = '/createInvestor';
const String transactionStatusScreen = '/transactionStatus';
const String depositFundsScreen = '/depositFunds';
const String chartScreen = '/chart';
const String profileScreen = '/profile';
const String basicDetailsScreen = '/basicDetails';
const String myProfileScreen = '/myProfile';
const String bankAccountsScreen = '/bankAccounts';
const String myAddressScreen = '/myAddress';
const String withdrawFundScreen = '/withdrawFund';
const String verifyWithdrawRequestScreen = '/verifyWithdrawRequest';
const String testScreen = '/test';
const String captureImageScreen = '/captureImage';
const String galleryScreen = '/gallery';
const String addBankAccountScreen = '/addBankAccount';
const String addAddressScreen = '/addAddress';
const String signInAgreementScreen = '/signAgreement';
const String paymentGatewayScreen = '/paymentGateway';
const String uploadPanScreen = '/uploadPan';
const String uploadBankDocumentScreen = '/uploadBankDocument';
const String uploadPanDocumentScreen = '/uploadPanDocument';
const String uploadAddressDocumentScreen = '/uploadAddressDocument';
const String transactionDetailScreen = '/transactionDetail';
const String transactionDetailTwoScreen = '/transactionDetailTwo';
const String portfolioTransactionScreen = '/portfolioTransaction';
const String portfolioTransactionDetailScreen = '/portfolioTransactionDetail';
