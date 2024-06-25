import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/resources/components/user_info_container.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top bar:
              _topAppBar(),

              //personal Information:
              _personalInformation(),

              //general information:
              _generalInformation()
            ],
          ),
        ),
      ),
    );
  }

  //Top Bar:
  Widget _topAppBar() {
    return Container(
      color: Colors.transparent,
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 35,
                  width: 80,
                  child: Image.asset('assets/company_logo.png')),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/notification_bell.svg",
                    height: 20,
                    width: 20,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/search.svg",
                    height: 20,
                    width: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //personal Information:
  Widget _personalInformation() {
    return Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Static Text:
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: provider.appLocale == const Locale('en') ||
                            provider.appLocale == null
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Text(
                      AppLocalizations.of(context)!.personalInformation,
                      style: TextStyle(
                          color: Color(0xff8591A9),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      UserInfoContainer(
                       title:  AppLocalizations.of(context)!.userName,
                        displayTitle: "Abhay Kumar",
                        textDirection:
                            provider.appLocale == const Locale('en') ||
                                    provider.appLocale == null
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                      ),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                        title:                       AppLocalizations.of(context)!.location,

                        displayTitle: "Abhay Kumar",
                        textDirection:
                            provider.appLocale == const Locale('en') ||
                                    provider.appLocale == null
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                      ),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.contactNumber,

                          displayTitle: "Abhay Kumar"),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.emailId,

                          displayTitle: "Abhay Kumar"),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.password,

                          displayTitle: "Abhay Kumar"),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }

  Widget _generalInformation() {
    return Consumer<LanguageChangeViewModel>(builder: (context, provider, _) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Static Text:
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: provider.appLocale == const Locale('en') ||
                            provider.appLocale == null
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: Text(
                      AppLocalizations.of(context)!.generalInformation,

                      style: TextStyle(
                          color: Color(0xff8591A9),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.scholarship,

                          displayTitle: "Abhay Kumar"),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.country,

                          displayTitle: "Abhay Kumar"),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.state,

                          displayTitle: "Abhay Kumar"),
                      Divider(
                        color: Color(0xffDFDFDF),
                      ),
                      UserInfoContainer(
                          textDirection:
                              provider.appLocale == const Locale('en') ||
                                      provider.appLocale == null
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          title:                       AppLocalizations.of(context)!.address,
                          displayTitle: "Abhay Kumar"),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
