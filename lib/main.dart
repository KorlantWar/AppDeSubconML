import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subtitulaje en Tiempo Real',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100),
              const SizedBox(height: 20),
              const Text(
                'BIENVENIDO USUARIO',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Inicia sesión para subtitular en tiempo real',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AudioCaptureScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AudioCaptureScreen extends StatefulWidget {
  const AudioCaptureScreen({super.key});

  @override
  State<AudioCaptureScreen> createState() => _AudioCaptureScreenState();
}

class _AudioCaptureScreenState extends State<AudioCaptureScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = 'Presiona el botón para empezar a hablar';

  double _fontSize = 18.0;
  bool _isFullScreen = false;
  bool _highContrast = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == "done" && _isListening) {
          _speech.stop();
          _startListening();
        }
      },
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult:
            (val) => setState(() {
              _recognizedText = val.recognizedWords;
            }),
        localeId: "es_PE",
        listenMode: stt.ListenMode.dictation,
      );
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _highContrast ? Colors.black : Colors.white;
    final textColor = _highContrast ? Colors.yellow : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:
          _isFullScreen
              ? null
              : AppBar(
                title: const Text('Captura de Audio'),
                backgroundColor: Colors.indigo,
              ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mic,
                size: 80,
                color: _highContrast ? Colors.yellow : Colors.indigo,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      _recognizedText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _fontSize,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isListening ? _stopListening : _startListening,
                    icon: Icon(_isListening ? Icons.stop : Icons.play_arrow),
                    label: Text(_isListening ? 'Detener' : 'Iniciar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _highContrast ? Colors.yellow : Colors.indigo,
                      foregroundColor:
                          _highContrast ? Colors.black : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _fontSize = _fontSize == 18.0 ? 24.0 : 18.0;
                      });
                    },
                    child: const Text('Tamaño Letra'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _highContrast = !_highContrast;
                      });
                    },
                    child: Text(_highContrast ? 'Modo Claro' : 'Modo Oscuro'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isFullScreen = !_isFullScreen;
                      });
                    },
                    child: Text(_isFullScreen ? 'Minimizar' : 'Maximizar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
