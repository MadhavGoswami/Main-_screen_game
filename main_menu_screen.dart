import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/wobbly_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BackGround2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ResponsiveScreen(
            squarishMainArea: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vibz Art & Entertainment', // Added text here
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Adjust styling as needed
                ),
                SizedBox(height: 10), // Added space between new text and "Rolling Panda" text
                Text(
                  'Rolling Panda',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20), // Add space between text and image
                Container(
                  width: MediaQuery.of(context).size.height * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/panda4.jpg', // Adjust the image path as per your project
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add space between image and buttons
                WobblyButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play');
                  },
                  child: const Text('Play'),
                ),
                SizedBox(height: 20), // Adding space between Play and Settings buttons
                WobblyButton(
                  onPressed: () => GoRouter.of(context).push('/settings'),
                  child: const Text('Settings'),
                ),
                SizedBox(height: 20), // Adding space between Settings and Leaderboard buttons
                WobblyButton(
                  onPressed: () => GoRouter.of(context).push('/leaderboard'),
                  child: const Text('Leaderboard'),
                ),
              ],
            ),
            rectangularMenuArea: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.audioOn,
                builder: (context, audioOn, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleAudioOn(),
                    icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
