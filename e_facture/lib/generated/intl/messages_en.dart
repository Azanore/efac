// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(company) => "Account of ${company} deactivated";

  static String m1(invoice) => "Downloading ${invoice}...";

  static String m2(error) => "Error: ${error}";

  static String m3(filename) => "PDF file selected: ${filename}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAccountDeactivated": m0,
    "adminCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Company Name:",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "Manage users and view all invoices.",
    ),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Admin Dashboard",
    ),
    "adminDeactivate": MessageLookupByLibrary.simpleMessage("Deactivate"),
    "adminDownloading": m1,
    "adminEmailLabel": MessageLookupByLibrary.simpleMessage("Email:"),
    "adminIceLabel": MessageLookupByLibrary.simpleMessage("ICE:"),
    "adminInvoicesManagement": MessageLookupByLibrary.simpleMessage(
      "Invoices Management (Admin)",
    ),
    "adminInvoicesSubmitted": MessageLookupByLibrary.simpleMessage(
      "Invoices Submitted:",
    ),
    "adminManageUsers": MessageLookupByLibrary.simpleMessage("Manage Users"),
    "adminSearchByCompany": MessageLookupByLibrary.simpleMessage(
      "Search by Company Name",
    ),
    "adminUsersManagement": MessageLookupByLibrary.simpleMessage(
      "Users Management",
    ),
    "adminViewInvoice": MessageLookupByLibrary.simpleMessage("View Invoice"),
    "adminViewInvoices": MessageLookupByLibrary.simpleMessage(
      "View All Invoices",
    ),
    "authChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change password",
    ),
    "authCompanyName": MessageLookupByLibrary.simpleMessage("Company Name"),
    "authConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm your new password",
    ),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "authEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "Email is already in use.",
    ),
    "authEmailPasswordReset": MessageLookupByLibrary.simpleMessage(
      "An email has been sent to you to change your password.",
    ),
    "authEnterCompanyName": MessageLookupByLibrary.simpleMessage(
      "Enter your company name",
    ),
    "authEnterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "authEnterIce": MessageLookupByLibrary.simpleMessage("Enter ICE"),
    "authEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your new password",
    ),
    "authEnterOldPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your old password",
    ),
    "authEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "authFirstLogin": MessageLookupByLibrary.simpleMessage("First Login"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email."),
    "authLogin": MessageLookupByLibrary.simpleMessage("Log In"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Log In"),
    "authLoginMessage": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Log in.",
    ),
    "authLoginPageTitle": MessageLookupByLibrary.simpleMessage("Login Page"),
    "authLoginSuccessful": MessageLookupByLibrary.simpleMessage(
      "Login successful!",
    ),
    "authLogoutButton": MessageLookupByLibrary.simpleMessage("Log Out"),
    "authMissingToken": MessageLookupByLibrary.simpleMessage(
      "Token is missing. Please log in again.",
    ),
    "authNewPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "authOldPassword": MessageLookupByLibrary.simpleMessage("Old password"),
    "authPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "authPasswordChanged": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully!",
    ),
    "authPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match.",
    ),
    "authPasswordStrength": MessageLookupByLibrary.simpleMessage(
      "Password Strength",
    ),
    "authRegisterMessage": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Sign up now.",
    ),
    "authRegistrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Registration successful! A temporary password has been sent to your email.",
    ),
    "authSameOldAndNewPassword": MessageLookupByLibrary.simpleMessage(
      "The new password cannot be the same as the old one.",
    ),
    "authSendLink": MessageLookupByLibrary.simpleMessage("Send link"),
    "authSignupButton": MessageLookupByLibrary.simpleMessage("Sign up"),
    "authSignupPageTitle": MessageLookupByLibrary.simpleMessage(
      "Registration Page",
    ),
    "authWeakPassword": MessageLookupByLibrary.simpleMessage(
      "Password is too weak. It must contain at least 8 characters, an uppercase letter, a lowercase letter, and a digit.",
    ),
    "currencySymbol": MessageLookupByLibrary.simpleMessage("DH"),
    "dashboardCreateInvoice": MessageLookupByLibrary.simpleMessage(
      "Create invoice",
    ),
    "dashboardManageUsers": MessageLookupByLibrary.simpleMessage(
      "Manage users",
    ),
    "dashboardViewInvoices": MessageLookupByLibrary.simpleMessage(
      "View invoices",
    ),
    "dashboardViewMyInvoices": MessageLookupByLibrary.simpleMessage(
      "View my invoices",
    ),
    "errorFetchingInvoices": MessageLookupByLibrary.simpleMessage(
      "Error fetching invoices.",
    ),
    "errorMessage": m2,
    "errorsAccountDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled. Please contact the administrator.",
    ),
    "errorsEmptyField": MessageLookupByLibrary.simpleMessage(
      "This field cannot be empty.",
    ),
    "errorsEmptyServerResponse": MessageLookupByLibrary.simpleMessage(
      "Empty response from server.",
    ),
    "errorsIncorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "errorsInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email.",
    ),
    "errorsInvalidIce": MessageLookupByLibrary.simpleMessage(
      "ICE must be numeric and contain between 8 and 15 digits.",
    ),
    "errorsInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "The provided password is not valid.",
    ),
    "errorsLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Login failed. Please check your credentials.",
    ),
    "errorsNetwork": MessageLookupByLibrary.simpleMessage(
      "Network error, please try again.",
    ),
    "errorsPasswordChangeRequired": MessageLookupByLibrary.simpleMessage(
      "You need to change your password.",
    ),
    "errorsPasswordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "A new temporary password has been sent to your email address.",
    ),
    "errorsRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed.",
    ),
    "errorsServerLoginError": MessageLookupByLibrary.simpleMessage(
      "Server error during login.",
    ),
    "errorsServerResponseProcessing": MessageLookupByLibrary.simpleMessage(
      "Error processing server response.",
    ),
    "errorsTooLongCompanyName": MessageLookupByLibrary.simpleMessage(
      "Company name cannot exceed 100 characters.",
    ),
    "errorsTooShortCompanyName": MessageLookupByLibrary.simpleMessage(
      "Company name must contain at least 3 characters.",
    ),
    "errorsUnexpected": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again later.",
    ),
    "generalAdd": MessageLookupByLibrary.simpleMessage("Add"),
    "generalAmount": MessageLookupByLibrary.simpleMessage("Amount"),
    "generalCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "generalCompany": MessageLookupByLibrary.simpleMessage("Company"),
    "generalDarkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "generalDate": MessageLookupByLibrary.simpleMessage("Date"),
    "generalDownload": MessageLookupByLibrary.simpleMessage("Download"),
    "generalEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "generalFile": MessageLookupByLibrary.simpleMessage("File"),
    "generalFilter": MessageLookupByLibrary.simpleMessage("Filter"),
    "generalIce": MessageLookupByLibrary.simpleMessage("ICE"),
    "generalLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "generalLogout": MessageLookupByLibrary.simpleMessage("Logout"),
    "generalNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "generalPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "generalSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "generalSocialReason": MessageLookupByLibrary.simpleMessage(
      "Social Reason",
    ),
    "generalTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "generalValidate": MessageLookupByLibrary.simpleMessage("Validate"),
    "homeDescription": MessageLookupByLibrary.simpleMessage(
      "e-Facture is an electronic invoice submission platform for SNRT suppliers.",
    ),
    "homeHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "homeLogin": MessageLookupByLibrary.simpleMessage("Log in"),
    "homeNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "homeSignup": MessageLookupByLibrary.simpleMessage("Sign up"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("E-Invoice"),
    "invoiceAddInvoice": MessageLookupByLibrary.simpleMessage(
      "Add the invoice",
    ),
    "invoiceAddPdf": MessageLookupByLibrary.simpleMessage("Add a PDF file"),
    "invoiceAllAmounts": MessageLookupByLibrary.simpleMessage("All amounts"),
    "invoiceAllDates": MessageLookupByLibrary.simpleMessage("All dates"),
    "invoiceAmount": MessageLookupByLibrary.simpleMessage("Amount"),
    "invoiceAmountFilter": MessageLookupByLibrary.simpleMessage("Amount"),
    "invoiceAmountRequirements": MessageLookupByLibrary.simpleMessage(
      "The amount must be greater than 5 million.",
    ),
    "invoiceCount": MessageLookupByLibrary.simpleMessage("Invoice Count"),
    "invoiceCreateInvoiceTitle": MessageLookupByLibrary.simpleMessage(
      "Create an Invoice",
    ),
    "invoiceDate": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDateFilter": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDownload": MessageLookupByLibrary.simpleMessage("Download"),
    "invoiceFebruary": MessageLookupByLibrary.simpleMessage("February"),
    "invoiceFileRequirements": MessageLookupByLibrary.simpleMessage(
      "The file must be a PDF and < 2 MB.",
    ),
    "invoiceHistory": MessageLookupByLibrary.simpleMessage("Invoice History"),
    "invoiceID": MessageLookupByLibrary.simpleMessage("ID"),
    "invoiceJanuary": MessageLookupByLibrary.simpleMessage("January"),
    "invoiceLessThan2000": MessageLookupByLibrary.simpleMessage(
      "Less than €2000",
    ),
    "invoiceMarch": MessageLookupByLibrary.simpleMessage("March"),
    "invoiceMoreThan2000": MessageLookupByLibrary.simpleMessage(
      "More than €2000",
    ),
    "invoicePdfSelected": m3,
    "invoiceSearchInvoice": MessageLookupByLibrary.simpleMessage(
      "Search for an invoice...",
    ),
    "invoiceTotal": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "languagesArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languagesEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languagesFrench": MessageLookupByLibrary.simpleMessage("French"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "myInvoices": MessageLookupByLibrary.simpleMessage("My Invoices"),
    "navigationBack": MessageLookupByLibrary.simpleMessage("Back"),
    "navigationDashboardAdmin": MessageLookupByLibrary.simpleMessage(
      "Admin Dashboard",
    ),
    "navigationDashboardUser": MessageLookupByLibrary.simpleMessage(
      "User Dashboard",
    ),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Home"),
    "noInvoicesAvailable": MessageLookupByLibrary.simpleMessage(
      "No invoices available.",
    ),
    "statisticsTitle": MessageLookupByLibrary.simpleMessage("Statistics"),
    "userInvoicesTitle": MessageLookupByLibrary.simpleMessage("My Invoices"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "e-Facture is an electronic invoice submission platform for SNRT suppliers.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome"),
  };
}
