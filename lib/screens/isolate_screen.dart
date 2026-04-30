import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  String result = "";
  bool isLoading = false;

  // 🔥 isolate function (heavy task thật)
  static BigInt factorial(int n) {
    BigInt r = BigInt.one;

    for (int i = 1; i <= n; i++) {
      r *= BigInt.from(i);
    }

    return r;
  }

  Future<void> calculate() async {
    setState(() {
      isLoading = true;
      result = "";
    });

    // 🔥 task nặng hơn (giống yêu cầu bài)
    final res = await compute(factorial, 5000);

    if (!mounted) return;

    setState(() {
      isLoading = false;
      result = "Completed!\nDigits: ${res.toString().length}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Isolate Demo"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.memory, size: 70, color: Colors.redAccent),

              const SizedBox(height: 20),

              const Text(
                "Heavy Task with Isolate",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? const Column(
                        key: ValueKey("loading"),
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text("Processing in isolate..."),
                        ],
                      )
                    : result.isEmpty
                    ? const Text(
                        "Press Start to run heavy task",
                        key: ValueKey("empty"),
                      )
                    : Card(
                        key: const ValueKey("result"),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            result,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null : calculate,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Calculation"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
