import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/resources/app_text_styles.dart';
import 'package:sco_v1/resources/components/account/Custom_inforamtion_container.dart';
import 'package:sco_v1/resources/components/custom_button.dart';
import 'package:sco_v1/resources/components/custom_dropdown.dart';
import 'package:sco_v1/resources/components/custom_simple_app_bar.dart';
import 'package:sco_v1/resources/components/user_info_container.dart';
import 'package:sco_v1/utils/constants.dart';
import 'package:sco_v1/viewModel/apply_scholarship/getAllActiveScholarshipsViewModel.dart';
import 'package:sco_v1/viewModel/drawer/a_brief_about_sco_viewModel.dart';
import '../../../data/response/status.dart';
import '../../../resources/app_colors.dart';
import '../../../utils/utils.dart';
import '../../../viewModel/language_change_ViewModel.dart';
import '../../../viewModel/services/navigation_services.dart';

class SelectScholarshipTypeView extends StatefulWidget {
  const SelectScholarshipTypeView({super.key});

  @override
  State<SelectScholarshipTypeView> createState() =>
      _SelectScholarshipTypeViewState();
}

class _SelectScholarshipTypeViewState extends State<SelectScholarshipTypeView>
    with MediaQueryMixin<SelectScholarshipTypeView> {
  late NavigationServices _navigationService;

  // Define focus nodes:
  final FocusNode _requestTypeFocusNode = FocusNode();
  final FocusNode _academicCareerFocusNode = FocusNode();

  // selected value:
  String _selectedAcademicCareer = '';

  // Academic career menuItemList
  List<GetAllActiveScholarshipsModel?>? academicCareerMenuItemList = [];

  // Preparing dropdown items
  List<DropdownMenuItem> populateAcademicCareer({
    required List<GetAllActiveScholarshipsModel?> menuItemsList,
    required LanguageChangeViewModel provider,
  }) {
    final textDirection = getTextDirection(provider);

    // Using a Set to keep track of already added values to avoid duplicates.

    return menuItemsList
        .toSet()
        .toList()
        .where((element) => element != null) // Ensures no null values
        .map((element) {
      return DropdownMenuItem(
        value: element!.configurationKey.toString(),
        child: Text(
          textDirection == TextDirection.ltr
              ? element.configurationNameEng.toString()
              : element.configurationName.toString(),
          style: const TextStyle(
            color: AppColors.scoButtonColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    final GetIt getIt = GetIt.instance;
    _navigationService = getIt.get<NavigationServices>();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      // fetching all active scholarships:
      final provider = Provider.of<GetAllActiveScholarshipsViewModel>(context,
          listen: false);
      await provider.getAllActiveScholarships(
          context: context,
          langProvider:
              Provider.of<LanguageChangeViewModel>(context, listen: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomSimpleAppBar(
        title:
            Text("Apply Scholarship", style: AppTextStyles.appBarTitleStyle()),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final langProvider = Provider.of<LanguageChangeViewModel>(context);
    dynamic textDirection = getTextDirection(langProvider);
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Consumer<GetAllActiveScholarshipsViewModel>(
        builder: (context, provider, _) {
          return provider.apiResponse.status == Status.LOADING ||
                  provider.apiResponse.data!.isEmpty
              ? Utils.cupertinoLoadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // submit application section:
                      CustomInformationContainer(
                          title: "Submit An Application",
                          leading: SvgPicture.asset("assets/scholarships.svg"),
                          expandedContent: Column(
                            children: [
                              kFormHeight,

                              // Heading
                              fieldHeading(
                                  title: "Request Type",
                                  important: false,
                                  langProvider: langProvider),

                              // Dropdown for Request Type
                              CustomDropdown(
                                textDirection: textDirection,
                                menuItemsList: populateNormalDropdownWithValue(
                                    menuItemsList:
                                        Constants.scholarshipRequestType,
                                    provider: langProvider),
                                currentFocusNode: _requestTypeFocusNode,
                                nextFocusNode: _academicCareerFocusNode,
                                hintText: "Request Type",
                                textColor: AppColors.scoButtonColor,
                                outlinedBorder: true,
                                onChanged: (value) {
                                  setState(() {
                                    // Reset academicCareerMenuItemList when Request Type changes

                                    // Filter the list of active scholarships based on the selected request type
                                    academicCareerMenuItemList = provider
                                        .apiResponse.data
                                        ?.where((element) =>
                                            element.scholarshipType
                                                    .toString() ==
                                                value.toString() &&
                                            element.isActive == true)
                                        .toSet()
                                        .toList();
                                  });
                                },
                              ),

                              kFormHeight,

                              // Heading
                              fieldHeading(
                                  title: "Academic Career",
                                  important: false,
                                  langProvider: langProvider),

                              // Dropdown for Academic Career
                              CustomDropdown(
                                textDirection: textDirection,
                                menuItemsList: populateAcademicCareer(
                                    menuItemsList: academicCareerMenuItemList ?? [],
                                    provider: langProvider),
                                currentFocusNode: _academicCareerFocusNode,
                                hintText: "Academic Career",
                                textColor: AppColors.scoButtonColor,
                                outlinedBorder: true,
                                onChanged: (value) {
                                  // Handle academic career selection
                                  setState(() {
                                    _selectedAcademicCareer = value;
                                  });
                                },
                              ),

                              kFormHeight,
                            ],
                          )),
                      kFormHeight,
                      // submit button section:
                      CustomButton(
                          buttonName: AppLocalizations.of(context)!.submit,
                          isLoading: false,
                          textDirection: textDirection,
                          buttonColor: AppColors.scoButtonColor,
                          onTap: () {}),
                    ],
                  ),
                );
        },
      ),
    );
  }
}