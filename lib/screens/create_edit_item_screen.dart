import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../theme/app_theme.dart';

class CreateEditItemScreen extends StatefulWidget {
  // if isEditing is true, we fill the form with dummy data
  final bool isEditing;

  const CreateEditItemScreen({super.key, this.isEditing = false});

  @override
  State<CreateEditItemScreen> createState() => _CreateEditItemScreenState();
}

class _CreateEditItemScreenState extends State<CreateEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  String? _selectedSdg;
  String _selectedDifficulty = 'Easy';

  // Dummy list for listview builder
  final List<Map<String, String>> _sdgList = [
    {'id': '1', 'title': 'No Poverty'},
    {'id': '2', 'title': 'Zero Hunger'},
    {'id': '3', 'title': 'Good Health & Well-Being'},
    {'id': '4', 'title': 'Quality Education'},
    {'id': '13', 'title': 'Climate Action'},
  ];

  @override
  void initState() {
    super.initState();
    // If editing populate the fields with existing data
    _titleController = TextEditingController(text: widget.isEditing ? 'Climate Action Quiz' : '');
    _descController = TextEditingController(text: widget.isEditing ? 'Test your knowledge on SDG 13' : '');
    if (widget.isEditing) _selectedSdg = '13';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

    void _saveItem() {
    if (_formKey.currentState!.validate() && _selectedSdg != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isEditing ? 'Item updated!' : 'Item created!')),
      );
      
      // THIS pops the screen and goes back to wherever they came from (Admin Dashboard)
      Navigator.pop(context); 
    } else if (_selectedSdg == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an SDG category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Quiz Item' : 'Create Quiz Item'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // container with boxdecoration
               Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2341), // Dark card color
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade800),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // title field
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Quiz Title'),
                      validator: Validators.title,
                    ),
                    const SizedBox(height: 16),

                    // description field
                    TextFormField(
                      controller: _descController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: Validators.description,
                    ),
                    const SizedBox(height: 16),

                    // diff dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedDifficulty,
                      decoration: const InputDecoration(labelText: 'Difficulty'),
                      items: ['Easy', 'Medium', 'Hard'].map((String val) {
                        return DropdownMenuItem(value: val, child: Text(val));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedDifficulty = val!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Select SDG Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),

              // listview builder
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sdgList.length,
                itemBuilder: (context, index) {
                  final sdg = _sdgList[index];
                  final isSelected = _selectedSdg == sdg['id'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () => setState(() => _selectedSdg = sdg['id']),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryBlue.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryBlue : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: isSelected ? AppTheme.primaryBlue : Colors.grey.shade300,
                              foregroundColor: Colors.white,
                              child: Text(sdg['id']!),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                sdg['title']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppTheme.primaryBlue : Colors.black87,
                                ),
                              ),
                            ),
                            if (isSelected) const Icon(Icons.check_circle, color: AppTheme.primaryBlue),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _saveItem,
                child: Text(widget.isEditing ? 'Update Item' : 'Create Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}