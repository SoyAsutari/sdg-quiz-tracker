import 'package:flutter/material.dart';
import 'create_edit_item_screen.dart';
import 'login_screen.dart';
import 'tracker_screen.dart'; 

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text("Logout", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Quizzes'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tracker'), // Renamed to Tracker
        ],
      ),

      body: _selectedIndex == 0 
          ? Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2341),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Total Quizzes", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text("4", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF46C2CB))),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Active Users", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text("12", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF7C4DFF))),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: const Color(0xFF1C2341),
                        child: ListTile(
                          leading: const Icon(Icons.question_answer, color: Color(0xFF46C2CB)),
                          title: Text("Quiz Title ${index + 1}"),
                          subtitle: const Text("Subtitle"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          // THIS IS THE NEW TRACKER SCREEN
          : const TrackerScreen(),

      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF7C4DFF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateEditItemScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}