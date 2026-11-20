import 'package:flutter/material.dart';
import 'create_edit_item_screen.dart'; 
import '../utils/validators.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    //  form validation
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate network delay (since no database yet)
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() => _isLoading = false);

        // navigation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful! (No DB yet)')),
        );
              Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() => _isLoading = false);

        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CreateEditItemScreen()),
        );
      });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- HEADER (Styled Text) ---
              Icon(
                Icons.track_changes,
                size: 64,
                color: AppTheme.primaryBlue,
              ),
              const SizedBox(height: 16),
              Text(
                'SDG Quiz Tracker',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue your journey',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // form container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'you@example.com',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 20),

                      // password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleLogin(),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: Validators.password,
                      ),
                      
                      // forgot password expended
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // login button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
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