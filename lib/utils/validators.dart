class Validators {
  // Email validation
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email (e.g., you@example.com)';
    }
    return null;
  }

  // Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Za-z]')) || !value.contains(RegExp(r'\d'))) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  // Full name validation
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // Confirm password
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Generic required field (for Create/Edit item)
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Item title
  static String? title(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quiz title is required';
    }
    if (value.trim().length < 5) {
      return 'Title must be at least 5 characters';
    }
    return null;
  }

  // Item description
  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }
}