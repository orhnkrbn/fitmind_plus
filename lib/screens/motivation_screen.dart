import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> _playMotivation() async {
    if (!isPlaying) {
      await _audioPlayer.play(AssetSource('assets/sounds/motivation.mp3'));
      setState(() => isPlaying = true);
    } else {
      await _audioPlayer.stop();
      setState(() => isPlaying = false);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Motivasyonunu Yükselt!",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: const [
                        MotivationCard(
                            text:
                                "Günde sadece 10 dakika zihnini odaklamak büyük fark yaratır."),
                        MotivationCard(
                            text:
                                "Küçük başarılarını kutla; motivasyon zincirini kırma."),
                        MotivationCard(
                            text:
                                "Olumsuz düşünceleri fark et ve yerine pozitifleri koy."),
                        MotivationCard(
                            text:
                                "Her antrenman, sadece bedenini değil zihnini de güçlendirir."),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _playMotivation,
                    icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                    label: Text(isPlaying ? "Durdur" : "Çal"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MotivationCard extends StatelessWidget {
  final String text;
  const MotivationCard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _color1 = ColorTween(begin: Colors.deepPurple, end: Colors.blueAccent)
        .animate(_controller);
    _color2 = ColorTween(begin: Colors.purpleAccent, end: Colors.orangeAccent)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_color1.value!, _color2.value!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
