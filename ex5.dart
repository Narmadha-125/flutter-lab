import 'package:flutter/material.dart';

void main() {
  runApp(const MagicMoodApp());
}

class MagicMoodApp extends StatelessWidget {
  const MagicMoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MoodHome(),
    );
  }
}

class MoodHome extends StatelessWidget {
  const MoodHome({super.key});

  // 1. The Colorful Alert Dialog
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.deepPurple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text("Reset Your Vibe?", 
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
        content: const Text("This will clear your daily progress. Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Wait, No!", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: StadiumBorder(),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Yes, Reset"),
          ),
        ],
      ),
    );
  }

  // 2. The Colorful SnackBar
  void _showMoodSnack(BuildContext context, String mood, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Mood set to $mood! ✨", 
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Magic Mood", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("How are you feeling today?", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            const SizedBox(height: 40),
            
            // Mood Buttons
            _moodButton(context, "Feeling Awesome", Colors.orangeAccent, "🔥"),
            _moodButton(context, "Feeling Chill", Colors.lightBlueAccent, "🌊"),
            _moodButton(context, "Feeling Productive", Colors.greenAccent, "🚀"),
            
            const SizedBox(height: 50),
            
            // Reset Action (Triggers Alert)
            OutlinedButton.icon(
              onPressed: () => _showResetDialog(context),
              icon: const Icon(Icons.refresh, color: Colors.red),
              label: const Text("Reset Data", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to keep the code clean
  Widget _moodButton(BuildContext context, String label, Color color, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.black87,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () => _showMoodSnack(context, label, color),
          child: Text("$emoji $label", style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}