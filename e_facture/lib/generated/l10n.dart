// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Total Users`
  String get adminTotalUsers {
    return Intl.message(
      'Total Users',
      name: 'adminTotalUsers',
      desc: '',
      args: [],
    );
  }

  /// `Total Invoices`
  String get adminTotalInvoices {
    return Intl.message(
      'Total Invoices',
      name: 'adminTotalInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Account of {company} deactivated`
  String adminAccountDeactivated(Object company) {
    return Intl.message(
      'Account of $company deactivated',
      name: 'adminAccountDeactivated',
      desc: '',
      args: [company],
    );
  }

  /// `Company Name:`
  String get adminCompanyNameLabel {
    return Intl.message(
      'Company Name:',
      name: 'adminCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Manage users and view all invoices.`
  String get adminDashboardDescription {
    return Intl.message(
      'Manage users and view all invoices.',
      name: 'adminDashboardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Admin Dashboard`
  String get adminDashboardTitle {
    return Intl.message(
      'Admin Dashboard',
      name: 'adminDashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get adminDeactivate {
    return Intl.message(
      'Deactivate',
      name: 'adminDeactivate',
      desc: '',
      args: [],
    );
  }

  /// `Downloading {invoice}...`
  String adminDownloading(Object invoice) {
    return Intl.message(
      'Downloading $invoice...',
      name: 'adminDownloading',
      desc: '',
      args: [invoice],
    );
  }

  /// `Email:`
  String get adminEmailLabel {
    return Intl.message('Email:', name: 'adminEmailLabel', desc: '', args: []);
  }

  /// `ICE:`
  String get adminIceLabel {
    return Intl.message('ICE:', name: 'adminIceLabel', desc: '', args: []);
  }

  /// `Invoices Management (Admin)`
  String get adminInvoicesManagement {
    return Intl.message(
      'Invoices Management (Admin)',
      name: 'adminInvoicesManagement',
      desc: '',
      args: [],
    );
  }

  /// `Invoices Submitted:`
  String get adminInvoicesSubmitted {
    return Intl.message(
      'Invoices Submitted:',
      name: 'adminInvoicesSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Manage Users`
  String get adminManageUsers {
    return Intl.message(
      'Manage Users',
      name: 'adminManageUsers',
      desc: '',
      args: [],
    );
  }

  /// `Search by Company Name`
  String get adminSearchByCompany {
    return Intl.message(
      'Search by Company Name',
      name: 'adminSearchByCompany',
      desc: '',
      args: [],
    );
  }

  /// `Users Management`
  String get adminUsersManagement {
    return Intl.message(
      'Users Management',
      name: 'adminUsersManagement',
      desc: '',
      args: [],
    );
  }

  /// `View Invoice`
  String get adminViewInvoice {
    return Intl.message(
      'View Invoice',
      name: 'adminViewInvoice',
      desc: '',
      args: [],
    );
  }

  /// `View All Invoices`
  String get adminViewInvoices {
    return Intl.message(
      'View All Invoices',
      name: 'adminViewInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get authChangePassword {
    return Intl.message(
      'Change password',
      name: 'authChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get authCompanyName {
    return Intl.message(
      'Company Name',
      name: 'authCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your new password`
  String get authConfirmNewPassword {
    return Intl.message(
      'Confirm your new password',
      name: 'authConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get authConfirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'authConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get authEmail {
    return Intl.message('Email', name: 'authEmail', desc: '', args: []);
  }

  /// `Email is already in use.`
  String get authEmailAlreadyInUse {
    return Intl.message(
      'Email is already in use.',
      name: 'authEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `An email has been sent to you to change your password.`
  String get authEmailPasswordReset {
    return Intl.message(
      'An email has been sent to you to change your password.',
      name: 'authEmailPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Enter your company name`
  String get authEnterCompanyName {
    return Intl.message(
      'Enter your company name',
      name: 'authEnterCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get authEnterEmail {
    return Intl.message(
      'Enter your email',
      name: 'authEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter ICE`
  String get authEnterIce {
    return Intl.message('Enter ICE', name: 'authEnterIce', desc: '', args: []);
  }

  /// `Enter your new password`
  String get authEnterNewPassword {
    return Intl.message(
      'Enter your new password',
      name: 'authEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your old password`
  String get authEnterOldPassword {
    return Intl.message(
      'Enter your old password',
      name: 'authEnterOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get authEnterPassword {
    return Intl.message(
      'Enter your password',
      name: 'authEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Login`
  String get authFirstLogin {
    return Intl.message(
      'First Login',
      name: 'authFirstLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get authForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'authForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email.`
  String get authInvalidEmail {
    return Intl.message(
      'Invalid email.',
      name: 'authInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get authLogin {
    return Intl.message('Log In', name: 'authLogin', desc: '', args: []);
  }

  /// `Log In`
  String get authLoginButton {
    return Intl.message('Log In', name: 'authLoginButton', desc: '', args: []);
  }

  /// `Already have an account? Log in.`
  String get authLoginMessage {
    return Intl.message(
      'Already have an account? Log in.',
      name: 'authLoginMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login Page`
  String get authLoginPageTitle {
    return Intl.message(
      'Login Page',
      name: 'authLoginPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login successful.`
  String get authLoginSuccessful {
    return Intl.message(
      'Login successful.',
      name: 'authLoginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get authLogoutButton {
    return Intl.message(
      'Log Out',
      name: 'authLogoutButton',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get authNewPassword {
    return Intl.message(
      'New password',
      name: 'authNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get authOldPassword {
    return Intl.message(
      'Old password',
      name: 'authOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPassword {
    return Intl.message('Password', name: 'authPassword', desc: '', args: []);
  }

  /// `Password changed successfully!`
  String get authPasswordChanged {
    return Intl.message(
      'Password changed successfully!',
      name: 'authPasswordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get authPasswordMismatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'authPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Password Strength`
  String get authPasswordStrength {
    return Intl.message(
      'Password Strength',
      name: 'authPasswordStrength',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign up now.`
  String get authRegisterMessage {
    return Intl.message(
      'Don\'t have an account? Sign up now.',
      name: 'authRegisterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful!`
  String get authRegistrationSuccessful {
    return Intl.message(
      'Registration successful!',
      name: 'authRegistrationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `The new password cannot be the same as the old one.`
  String get authSameOldAndNewPassword {
    return Intl.message(
      'The new password cannot be the same as the old one.',
      name: 'authSameOldAndNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send link`
  String get authSendLink {
    return Intl.message('Send link', name: 'authSendLink', desc: '', args: []);
  }

  /// `Sign up`
  String get authSignupButton {
    return Intl.message(
      'Sign up',
      name: 'authSignupButton',
      desc: '',
      args: [],
    );
  }

  /// `Registration Page`
  String get authSignupPageTitle {
    return Intl.message(
      'Registration Page',
      name: 'authSignupPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak. It must contain at least 8 characters, an uppercase letter, a lowercase letter, and a digit.`
  String get authWeakPassword {
    return Intl.message(
      'Password is too weak. It must contain at least 8 characters, an uppercase letter, a lowercase letter, and a digit.',
      name: 'authWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Token is missing. Please log in again.`
  String get authMissingToken {
    return Intl.message(
      'Token is missing. Please log in again.',
      name: 'authMissingToken',
      desc: '',
      args: [],
    );
  }

  /// `MAD`
  String get currencySymbol {
    return Intl.message('MAD', name: 'currencySymbol', desc: '', args: []);
  }

  /// `Create invoice`
  String get dashboardCreateInvoice {
    return Intl.message(
      'Create invoice',
      name: 'dashboardCreateInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Manage users`
  String get dashboardManageUsers {
    return Intl.message(
      'Manage users',
      name: 'dashboardManageUsers',
      desc: '',
      args: [],
    );
  }

  /// `View invoices`
  String get dashboardViewInvoices {
    return Intl.message(
      'View invoices',
      name: 'dashboardViewInvoices',
      desc: '',
      args: [],
    );
  }

  /// `View my invoices`
  String get dashboardViewMyInvoices {
    return Intl.message(
      'View my invoices',
      name: 'dashboardViewMyInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching invoices.`
  String get errorFetchingInvoices {
    return Intl.message(
      'Error fetching invoices.',
      name: 'errorFetchingInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String errorMessage(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'errorMessage',
      desc: '',
      args: [error],
    );
  }

  /// `This account has been disabled. Please contact the administrator.`
  String get errorsAccountDisabled {
    return Intl.message(
      'This account has been disabled. Please contact the administrator.',
      name: 'errorsAccountDisabled',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty.`
  String get errorsEmptyField {
    return Intl.message(
      'This field cannot be empty.',
      name: 'errorsEmptyField',
      desc: '',
      args: [],
    );
  }

  /// `Empty response from server.`
  String get errorsEmptyServerResponse {
    return Intl.message(
      'Empty response from server.',
      name: 'errorsEmptyServerResponse',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get errorsIncorrectCredentials {
    return Intl.message(
      'Incorrect email or password.',
      name: 'errorsIncorrectCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address.`
  String get errorsInvalidEmail {
    return Intl.message(
      'Invalid email address.',
      name: 'errorsInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `ICE must be numeric and between 8 to 15 digits.`
  String get errorsInvalidIce {
    return Intl.message(
      'ICE must be numeric and between 8 to 15 digits.',
      name: 'errorsInvalidIce',
      desc: '',
      args: [],
    );
  }

  /// `The provided password is not valid.`
  String get errorsInvalidPassword {
    return Intl.message(
      'The provided password is not valid.',
      name: 'errorsInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please check your credentials.`
  String get errorsLoginFailed {
    return Intl.message(
      'Login failed. Please check your credentials.',
      name: 'errorsLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `You need to change your password.`
  String get errorsPasswordChangeRequired {
    return Intl.message(
      'You need to change your password.',
      name: 'errorsPasswordChangeRequired',
      desc: '',
      args: [],
    );
  }

  /// `A new temporary password has been sent to your email address.`
  String get errorsPasswordResetSuccess {
    return Intl.message(
      'A new temporary password has been sent to your email address.',
      name: 'errorsPasswordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed.`
  String get errorsRegistrationFailed {
    return Intl.message(
      'Registration failed.',
      name: 'errorsRegistrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Server error during login.`
  String get errorsServerLoginError {
    return Intl.message(
      'Server error during login.',
      name: 'errorsServerLoginError',
      desc: '',
      args: [],
    );
  }

  /// `Error processing server response.`
  String get errorsServerResponseProcessing {
    return Intl.message(
      'Error processing server response.',
      name: 'errorsServerResponseProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Company name cannot exceed 100 characters.`
  String get errorsTooLongCompanyName {
    return Intl.message(
      'Company name cannot exceed 100 characters.',
      name: 'errorsTooLongCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Company name must contain at least 3 characters.`
  String get errorsTooShortCompanyName {
    return Intl.message(
      'Company name must contain at least 3 characters.',
      name: 'errorsTooShortCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Network connection issue.`
  String get errorsNetwork {
    return Intl.message(
      'Network connection issue.',
      name: 'errorsNetwork',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred.`
  String get errorsUnexpected {
    return Intl.message(
      'An unexpected error occurred.',
      name: 'errorsUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get generalAdd {
    return Intl.message('Add', name: 'generalAdd', desc: '', args: []);
  }

  /// `Amount`
  String get generalAmount {
    return Intl.message('Amount', name: 'generalAmount', desc: '', args: []);
  }

  /// `Cancel`
  String get generalCancel {
    return Intl.message('Cancel', name: 'generalCancel', desc: '', args: []);
  }

  /// `Company`
  String get generalCompany {
    return Intl.message('Company', name: 'generalCompany', desc: '', args: []);
  }

  /// `Date`
  String get generalDate {
    return Intl.message('Date', name: 'generalDate', desc: '', args: []);
  }

  /// `Dark Mode`
  String get generalDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'generalDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get generalDownload {
    return Intl.message(
      'Download',
      name: 'generalDownload',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get generalEmail {
    return Intl.message('Email', name: 'generalEmail', desc: '', args: []);
  }

  /// `File`
  String get generalFile {
    return Intl.message('File', name: 'generalFile', desc: '', args: []);
  }

  /// `Filter`
  String get generalFilter {
    return Intl.message('Filter', name: 'generalFilter', desc: '', args: []);
  }

  /// `ICE`
  String get generalIce {
    return Intl.message('ICE', name: 'generalIce', desc: '', args: []);
  }

  /// `Language`
  String get generalLanguage {
    return Intl.message(
      'Language',
      name: 'generalLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get generalLogout {
    return Intl.message('Logout', name: 'generalLogout', desc: '', args: []);
  }

  /// `Notifications`
  String get generalNotifications {
    return Intl.message(
      'Notifications',
      name: 'generalNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get generalPassword {
    return Intl.message(
      'Password',
      name: 'generalPassword',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get generalSearch {
    return Intl.message('Search', name: 'generalSearch', desc: '', args: []);
  }

  /// `Settings`
  String get generalSettings {
    return Intl.message(
      'Settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Social Reason`
  String get generalSocialReason {
    return Intl.message(
      'Social Reason',
      name: 'generalSocialReason',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get generalTotal {
    return Intl.message('Total', name: 'generalTotal', desc: '', args: []);
  }

  /// `Validate`
  String get generalValidate {
    return Intl.message(
      'Validate',
      name: 'generalValidate',
      desc: '',
      args: [],
    );
  }

  /// `e-Facture is an electronic invoice submission platform for SNRT suppliers.`
  String get homeDescription {
    return Intl.message(
      'e-Facture is an electronic invoice submission platform for SNRT suppliers.',
      name: 'homeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get homeHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'homeHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get homeLogin {
    return Intl.message('Log in', name: 'homeLogin', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get homeNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'homeNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get homeSignup {
    return Intl.message('Sign up', name: 'homeSignup', desc: '', args: []);
  }

  /// `E-Invoice`
  String get homeTitle {
    return Intl.message('E-Invoice', name: 'homeTitle', desc: '', args: []);
  }

  /// `Add the invoice`
  String get invoiceAddInvoice {
    return Intl.message(
      'Add the invoice',
      name: 'invoiceAddInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Add a PDF file`
  String get invoiceAddPdf {
    return Intl.message(
      'Add a PDF file',
      name: 'invoiceAddPdf',
      desc: '',
      args: [],
    );
  }

  /// `All amounts`
  String get invoiceAllAmounts {
    return Intl.message(
      'All amounts',
      name: 'invoiceAllAmounts',
      desc: '',
      args: [],
    );
  }

  /// `All dates`
  String get invoiceAllDates {
    return Intl.message(
      'All dates',
      name: 'invoiceAllDates',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get invoiceAmount {
    return Intl.message('Amount', name: 'invoiceAmount', desc: '', args: []);
  }

  /// `Amount`
  String get invoiceAmountFilter {
    return Intl.message(
      'Amount',
      name: 'invoiceAmountFilter',
      desc: '',
      args: [],
    );
  }

  /// `The amount must be greater than 5 million.`
  String get invoiceAmountRequirements {
    return Intl.message(
      'The amount must be greater than 5 million.',
      name: 'invoiceAmountRequirements',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Count`
  String get invoiceCount {
    return Intl.message(
      'Invoice Count',
      name: 'invoiceCount',
      desc: '',
      args: [],
    );
  }

  /// `Create an Invoice`
  String get invoiceCreateInvoiceTitle {
    return Intl.message(
      'Create an Invoice',
      name: 'invoiceCreateInvoiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get invoiceDate {
    return Intl.message('Date', name: 'invoiceDate', desc: '', args: []);
  }

  /// `Date`
  String get invoiceDateFilter {
    return Intl.message('Date', name: 'invoiceDateFilter', desc: '', args: []);
  }

  /// `Download`
  String get invoiceDownload {
    return Intl.message(
      'Download',
      name: 'invoiceDownload',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get invoiceFebruary {
    return Intl.message(
      'February',
      name: 'invoiceFebruary',
      desc: '',
      args: [],
    );
  }

  /// `The file must be a PDF and < 2 MB.`
  String get invoiceFileRequirements {
    return Intl.message(
      'The file must be a PDF and < 2 MB.',
      name: 'invoiceFileRequirements',
      desc: '',
      args: [],
    );
  }

  /// `Invoice History`
  String get invoiceHistory {
    return Intl.message(
      'Invoice History',
      name: 'invoiceHistory',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get invoiceID {
    return Intl.message('ID', name: 'invoiceID', desc: '', args: []);
  }

  /// `January`
  String get invoiceJanuary {
    return Intl.message('January', name: 'invoiceJanuary', desc: '', args: []);
  }

  /// `Less than €2000`
  String get invoiceLessThan2000 {
    return Intl.message(
      'Less than €2000',
      name: 'invoiceLessThan2000',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get invoiceMarch {
    return Intl.message('March', name: 'invoiceMarch', desc: '', args: []);
  }

  /// `More than €2000`
  String get invoiceMoreThan2000 {
    return Intl.message(
      'More than €2000',
      name: 'invoiceMoreThan2000',
      desc: '',
      args: [],
    );
  }

  /// `PDF file selected: {filename}`
  String invoicePdfSelected(Object filename) {
    return Intl.message(
      'PDF file selected: $filename',
      name: 'invoicePdfSelected',
      desc: '',
      args: [filename],
    );
  }

  /// `Search for an invoice...`
  String get invoiceSearchInvoice {
    return Intl.message(
      'Search for an invoice...',
      name: 'invoiceSearchInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get invoiceTotal {
    return Intl.message(
      'Total Amount',
      name: 'invoiceTotal',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get languagesArabic {
    return Intl.message('Arabic', name: 'languagesArabic', desc: '', args: []);
  }

  /// `English`
  String get languagesEnglish {
    return Intl.message(
      'English',
      name: 'languagesEnglish',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get languagesFrench {
    return Intl.message('French', name: 'languagesFrench', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `My Invoices`
  String get myInvoices {
    return Intl.message('My Invoices', name: 'myInvoices', desc: '', args: []);
  }

  /// `Back`
  String get navigationBack {
    return Intl.message('Back', name: 'navigationBack', desc: '', args: []);
  }

  /// `Admin Dashboard`
  String get navigationDashboardAdmin {
    return Intl.message(
      'Admin Dashboard',
      name: 'navigationDashboardAdmin',
      desc: '',
      args: [],
    );
  }

  /// `User Dashboard`
  String get navigationDashboardUser {
    return Intl.message(
      'User Dashboard',
      name: 'navigationDashboardUser',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navigationHome {
    return Intl.message('Home', name: 'navigationHome', desc: '', args: []);
  }

  /// `No invoices available.`
  String get noInvoicesAvailable {
    return Intl.message(
      'No invoices available.',
      name: 'noInvoicesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statisticsTitle {
    return Intl.message(
      'Statistics',
      name: 'statisticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `User Invoices`
  String get userInvoicesTitle {
    return Intl.message(
      'User Invoices',
      name: 'userInvoicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `e-Facture is an electronic invoice submission platform for SNRT suppliers.`
  String get welcomeDescription {
    return Intl.message(
      'e-Facture is an electronic invoice submission platform for SNRT suppliers.',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcomeTitle {
    return Intl.message('Welcome', name: 'welcomeTitle', desc: '', args: []);
  }

  /// `Invoice Activity`
  String get invoice_activity_title {
    return Intl.message(
      'Invoice Activity',
      name: 'invoice_activity_title',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 Days`
  String get last_seven_days {
    return Intl.message(
      'Last 7 Days',
      name: 'last_seven_days',
      desc: '',
      args: [],
    );
  }

  /// `Invoices by Month`
  String get monthly_invoice_title {
    return Intl.message(
      'Invoices by Month',
      name: 'monthly_invoice_title',
      desc: '',
      args: [],
    );
  }

  /// `{year}`
  String current_year_label(Object year) {
    return Intl.message(
      '$year',
      name: 'current_year_label',
      desc: '',
      args: [year],
    );
  }

  /// `Active vs Inactive Users`
  String get user_status_chart_title {
    return Intl.message(
      'Active vs Inactive Users',
      name: 'user_status_chart_title',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active_label {
    return Intl.message('Active', name: 'active_label', desc: '', args: []);
  }

  /// `Inactive`
  String get inactive_label {
    return Intl.message('Inactive', name: 'inactive_label', desc: '', args: []);
  }

  /// `Platform Adoption Rate`
  String get adoption_rate_title {
    return Intl.message(
      'Platform Adoption Rate',
      name: 'adoption_rate_title',
      desc: '',
      args: [],
    );
  }

  /// `No data to display.`
  String get no_data_message {
    return Intl.message(
      'No data to display.',
      name: 'no_data_message',
      desc: '',
      args: [],
    );
  }

  /// `Never returned after sign up`
  String get never_returned_label {
    return Intl.message(
      'Never returned after sign up',
      name: 'never_returned_label',
      desc: '',
      args: [],
    );
  }

  /// `Returned without creating an invoice`
  String get returned_without_invoice_label {
    return Intl.message(
      'Returned without creating an invoice',
      name: 'returned_without_invoice_label',
      desc: '',
      args: [],
    );
  }

  /// `Returned and created at least 1 invoice`
  String get returned_and_invoiced_label {
    return Intl.message(
      'Returned and created at least 1 invoice',
      name: 'returned_and_invoiced_label',
      desc: '',
      args: [],
    );
  }

  /// `All users are loaded.`
  String get allUsersLoaded {
    return Intl.message(
      'All users are loaded.',
      name: 'allUsersLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Search for a user...`
  String get searchUserPlaceholder {
    return Intl.message(
      'Search for a user...',
      name: 'searchUserPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Filter by status`
  String get filterByStatus {
    return Intl.message(
      'Filter by status',
      name: 'filterByStatus',
      desc: '',
      args: [],
    );
  }

  /// `All users`
  String get allUsers {
    return Intl.message('All users', name: 'allUsers', desc: '', args: []);
  }

  /// `Active users`
  String get activeUsers {
    return Intl.message(
      'Active users',
      name: 'activeUsers',
      desc: '',
      args: [],
    );
  }

  /// `Inactive users`
  String get inactiveUsers {
    return Intl.message(
      'Inactive users',
      name: 'inactiveUsers',
      desc: '',
      args: [],
    );
  }

  /// `Clear filter`
  String get clearFilter {
    return Intl.message(
      'Clear filter',
      name: 'clearFilter',
      desc: '',
      args: [],
    );
  }

  /// `Collapse all`
  String get collapseAll {
    return Intl.message(
      'Collapse all',
      name: 'collapseAll',
      desc: '',
      args: [],
    );
  }

  /// `Expand all`
  String get expandAll {
    return Intl.message('Expand all', name: 'expandAll', desc: '', args: []);
  }

  /// `No user found`
  String get noUserFound {
    return Intl.message(
      'No user found',
      name: 'noUserFound',
      desc: '',
      args: [],
    );
  }

  /// `Status: {status}`
  String statusLabel(Object status) {
    return Intl.message(
      'Status: $status',
      name: 'statusLabel',
      desc: '',
      args: [status],
    );
  }

  /// `Active`
  String get activeStatus {
    return Intl.message('Active', name: 'activeStatus', desc: '', args: []);
  }

  /// `Inactive`
  String get inactiveStatus {
    return Intl.message('Inactive', name: 'inactiveStatus', desc: '', args: []);
  }

  /// `ICE`
  String get iceLabel {
    return Intl.message('ICE', name: 'iceLabel', desc: '', args: []);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Invoices`
  String get invoicesLabel {
    return Intl.message('Invoices', name: 'invoicesLabel', desc: '', args: []);
  }

  /// `Total Amount`
  String get totalAmountLabel {
    return Intl.message(
      'Total Amount',
      name: 'totalAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate`
  String get deactivate {
    return Intl.message('Deactivate', name: 'deactivate', desc: '', args: []);
  }

  /// `Activate`
  String get activate {
    return Intl.message('Activate', name: 'activate', desc: '', args: []);
  }

  /// `View Invoices`
  String get viewInvoices {
    return Intl.message(
      'View Invoices',
      name: 'viewInvoices',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Active users`
  String get activeUsersStatus {
    return Intl.message(
      'Active users',
      name: 'activeUsersStatus',
      desc: '',
      args: [],
    );
  }

  /// `Inactive users`
  String get inactiveUsersStatus {
    return Intl.message(
      'Inactive users',
      name: 'inactiveUsersStatus',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `{count, plural, =0{No users found} =1{1 user found} other{{count} users found}}`
  String userCount(num count) {
    return Intl.plural(
      count,
      zero: 'No users found',
      one: '1 user found',
      other: '$count users found',
      name: 'userCount',
      desc: '',
      args: [count],
    );
  }

  /// `All Invoices`
  String get allInvoicesTitle {
    return Intl.message(
      'All Invoices',
      name: 'allInvoicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `All invoices are loaded.`
  String get allInvoicesLoaded {
    return Intl.message(
      'All invoices are loaded.',
      name: 'allInvoicesLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Clear filter`
  String get clearFilterTooltip {
    return Intl.message(
      'Clear filter',
      name: 'clearFilterTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Expand all`
  String get expandAllTooltip {
    return Intl.message(
      'Expand all',
      name: 'expandAllTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Collapse all`
  String get collapseAllTooltip {
    return Intl.message(
      'Collapse all',
      name: 'collapseAllTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Filter by date`
  String get filterByDate {
    return Intl.message(
      'Filter by date',
      name: 'filterByDate',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDateLabel {
    return Intl.message(
      'Start Date',
      name: 'startDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDateLabel {
    return Intl.message('End Date', name: 'endDateLabel', desc: '', args: []);
  }

  /// `Date:`
  String get dateRangeText {
    return Intl.message('Date:', name: 'dateRangeText', desc: '', args: []);
  }

  /// `Search:`
  String get searchQueryText {
    return Intl.message('Search:', name: 'searchQueryText', desc: '', args: []);
  }

  /// `{count} invoice(s) found`
  String invoiceCountResult(Object count) {
    return Intl.message(
      '$count invoice(s) found',
      name: 'invoiceCountResult',
      desc: '',
      args: [count],
    );
  }

  /// `Error: {error}`
  String invoiceError(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'invoiceError',
      desc: '',
      args: [error],
    );
  }

  /// `Search an invoice...`
  String get searchInvoiceHint {
    return Intl.message(
      'Search an invoice...',
      name: 'searchInvoiceHint',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get applyFilter {
    return Intl.message('Apply', name: 'applyFilter', desc: '', args: []);
  }

  /// `From: {date}`
  String fromDateLabel(Object date) {
    return Intl.message(
      'From: $date',
      name: 'fromDateLabel',
      desc: '',
      args: [date],
    );
  }

  /// `To: {date}`
  String toDateLabel(Object date) {
    return Intl.message(
      'To: $date',
      name: 'toDateLabel',
      desc: '',
      args: [date],
    );
  }

  /// `From {date}`
  String fromDateFilterDisplay(Object date) {
    return Intl.message(
      'From $date',
      name: 'fromDateFilterDisplay',
      desc: '',
      args: [date],
    );
  }

  /// `To {date}`
  String toDateFilterDisplay(Object date) {
    return Intl.message(
      'To $date',
      name: 'toDateFilterDisplay',
      desc: '',
      args: [date],
    );
  }

  /// `Search: "{query}"`
  String searchQueryDisplay(Object query) {
    return Intl.message(
      'Search: "$query"',
      name: 'searchQueryDisplay',
      desc: '',
      args: [query],
    );
  }

  /// `{count, plural, =0{No invoice found} =1{1 invoice found} other{{count} invoices found}}`
  String invoicesFoundCount(num count) {
    return Intl.plural(
      count,
      zero: 'No invoice found',
      one: '1 invoice found',
      other: '$count invoices found',
      name: 'invoicesFoundCount',
      desc: '',
      args: [count],
    );
  }

  /// `Error: {error}`
  String errorPrefix(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'errorPrefix',
      desc: '',
      args: [error],
    );
  }

  /// `No invoices found`
  String get noInvoicesFound {
    return Intl.message(
      'No invoices found',
      name: 'noInvoicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Active filter`
  String get activeFilter {
    return Intl.message(
      'Active filter',
      name: 'activeFilter',
      desc: '',
      args: [],
    );
  }

  /// `Show as list`
  String get showListView {
    return Intl.message(
      'Show as list',
      name: 'showListView',
      desc: '',
      args: [],
    );
  }

  /// `Show as grid`
  String get showGridView {
    return Intl.message(
      'Show as grid',
      name: 'showGridView',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get startDatePlaceholder {
    return Intl.message(
      'Start date',
      name: 'startDatePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get endDatePlaceholder {
    return Intl.message(
      'End date',
      name: 'endDatePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get errorsInvalidCredentials {
    return Intl.message(
      'Incorrect email or password.',
      name: 'errorsInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `This email address is already used.`
  String get errorsEmailAlreadyUsed {
    return Intl.message(
      'This email address is already used.',
      name: 'errorsEmailAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `This ICE is already used.`
  String get errorsIceAlreadyUsed {
    return Intl.message(
      'This ICE is already used.',
      name: 'errorsIceAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get errorsUserDisabled {
    return Intl.message(
      'This account has been disabled.',
      name: 'errorsUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `No account found with these details.`
  String get errorsAccountNotFound {
    return Intl.message(
      'No account found with these details.',
      name: 'errorsAccountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `A password reset email has been sent.`
  String get authPasswordResetSent {
    return Intl.message(
      'A password reset email has been sent.',
      name: 'authPasswordResetSent',
      desc: '',
      args: [],
    );
  }

  /// `Login successful.`
  String get loginSuccess {
    return Intl.message(
      'Login successful.',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful.`
  String get registrationSuccess {
    return Intl.message(
      'Registration successful.',
      name: 'registrationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required.`
  String get errorsMissingFields {
    return Intl.message(
      'All fields are required.',
      name: 'errorsMissingFields',
      desc: '',
      args: [],
    );
  }

  /// `Company name must be between 3 and 100 characters.`
  String get errorsInvalidLegalName {
    return Intl.message(
      'Company name must be between 3 and 100 characters.',
      name: 'errorsInvalidLegalName',
      desc: '',
      args: [],
    );
  }

  /// `This company name is already used.`
  String get errorsLegalNameAlreadyUsed {
    return Intl.message(
      'This company name is already used.',
      name: 'errorsLegalNameAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `An internal error occurred. Please try again later.`
  String get errorsInternal {
    return Intl.message(
      'An internal error occurred. Please try again later.',
      name: 'errorsInternal',
      desc: '',
      args: [],
    );
  }

  /// `A temporary password has been sent if the provided information is correct.`
  String get resetEmailSent {
    return Intl.message(
      'A temporary password has been sent if the provided information is correct.',
      name: 'resetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully.`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully.',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile retrieved successfully.`
  String get profileRetrieved {
    return Intl.message(
      'Profile retrieved successfully.',
      name: 'profileRetrieved',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak.`
  String get errorsWeakPassword {
    return Intl.message(
      'The password is too weak.',
      name: 'errorsWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The new password cannot be the same as the old one.`
  String get errorsSamePassword {
    return Intl.message(
      'The new password cannot be the same as the old one.',
      name: 'errorsSamePassword',
      desc: '',
      args: [],
    );
  }

  /// `The provided information is incorrect.`
  String get errorsInvalidUserInfo {
    return Intl.message(
      'The provided information is incorrect.',
      name: 'errorsInvalidUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Operation completed successfully`
  String get genericSuccess {
    return Intl.message(
      'Operation completed successfully',
      name: 'genericSuccess',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
