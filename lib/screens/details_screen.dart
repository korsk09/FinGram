import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText; // переменная для текста ошибки

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

  void _validateInput(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = 'Поле не может быть пустым';
      } else if (value.length < 3) {
        _errorText = 'Минимум 3 символа';
      } else {
        _errorText = null; // всё ок
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Доходы')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Введите доходы",
                fillColor: Colors.black12,
                filled: true,
                errorText: _errorText, 
              ),
              onChanged: _validateInput,
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
