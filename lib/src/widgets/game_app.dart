import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetris_game/src/config.dart';
import 'package:tetris_game/src/tetris_game.dart';
import 'package:tetris_game/src/widgets/overlay_screen.dart';
import 'package:tetris_game/src/widgets/score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final TetrisGame game;

  @override
  void initState() {
    super.initState();
    game = TetrisGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.pressStart2pTextTheme().apply(
              bodyColor: const Color(0xff184e77),
              displayColor: const Color(0xff184e77))),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ])),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) =>
                                  const OverlayScreen(
                                      title: "TAP TO PLAY",
                                      subtitle: "Use arrow keys or swipe"),
                              PlayState.gameOver.name: (context, game) =>
                                  const OverlayScreen(
                                      title: "GAME OVER",
                                      subtitle: "Tap to play again"),
                              PlayState.won.name: (context, game) =>
                                  const OverlayScreen(
                                      title: "YOU WON",
                                      subtitle: "Tap to play again")
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
