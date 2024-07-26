import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/view/authentication/forgot_password/confirmation_view.dart';
import 'package:sco_v1/viewModel/authentication/forgot_password_viewModel.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:sco_v1/viewModel/services/alert_services.dart';

import '../../../../resources/app_colors.dart';
import '../../../../viewModel/services/navigation_services.dart';
import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_text_field.dart';
import '../../../resources/validations_and_errorText.dart';

class AnswerSecurityQuestionView extends StatefulWidget {
  final String securityQuestion;
  final String securityAnswer;
  final String userId;

  const AnswerSecurityQuestionView(
      {super.key,
      required this.securityQuestion,
      required this.securityAnswer,
      required this.userId});

  @override
  State<AnswerSecurityQuestionView> createState() =>
      _AnswerSecurityQuestionViewState();
}

class _AnswerSecurityQuestionViewState extends State<AnswerSecurityQuestionView>
    with MediaQueryMixin<AnswerSecurityQuestionView> {
  late NavigationServices _navigationService;
  late AlertServices _alertServices;

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();

  String? _answerError;
  String? _userId;

  Future<void> _initializeData(
      {required LanguageChangeViewModel langProvider}) async {
    setState(() {
      _questionController.text = widget.securityQuestion;
      debugPrint(_questionController.text);
    });
  }

  @override
  void initState() {
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();
    _alertServices = getIt.get<AlertServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      _initializeData(
          langProvider:
              Provider.of<LanguageChangeViewModel>(context, listen: false));
    });

    super.initState();
    _answerError = null;
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _questionFocusNode.dispose();
    _answerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scoBgColor,
      appBar: CustomSimpleAppBar(
          title: SvgPicture.asset(
        "assets/sco_logo.svg",
        fit: BoxFit.fill,
        height: 35,
        width: 110,
      )),
      body: _buildUI(context: context),
    );
  }

  Widget _buildUI({required BuildContext context}) {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xfff8f8fa),
        ),
        SafeArea(
            child: Align(
          alignment: Alignment.topCenter,
          child: bgSecurityLogo(),
        )),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
            top: orientation == Orientation.portrait
                ? screenHeight / 3
                : screenHeight / 3,
          ),
          padding: EdgeInsets.only(
            left: orientation == Orientation.portrait
                ? screenWidth * 0.08
                : screenWidth / 100,
            right: orientation == Orientation.portrait
                ? screenWidth * 0.08
                : screenWidth / 100,
            top: orientation == Orientation.portrait
                ? screenWidth * 0.05
                : screenWidth / 100 * 5,
            bottom: orientation == Orientation.portrait
                ? screenWidth / 100 * 1
                : screenWidth / 100 * 1,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.elliptical(60, 60)),
          ),
          child: Column(
            children: [
              _title(),
              Expanded(
                  child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _initializeData(langProvider: langProvider),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: Colors.black,
                      ));
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        fieldHeading(
                          title: AppLocalizations.of(context)!.securityQuestion,
                          important: true,
                          langProvider: langProvider,
                        ),
                        _questionField(langProvider: langProvider),
                        const SizedBox(height: 20),
                        fieldHeading(
                          title: AppLocalizations.of(context)!.securityAnswer,
                          important: true,
                          langProvider: langProvider,
                        ),
                        _answerField(langProvider: langProvider),
                        const SizedBox(height: 10),
                        _forgotSecurityQuestion(),
                        const SizedBox(height: 35),
                        _submitButton(
                          langProvider: langProvider,
                        )
                      ],
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  //title:
  Widget _title() {
    return Text(
      "Answer Security Question",
      style: AppTextStyles.appBarTitleStyle(),
    );
  }

  //security question field:
  Widget _questionField({required LanguageChangeViewModel langProvider}) {
    return CustomTextField(
        textDirection: getTextDirection(langProvider),
        readOnly: true,
        currentFocusNode: _questionFocusNode,
        nextFocusNode: _answerFocusNode,
        controller: _questionController,
        obscureText: false,
        hintText: AppLocalizations.of(context)!.securityQuestion,
        textInputType: TextInputType.text,
        textCapitalization: true,
        isNumber: false,
        maxLines: 1,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.darkGrey)),
        onChanged: (value) {});
  }

  //security answer field:
  Widget _answerField({required LanguageChangeViewModel langProvider}) {
    return CustomTextField(
        textDirection: getTextDirection(langProvider),
        currentFocusNode: _answerFocusNode,
        controller: _answerController,
        obscureText: false,
        hintText: AppLocalizations.of(context)!.writeAnswer,
        textInputType: TextInputType.text,
        textCapitalization: true,
        isNumber: false,
        maxLines: 3,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.darkGrey)),
        errorText: _answerError,
        onChanged: (value) {
          // Validate only when user interacts with the field
          if (_answerFocusNode.hasFocus) {
            setState(() {
              _answerError = ErrorText.getSecurityAnswerError(
                  answer: value!, context: context);
            });
          }
        });
  }

  //Forgot Security Question:
  Widget _forgotSecurityQuestion() {
    return InkWell(
      onTap: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Forgot Security Question",
            style: TextStyle(
              color: AppColors.scoThemeColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// Security Answer submit field
  Widget _submitButton({required LanguageChangeViewModel langProvider}) {
    //Creating single Provider instance i.e. not putting in the top of the widget tree.
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(),
      child: Consumer<ForgotPasswordViewModel>(
        builder: (context, provider, _) {
          return CustomButton(
            textDirection: getTextDirection(langProvider),
            buttonName: "Reset Password",
            isLoading: false,
            onTap: () async {
              bool result = validateForm(langProvider: langProvider);

              if (result) {
                if (_answerController.text.trim() != widget.securityAnswer.trim()) {
                  _alertServices.toastMessage("Enter Correct Security Answer");
                } else {







                  _navigationService
                      .pushReplacementCupertino(CupertinoPageRoute(
                          builder: (context) => const ConfirmationView(
                                isVerified: true,
                              )));
                }
              }
            },
            fontSize: 16,
            buttonColor: AppColors.scoButtonColor,
            elevation: 1,
          );
        },
      ),
    );
  }

  //Extra validations for better user Experience:
  bool validateForm({required LanguageChangeViewModel langProvider}) {
    if (_questionController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.selectSecurityQuestion,
          context: context,
          provider: langProvider);
      return false;
    }
    if (_answerController.text.isEmpty) {
      _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.writeSecurityAnswer,
          context: context,
          provider: langProvider);
      return false;
    }

    return true;
  }
}
