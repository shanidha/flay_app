
class Validators {
  static final RegExp _emailRegex =
      RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _strongPassword =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');

  static String? email(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(v)) return 'Enter a valid email';
    return null;
  }
static String? requiredMin(
    String? v, {
    int min = 1,
    String label = 'Field',
  }) {
    if (v == null || v.trim().isEmpty) return '$label is required';
    if (v.trim().length < min) return 'At least $min characters';
    return null;
  }
  static String? strongPassword(String? value) {
    final v = (value ?? '');
    if (v.isEmpty) return 'Please enter a password';
    if (!_strongPassword.hasMatch(v)) {
      return 'Password must be ≥8 chars,\ninclude upper, lower, number & special char';
    }
    return null;
  }
   static bool isEmail(String value) {
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegex.hasMatch(value);
  }
   

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != original) return 'Password does not match';
    return null;
  }
}