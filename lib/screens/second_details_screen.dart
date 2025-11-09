import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondDetailsScreen extends StatefulWidget {
  const SecondDetailsScreen({super.key});

  @override
  State<SecondDetailsScreen> createState() => _SecondDetailsScreenState();
}

class _SecondDetailsScreenState extends State<SecondDetailsScreen> {
  final TextEditingController _controller = TextEditingController();

  // Сохраняем данные в SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userIncome', _controller.text);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Загружаем данные, если они были
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedText = prefs.getString('userIncome');
    if (savedText != null) {
      _controller.text = savedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расходы')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 13, 13, 13)),
              maxLines: 10,
              minLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите расходы...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Данные сохранены!')),
                );
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}

