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

  static String m2(year) => "${year}";

  static String m3(error) => "Error: ${error}";

  static String m4(error) => "Error: ${error}";

  static String m5(date) => "From ${date}";

  static String m6(date) => "From: ${date}";

  static String m7(count) => "${count} invoice(s) found";

  static String m8(error) => "Error: ${error}";

  static String m9(filename) => "PDF file selected: ${filename}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'No invoice found', one: '1 invoice found', other: '${count} invoices found')}";

  static String m11(query) => "Search: \"${query}\"";

  static String m12(status) => "Status: ${status}";

  static String m13(date) => "To ${date}";

  static String m14(date) => "To: ${date}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'No users found', one: '1 user found', other: '${count} users found')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activate": MessageLookupByLibrary.simpleMessage("Activate"),
    "activeFilter": MessageLookupByLibrary.simpleMessage("Active filter"),
    "activeStatus": MessageLookupByLibrary.simpleMessage("Active"),
    "activeUsers": MessageLookupByLibrary.simpleMessage("Active users"),
    "activeUsersStatus": MessageLookupByLibrary.simpleMessage("Active users"),
    "active_label": MessageLookupByLibrary.simpleMessage("Active"),
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
    "adminTotalInvoices": MessageLookupByLibrary.simpleMessage(
      "Total Invoices",
    ),
    "adminTotalUsers": MessageLookupByLibrary.simpleMessage("Total Users"),
    "adminUsersManagement": MessageLookupByLibrary.simpleMessage(
      "Users Management",
    ),
    "adminViewInvoice": MessageLookupByLibrary.simpleMessage("View Invoice"),
    "adminViewInvoices": MessageLookupByLibrary.simpleMessage(
      "View All Invoices",
    ),
    "adoption_rate_title": MessageLookupByLibrary.simpleMessage(
      "Platform Adoption Rate",
    ),
    "allInvoicesLoaded": MessageLookupByLibrary.simpleMessage(
      "All invoices are loaded.",
    ),
    "allInvoicesTitle": MessageLookupByLibrary.simpleMessage("All Invoices"),
    "allUsers": MessageLookupByLibrary.simpleMessage("All users"),
    "allUsersLoaded": MessageLookupByLibrary.simpleMessage(
      "All users are loaded.",
    ),
    "applyFilter": MessageLookupByLibrary.simpleMessage("Apply"),
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
      "Login successful.",
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
    "authPasswordResetSent": MessageLookupByLibrary.simpleMessage(
      "A password reset email has been sent.",
    ),
    "authPasswordStrength": MessageLookupByLibrary.simpleMessage(
      "Password Strength",
    ),
    "authRegisterMessage": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Sign up now.",
    ),
    "authRegistrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Registration successful!",
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
    "clearFilter": MessageLookupByLibrary.simpleMessage("Clear filter"),
    "clearFilterTooltip": MessageLookupByLibrary.simpleMessage("Clear filter"),
    "collapseAll": MessageLookupByLibrary.simpleMessage("Collapse all"),
    "collapseAllTooltip": MessageLookupByLibrary.simpleMessage("Collapse all"),
    "currencySymbol": MessageLookupByLibrary.simpleMessage("MAD"),
    "current_year_label": m2,
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
    "dateRangeText": MessageLookupByLibrary.simpleMessage("Date:"),
    "deactivate": MessageLookupByLibrary.simpleMessage("Deactivate"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "endDateLabel": MessageLookupByLibrary.simpleMessage("End Date"),
    "endDatePlaceholder": MessageLookupByLibrary.simpleMessage("End date"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorFetchingInvoices": MessageLookupByLibrary.simpleMessage(
      "Error fetching invoices.",
    ),
    "errorMessage": m3,
    "errorPrefix": m4,
    "errorsAccountDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled. Please contact the administrator.",
    ),
    "errorsAccountNotFound": MessageLookupByLibrary.simpleMessage(
      "No account found with these details.",
    ),
    "errorsEmailAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "This email address is already used.",
    ),
    "errorsEmptyField": MessageLookupByLibrary.simpleMessage(
      "This field cannot be empty.",
    ),
    "errorsEmptyServerResponse": MessageLookupByLibrary.simpleMessage(
      "Empty response from server.",
    ),
    "errorsIceAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "This ICE is already used.",
    ),
    "errorsIncorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "errorsInternal": MessageLookupByLibrary.simpleMessage(
      "An internal error occurred. Please try again later.",
    ),
    "errorsInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "errorsInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Invalid email address.",
    ),
    "errorsInvalidIce": MessageLookupByLibrary.simpleMessage(
      "ICE must be numeric and between 8 to 15 digits.",
    ),
    "errorsInvalidLegalName": MessageLookupByLibrary.simpleMessage(
      "Company name must be between 3 and 100 characters.",
    ),
    "errorsInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "The provided password is not valid.",
    ),
    "errorsInvalidUserInfo": MessageLookupByLibrary.simpleMessage(
      "The provided information is incorrect.",
    ),
    "errorsLegalNameAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "This company name is already used.",
    ),
    "errorsLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Login failed. Please check your credentials.",
    ),
    "errorsMissingFields": MessageLookupByLibrary.simpleMessage(
      "All fields are required.",
    ),
    "errorsNetwork": MessageLookupByLibrary.simpleMessage(
      "Network connection issue.",
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
    "errorsSamePassword": MessageLookupByLibrary.simpleMessage(
      "The new password cannot be the same as the old one.",
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
      "An unexpected error occurred.",
    ),
    "errorsUserDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled.",
    ),
    "errorsWeakPassword": MessageLookupByLibrary.simpleMessage(
      "The password is too weak.",
    ),
    "expandAll": MessageLookupByLibrary.simpleMessage("Expand all"),
    "expandAllTooltip": MessageLookupByLibrary.simpleMessage("Expand all"),
    "filterByDate": MessageLookupByLibrary.simpleMessage("Filter by date"),
    "filterByStatus": MessageLookupByLibrary.simpleMessage("Filter by status"),
    "fromDateFilterDisplay": m5,
    "fromDateLabel": m6,
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
    "genericSuccess": MessageLookupByLibrary.simpleMessage(
      "Operation completed successfully",
    ),
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
    "iceLabel": MessageLookupByLibrary.simpleMessage("ICE"),
    "inactiveStatus": MessageLookupByLibrary.simpleMessage("Inactive"),
    "inactiveUsers": MessageLookupByLibrary.simpleMessage("Inactive users"),
    "inactiveUsersStatus": MessageLookupByLibrary.simpleMessage(
      "Inactive users",
    ),
    "inactive_label": MessageLookupByLibrary.simpleMessage("Inactive"),
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
    "invoiceCountResult": m7,
    "invoiceCreateInvoiceTitle": MessageLookupByLibrary.simpleMessage(
      "Create an Invoice",
    ),
    "invoiceDate": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDateFilter": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDownload": MessageLookupByLibrary.simpleMessage("Download"),
    "invoiceError": m8,
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
    "invoicePdfSelected": m9,
    "invoiceSearchInvoice": MessageLookupByLibrary.simpleMessage(
      "Search for an invoice...",
    ),
    "invoiceTotal": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "invoice_activity_title": MessageLookupByLibrary.simpleMessage(
      "Invoice Activity",
    ),
    "invoicesFoundCount": m10,
    "invoicesLabel": MessageLookupByLibrary.simpleMessage("Invoices"),
    "languagesArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languagesEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languagesFrench": MessageLookupByLibrary.simpleMessage("French"),
    "last_seven_days": MessageLookupByLibrary.simpleMessage("Last 7 Days"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login successful."),
    "monthly_invoice_title": MessageLookupByLibrary.simpleMessage(
      "Invoices by Month",
    ),
    "myInvoices": MessageLookupByLibrary.simpleMessage("My Invoices"),
    "navigationBack": MessageLookupByLibrary.simpleMessage("Back"),
    "navigationDashboardAdmin": MessageLookupByLibrary.simpleMessage(
      "Admin Dashboard",
    ),
    "navigationDashboardUser": MessageLookupByLibrary.simpleMessage(
      "User Dashboard",
    ),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Home"),
    "never_returned_label": MessageLookupByLibrary.simpleMessage(
      "Never returned after sign up",
    ),
    "noInvoicesAvailable": MessageLookupByLibrary.simpleMessage(
      "No invoices available.",
    ),
    "noInvoicesFound": MessageLookupByLibrary.simpleMessage(
      "No invoices found",
    ),
    "noUserFound": MessageLookupByLibrary.simpleMessage("No user found"),
    "no_data_message": MessageLookupByLibrary.simpleMessage(
      "No data to display.",
    ),
    "passwordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully.",
    ),
    "profileRetrieved": MessageLookupByLibrary.simpleMessage(
      "Profile retrieved successfully.",
    ),
    "registrationSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful.",
    ),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "A temporary password has been sent if the provided information is correct.",
    ),
    "returned_and_invoiced_label": MessageLookupByLibrary.simpleMessage(
      "Returned and created at least 1 invoice",
    ),
    "returned_without_invoice_label": MessageLookupByLibrary.simpleMessage(
      "Returned without creating an invoice",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchInvoiceHint": MessageLookupByLibrary.simpleMessage(
      "Search an invoice...",
    ),
    "searchQueryDisplay": m11,
    "searchQueryText": MessageLookupByLibrary.simpleMessage("Search:"),
    "searchUserPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Search for a user...",
    ),
    "showGridView": MessageLookupByLibrary.simpleMessage("Show as grid"),
    "showListView": MessageLookupByLibrary.simpleMessage("Show as list"),
    "startDateLabel": MessageLookupByLibrary.simpleMessage("Start Date"),
    "startDatePlaceholder": MessageLookupByLibrary.simpleMessage("Start date"),
    "statisticsTitle": MessageLookupByLibrary.simpleMessage("Statistics"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusLabel": m12,
    "toDateFilterDisplay": m13,
    "toDateLabel": m14,
    "totalAmountLabel": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "userCount": m15,
    "userInvoicesTitle": MessageLookupByLibrary.simpleMessage("User Invoices"),
    "user_status_chart_title": MessageLookupByLibrary.simpleMessage(
      "Active vs Inactive Users",
    ),
    "viewInvoices": MessageLookupByLibrary.simpleMessage("View Invoices"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "e-Facture is an electronic invoice submission platform for SNRT suppliers.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("Welcome"),
  };
}
