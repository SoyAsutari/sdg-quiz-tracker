import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'tracker_screen.dart'; // Import the Tracker Screen

class QuizzCategoryScreen extends StatefulWidget {
  const QuizzCategoryScreen({super.key});

  @override
  State<QuizzCategoryScreen> createState() => _QuizzCategoryScreenState();
}

class _QuizzCategoryScreenState extends State<QuizzCategoryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Select a Quiz" : "My Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quizzes'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'My Tracker'),
        ],
      ),

      // --- BODY SWITCHER ---
      body: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ), 
                itemCount: 4,
                itemBuilder: (context, index){
                  return Card(
                    color: const Color(0xFF1C2341),
                    child: GestureDetector(
                      onTap: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Starting Quiz ${index + 1}...")),
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.question_answer, size: 40, color: Color(0xFF46C2CB)),
                          SizedBox(height: 12),
                          Text("Quiz Title", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("Quiz Subtitle", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  );
                }
              ),
            )
          : const TrackerScreen(), // Loads the Tracker when the 2nd tab is tapped
    );
  }
}