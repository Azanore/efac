class AppRoutes {
  // Auth routes
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const changePassword = '/change-password';

  // Dashboard routes
  static const userDashboard = '/dashboard/user';
  static const adminDashboard = '/dashboard/admin';

  // Settings
  static const settings = '/settings';
  static const profile = '/profile';

  // Prevent instantiation
  AppRoutes._();
}
