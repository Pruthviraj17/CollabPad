import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vpn_apk/core/constants/text_styles.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/view/components/custom_text_widget.dart';
import 'package:vpn_apk/features/home/model/user.dart';

class RoomMembersList extends StatelessWidget {
  const RoomMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    List<RoomUser> _dummyUsers = [
      RoomUser(name: 'Alice'),
      RoomUser(name: 'Bob'),
      RoomUser(name: 'Charlie'),
      RoomUser(name: 'Diana'),
      RoomUser(name: 'Eve'),
      RoomUser(name: 'Frank'),
      RoomUser(name: 'Grace'),
      RoomUser(name: 'Hank'),
      RoomUser(name: 'Ivy'),
      RoomUser(name: 'Jack'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const CustomTextWidget(
            text: "CollabPAD",
            color: Pallate.lightPurpleColor,
            fontSize: FontSize.semiLarge,
            fontFamily: "Montserrat Bold",
            fontWeight: FontWeights.hardBoldWeight,
          ),
          const SizedBox(
            height: 30,
          ),
          const CustomTextWidget(
            text: "ROOM MEMBERS",
            color: Pallate.whiteColor,
            fontSize: FontSize.medium,
            fontFamily: "Montserrat Bold",
            fontWeight: FontWeights.boldWeight,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _dummyUsers.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final roomUser = _dummyUsers[index];
                return Tooltip(
                  message: roomUser.name,
                  child: Container(
                    height: 60,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Pallate.textFillColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CustomTextWidget(
                              text: roomUser.name ?? "",
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: FontSize.semiMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            color: Pallate.textFadeColor,
            thickness: 0.5,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextWidget(
            text: "Total Room Member: ${_dummyUsers.length}",
            color: Pallate.textFadeColor,
            fontSize: FontSize.semiMedium,
          ),
        ],
      ),
    );
  }
}
