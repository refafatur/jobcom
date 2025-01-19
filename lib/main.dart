import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'app/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _dropAnimation;
  bool _showLogo = true;
  Timer? _glitchTimer;
  double _glitchOffsetX = 0;
  bool _showGlitch = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _dropAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: -200, end: 0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 100,
      ),
    ]).animate(_controller);

    _controller.forward();

    // Tampilkan logo selama 2 detik
    Timer(Duration(seconds: 2), () {
      setState(() {
        _showLogo = false;
      });
      // Mulai efek glitch
      _startGlitchEffect();
      // Reset dan mulai animasi lagi untuk tampilan kedua
      _controller.reset();
      _controller.forward();
    });

    // Navigasi ke login setelah total 4 detik
    Timer(Duration(seconds: 4), () {
      _glitchTimer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  void _startGlitchEffect() {
    // Hanya menjalankan efek glitch selama 500ms
    _glitchTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _showGlitch = !_showGlitch;
        _glitchOffsetX = (_showGlitch ? 5 : -5) * (math.Random().nextDouble());
      });
    });
    
    // Menghentikan efek glitch setelah 500ms
    Timer(Duration(milliseconds: 500), () {
      _glitchTimer?.cancel();
      setState(() {
        _showGlitch = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _glitchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: _showLogo 
              ? _buildLogoScreen()
              : _buildTextScreen(),
        ),
      ),
    );
  }

  Widget _buildLogoScreen() {
    return AnimatedBuilder(
      animation: _dropAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _dropAnimation.value),
          child: ScaleTransition(
            scale: _animation,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.send,
                size: 100,
                color: Colors.blue,
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildTextScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.5),
                end: Offset.zero,
              ).animate(_animation),
              child: Text(
                'JobCom',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  letterSpacing: 2,
                ),
              ),
            ),
            if (_showGlitch)
              Positioned(
                left: _glitchOffsetX,
                child: Text(
                  'JobCom',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.withOpacity(0.7),
                    letterSpacing: 2,
                  ),
                ),
              ),
            if (_showGlitch)
              Positioned(
                right: _glitchOffsetX,
                child: Text(
                  'JobCom',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7),
                    letterSpacing: 2,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
        FadeTransition(
          opacity: _animation,
          child: Text(
            'Temukan Pekerjaan Freelance Terbaik',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[600],
            ),
          ),
        ),
      ],
    );
  }
}
