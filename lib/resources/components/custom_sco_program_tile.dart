import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sco_v1/utils/utils.dart';

import '../app_text_styles.dart';

class CustomScoProgramTile extends StatefulWidget {

  final TextDirection textDirection;
  final String imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;

  const CustomScoProgramTile({super.key,
    required this.textDirection,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap
  });

  @override
  State<CustomScoProgramTile> createState() => _CustomScoProgramTileState();
}

class _CustomScoProgramTileState extends State<CustomScoProgramTile> with MediaQueryMixin<CustomScoProgramTile> {
  @override
  Widget build(BuildContext context) {
    return   Directionality(
      textDirection: widget.textDirection,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex:4,child: _imageSection()),
                  Expanded(flex:10,child: _titleSection()),
                  Expanded(flex:1,child: _endSection())
                ],
              ),
            ),
          ),
        ),
      ),
    )
    ;
  }

  Widget _imageSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            widget.imagePath,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            // width: screenWidth / 4,
            // height: screenHeight / 11,
            errorBuilder: (BuildContext context, Object, StackTrace) {
              return Image.asset(
                "assets/sidemenu/scholarships_uae.jpg",
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
                // width: screenWidth / 4,
                // height: screenHeight / 11,
              );
            },
          ),
        ),
        Container(
            height: 17,
            width: 19,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 1.0,
                left: 1,
              ),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(
                      "assets/sidemenu/correct.svg",
                      width: 7,
                      height: 5,
                      fit: BoxFit.fill,
                    ),
                  )),
            ))
      ],
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 20),
      child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Title
          Text(
            widget.title.length < 30 ? widget.title : "${widget.title.substring(0, 30)}...",
            textAlign: TextAlign.left,
            style: AppTextStyles.titleTextStyle(),

          ),
          const SizedBox(height: 8,),
          Text(
            widget.subTitle.length < 50 ? widget.subTitle : "${widget.subTitle.substring(0, 50)}...",
            textAlign: TextAlign.left,
            style: AppTextStyles.subTitleTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _endSection() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/sidemenu/goForward.svg",
          width: 20,
          height: 20,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
