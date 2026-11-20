import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  final int currentGoal;

  const GoalScreen({super.key, required this.currentGoal});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _goalController;

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController(text: widget.currentGoal.toString());
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, int.parse(_goalController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Goal')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Set your weekly quiz goal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              const Text('Choose how many quizzes you want to complete each week.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quizzes per week',
                  hintText: 'For example, 5',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  if (number == null) {
                    return 'Please enter a valid whole number.';
                  }
                  if (number < 1 || number > 50) {
                    return 'Enter a goal between 1 and 50.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveGoal,
                  child: const Text('Save Goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}