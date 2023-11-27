import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';

class PatientChatProfile extends StatefulWidget {
  String name, surname, address, img, contact;

  PatientChatProfile({
    Key? key,
    required this.name,
    required this.surname,
    required this.address,
    required this.img,
    required this.contact,
  }) : super(key: key);

  @override
  State<PatientChatProfile> createState() => _PatientChatProfileState();
}

class _PatientChatProfileState extends State<PatientChatProfile> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customView.callButton(context, text.call.tr, () {
              UrlLauncher.launchUrl(Uri.parse('tel:${widget.contact}'));
            },
                MyColor.primary,
                const TextStyle(
                  color: MyColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                Icons.call),
            customView.callButton(context, "Video Call", () {
              // Get.back();
            },
                MyColor.primary,
                const TextStyle(
                  color: MyColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                Icons.video_call)
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: customView.text(
            "@${widget.name}", 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColor.black,
            size: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                imagePopUp(context, widget.img);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/images/dummyprofile.png",
                          width: 90, height: 90, fit: BoxFit.cover),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/loading.gif",
                  image: widget.img,
                  placeholderFit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.center,
                child: customView.text("${widget.name} ${widget.surname}", 18,
                    FontWeight.w500, MyColor.black)),
            const SizedBox(
              height: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 19,
                  color: MyColor.primary1,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: customView.text(
                        widget.address, 12, FontWeight.normal, MyColor.grey),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void imagePopUp(BuildContext context, String image) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InteractiveViewer(
                      panEnabled: false,
                      // Set it to false
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return const Image(
                                image: AssetImage(
                                    "assets/images/noimage.png"));
                          },
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                          image: image,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
