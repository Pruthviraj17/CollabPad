import 'package:collabpad/core/providers/room_model_notifier.dart';
import 'package:collabpad/core/theme/app_pallate.dart';
import 'package:collabpad/core/utils/show_custom_snackbar.dart';
import 'package:collabpad/core/view/widgets/bg_gradient.dart';
import 'package:collabpad/core/view/widgets/frosted_glass_widget.dart';
import 'package:collabpad/features/auth/repositories/auth_remote_repository.dart';
import 'package:collabpad/features/home/view/widgets/edit_pad.dart';
import 'package:collabpad/features/home/view/widgets/room_members_list.dart';
import 'package:collabpad/features/home/view/widgets/settings_popup.dart';
import 'package:collabpad/features/home/viewmodel/toggle_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();

    listenAfterJoin();
  }

  Future<void> listenAfterJoin() async {
    // add when new user joins the room
    ref.read(authRemoteRepositoryProvider).afterJoinStream.listen(
      (newUser) {
        String username =
            ref.read(roomModelNotifierProvider.notifier).addNewUser(newUser);
        showSnackBar(context: context, content: "$username joined the room");
      },
    );
    ref.read(authRemoteRepositoryProvider).afterDisconnectStream.listen(
      (id) {
        String username =
            ref.read(roomModelNotifierProvider.notifier).removeActiveUser(id);

        showSnackBar(context: context, content: "$username left the room");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSettingsOpened = ref.watch(isSettingsOpenedProvider);
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
                        onPressed: () {
                          ref.read(isSettingsOpenedProvider.notifier).state =
                              !(ref
                                  .read(isSettingsOpenedProvider.notifier)
                                  .state);
                        },
                        icon: const Icon(
                          Icons.settings_outlined,
                          size: 40,
                          color: Pallate.textFadeColor,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSettingsOpened,
                      child: const Positioned(
                        right: 80,
                        top: 10,
                        child: SettingsPopup(),
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
