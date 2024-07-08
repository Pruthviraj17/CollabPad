import 'package:flutter/material.dart';
import 'package:vpn_apk/core/theme/app_pallate.dart';
import 'package:vpn_apk/core/view/widgets/bg_gradient.dart';
import 'package:vpn_apk/core/view/widgets/frosted_glass_widget.dart';
import 'package:vpn_apk/features/home/view/widgets/edit_pad.dart';
import 'package:vpn_apk/features/home/view/widgets/room_members_list.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgGradientWidget(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Flexible(
                flex: 2,
                child: FrostedGlassWidget(
                  child: RoomMembersList(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Flexible(
                flex: 8,
                child: Stack(
                  children: [
                    const FrostedGlassWidget(
                      child: EditPad(),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings_outlined,
                          size: 40,
                          color: Pallate.textFadeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
