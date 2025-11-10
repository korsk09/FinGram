import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'second_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _income = '';

  @override
  void initState() {
    super.initState();
    _loadIncome();
  }

  // Загружаем данные из SharedPreferences
  Future<void> _loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _income = prefs.getString('userIncome') ?? 'Данные пока не введены';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FinGram'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                  onPressed: () async {
                    // Открываем экран ввода доходов
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailsScreen(),
                      ),
                    );
                    // После возвращения с экрана обновляем данные
                    _loadIncome();
                  },
                  child: const Text(
                    'Доходы',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondDetailsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Расходы',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                
              ],
            ),
            
            const SizedBox(height: 20),
            // Здесь выводим данные, введённые пользователем
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _income,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
