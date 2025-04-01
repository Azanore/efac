// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(company) => "تم إلغاء تنشيط حساب ${company}";

  static String m1(invoice) => "جاري تنزيل ${invoice}...";

  static String m2(year) => "${year}";

  static String m3(error) => "خطأ: ${error}";

  static String m4(error) => "خطأ: ${error}";

  static String m5(date) => "من ${date}";

  static String m6(date) => "من: ${date}";

  static String m7(count) => "تم العثور على ${count} فاتورة";

  static String m8(error) => "خطأ: ${error}";

  static String m9(filename) => "تم اختيار ملف PDF: ${filename}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'لم يتم العثور على أي فاتورة', one: 'تم العثور على فاتورة واحدة', few: 'تم العثور على ${count} فواتير', many: 'تم العثور على ${count} فاتورة', other: 'تم العثور على ${count} فاتورة')}";

  static String m11(query) => "بحث: \"${query}\"";

  static String m12(status) => "الحالة: ${status}";

  static String m13(date) => "إلى ${date}";

  static String m14(date) => "إلى: ${date}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'لم يتم العثور على مستخدمين', one: 'تم العثور على مستخدم واحد', other: 'تم العثور على ${count} مستخدمين')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activate": MessageLookupByLibrary.simpleMessage("تفعيل"),
    "activeFilter": MessageLookupByLibrary.simpleMessage("تصفية نشطة"),
    "activeStatus": MessageLookupByLibrary.simpleMessage("نشط"),
    "activeUsers": MessageLookupByLibrary.simpleMessage("المستخدمين النشطين"),
    "activeUsersStatus": MessageLookupByLibrary.simpleMessage("مستخدمون نشطون"),
    "active_label": MessageLookupByLibrary.simpleMessage("نشط"),
    "adminAccountDeactivated": m0,
    "adminCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "السبب الاجتماعي:",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "إدارة المستخدمين وعرض جميع الفواتير.",
    ),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "لوحة تحكم المدير",
    ),
    "adminDeactivate": MessageLookupByLibrary.simpleMessage("إلغاء التنشيط"),
    "adminDownloading": m1,
    "adminEmailLabel": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني:",
    ),
    "adminIceLabel": MessageLookupByLibrary.simpleMessage(
      "المعرّف الموحد للمقاولة:",
    ),
    "adminInvoicesManagement": MessageLookupByLibrary.simpleMessage(
      "إدارة الفواتير (المسؤول)",
    ),
    "adminInvoicesSubmitted": MessageLookupByLibrary.simpleMessage(
      "الفواتير المودعة:",
    ),
    "adminManageUsers": MessageLookupByLibrary.simpleMessage(
      "إدارة المستخدمين",
    ),
    "adminSearchByCompany": MessageLookupByLibrary.simpleMessage(
      "البحث حسب السبب الاجتماعي",
    ),
    "adminTotalInvoices": MessageLookupByLibrary.simpleMessage(
      "إجمالي الفواتير",
    ),
    "adminTotalUsers": MessageLookupByLibrary.simpleMessage(
      "إجمالي المستخدمين",
    ),
    "adminUsersManagement": MessageLookupByLibrary.simpleMessage(
      "إدارة المستخدمين",
    ),
    "adminViewInvoice": MessageLookupByLibrary.simpleMessage("عرض الفاتورة"),
    "adminViewInvoices": MessageLookupByLibrary.simpleMessage(
      "عرض جميع الفواتير",
    ),
    "adoption_rate_title": MessageLookupByLibrary.simpleMessage(
      "معدل اعتماد المستخدمين على المنصة",
    ),
    "allInvoicesLoaded": MessageLookupByLibrary.simpleMessage(
      "تم تحميل جميع الفواتير.",
    ),
    "allInvoicesTitle": MessageLookupByLibrary.simpleMessage("جميع الفواتير"),
    "allUsers": MessageLookupByLibrary.simpleMessage("جميع المستخدمين"),
    "allUsersLoaded": MessageLookupByLibrary.simpleMessage(
      "تم تحميل جميع المستخدمين.",
    ),
    "applyFilter": MessageLookupByLibrary.simpleMessage("تطبيق"),
    "authChangePassword": MessageLookupByLibrary.simpleMessage(
      "تغيير كلمة المرور",
    ),
    "authCompanyName": MessageLookupByLibrary.simpleMessage("السبب الاجتماعي"),
    "authConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "أكد كلمة المرور الجديدة",
    ),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "authEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني مستخدم بالفعل.",
    ),
    "authEmailPasswordReset": MessageLookupByLibrary.simpleMessage(
      "تم إرسال بريد إلكتروني إليك لتغيير كلمة المرور.",
    ),
    "authEnterCompanyName": MessageLookupByLibrary.simpleMessage(
      "أدخل السبب الاجتماعي",
    ),
    "authEnterEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني",
    ),
    "authEnterIce": MessageLookupByLibrary.simpleMessage(
      "أدخل المعرّف الموحد للمقاولة",
    ),
    "authEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور الجديدة",
    ),
    "authEnterOldPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة مرورك القديمة",
    ),
    "authEnterPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "authFirstLogin": MessageLookupByLibrary.simpleMessage("أول تسجيل دخول"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "نسيت كلمة المرور؟",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير صالح.",
    ),
    "authLogin": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "authLoginMessage": MessageLookupByLibrary.simpleMessage(
      "لديك حساب؟ سجل دخولك.",
    ),
    "authLoginPageTitle": MessageLookupByLibrary.simpleMessage(
      "صفحة تسجيل الدخول",
    ),
    "authLoginSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح.",
    ),
    "authLogoutButton": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "authMissingToken": MessageLookupByLibrary.simpleMessage(
      "رمز المصادقة مفقود. يرجى تسجيل الدخول مرة أخرى.",
    ),
    "authNewPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور الجديدة",
    ),
    "authOldPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور القديمة",
    ),
    "authPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "authPasswordChanged": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور بنجاح!",
    ),
    "authPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "كلمات المرور غير متطابقة.",
    ),
    "authPasswordResetSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رسالة لإعادة تعيين كلمة المرور.",
    ),
    "authPasswordStrength": MessageLookupByLibrary.simpleMessage(
      "قوة كلمة المرور",
    ),
    "authRegisterMessage": MessageLookupByLibrary.simpleMessage(
      "ليس لديك حساب؟ سجل الآن.",
    ),
    "authRegistrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم التسجيل بنجاح!",
    ),
    "authSameOldAndNewPassword": MessageLookupByLibrary.simpleMessage(
      "لا يمكن أن تكون كلمة المرور الجديدة هي نفسها القديمة.",
    ),
    "authSendLink": MessageLookupByLibrary.simpleMessage("إرسال الرابط"),
    "authSignupButton": MessageLookupByLibrary.simpleMessage("اشترك"),
    "authSignupPageTitle": MessageLookupByLibrary.simpleMessage("صفحة التسجيل"),
    "authWeakPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور ضعيفة. يجب أن تحتوي على 8 أحرف على الأقل، وحرف كبير، وحرف صغير، ورقم.",
    ),
    "clearFilter": MessageLookupByLibrary.simpleMessage("مسح الفلتر"),
    "clearFilterTooltip": MessageLookupByLibrary.simpleMessage("مسح الفلتر"),
    "collapseAll": MessageLookupByLibrary.simpleMessage("طي الكل"),
    "collapseAllTooltip": MessageLookupByLibrary.simpleMessage("طي الكل"),
    "currencySymbol": MessageLookupByLibrary.simpleMessage("د.م"),
    "current_year_label": m2,
    "dashboardCreateInvoice": MessageLookupByLibrary.simpleMessage(
      "إنشاء فاتورة",
    ),
    "dashboardManageUsers": MessageLookupByLibrary.simpleMessage(
      "إدارة المستخدمين",
    ),
    "dashboardViewInvoices": MessageLookupByLibrary.simpleMessage(
      "عرض الفواتير",
    ),
    "dashboardViewMyInvoices": MessageLookupByLibrary.simpleMessage(
      "عرض فواتيري",
    ),
    "dateRangeText": MessageLookupByLibrary.simpleMessage("التاريخ:"),
    "deactivate": MessageLookupByLibrary.simpleMessage("تعطيل"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "endDateLabel": MessageLookupByLibrary.simpleMessage("تاريخ النهاية"),
    "endDatePlaceholder": MessageLookupByLibrary.simpleMessage("تاريخ النهاية"),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorFetchingInvoices": MessageLookupByLibrary.simpleMessage(
      "خطأ في جلب الفواتير.",
    ),
    "errorMessage": m3,
    "errorPrefix": m4,
    "errorsAccountDisabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب. يرجى الاتصال بالمسؤول.",
    ),
    "errorsAccountNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على حساب بهذه المعلومات.",
    ),
    "errorsEmailAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "عنوان البريد الإلكتروني مستخدم بالفعل.",
    ),
    "errorsEmptyField": MessageLookupByLibrary.simpleMessage(
      "لا يمكن ترك هذا الحقل فارغًا.",
    ),
    "errorsEmptyServerResponse": MessageLookupByLibrary.simpleMessage(
      "استجابة فارغة من الخادم.",
    ),
    "errorsIceAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "رقم ICE مستخدم بالفعل.",
    ),
    "errorsIncorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني أو كلمة المرور غير صحيحة.",
    ),
    "errorsInternal": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ داخلي. يرجى المحاولة لاحقًا.",
    ),
    "errorsInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني أو كلمة المرور غير صحيحة.",
    ),
    "errorsInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "عنوان البريد الإلكتروني غير صالح.",
    ),
    "errorsInvalidIce": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون رقم ICE رقميًا ويتكون من 8 إلى 15 رقمًا.",
    ),
    "errorsInvalidLegalName": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتراوح اسم الشركة بين 3 و100 حرف.",
    ),
    "errorsInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور المقدمة غير صالحة.",
    ),
    "errorsInvalidUserInfo": MessageLookupByLibrary.simpleMessage(
      "المعلومات المقدمة غير صحيحة.",
    ),
    "errorsLegalNameAlreadyUsed": MessageLookupByLibrary.simpleMessage(
      "اسم الشركة مستخدم بالفعل.",
    ),
    "errorsLoginFailed": MessageLookupByLibrary.simpleMessage(
      "فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد الخاصة بك.",
    ),
    "errorsMissingFields": MessageLookupByLibrary.simpleMessage(
      "جميع الحقول مطلوبة.",
    ),
    "errorsNetwork": MessageLookupByLibrary.simpleMessage(
      "مشكلة في الاتصال بالشبكة.",
    ),
    "errorsPasswordChangeRequired": MessageLookupByLibrary.simpleMessage(
      "يجب عليك تغيير كلمة المرور الخاصة بك.",
    ),
    "errorsPasswordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إرسال كلمة مرور مؤقتة جديدة إلى عنوان بريدك الإلكتروني.",
    ),
    "errorsRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "فشل التسجيل.",
    ),
    "errorsSamePassword": MessageLookupByLibrary.simpleMessage(
      "لا يمكن أن تكون كلمة المرور الجديدة مثل القديمة.",
    ),
    "errorsServerLoginError": MessageLookupByLibrary.simpleMessage(
      "خطأ في الخادم أثناء تسجيل الدخول.",
    ),
    "errorsServerResponseProcessing": MessageLookupByLibrary.simpleMessage(
      "خطأ في معالجة استجابة الخادم.",
    ),
    "errorsTooLongCompanyName": MessageLookupByLibrary.simpleMessage(
      "لا يمكن أن يتجاوز اسم الشركة 100 حرف.",
    ),
    "errorsTooShortCompanyName": MessageLookupByLibrary.simpleMessage(
      "يجب أن يحتوي اسم الشركة على الأقل 3 أحرف.",
    ),
    "errorsUnexpected": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع.",
    ),
    "errorsUserDisabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب.",
    ),
    "errorsWeakPassword": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور ضعيفة جدًا.",
    ),
    "expandAll": MessageLookupByLibrary.simpleMessage("توسيع الكل"),
    "expandAllTooltip": MessageLookupByLibrary.simpleMessage("توسيع الكل"),
    "filterByDate": MessageLookupByLibrary.simpleMessage("تصفية حسب التاريخ"),
    "filterByStatus": MessageLookupByLibrary.simpleMessage("تصفية حسب الحالة"),
    "fromDateFilterDisplay": m5,
    "fromDateLabel": m6,
    "generalAdd": MessageLookupByLibrary.simpleMessage("إضافة"),
    "generalAmount": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "generalCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "generalCompany": MessageLookupByLibrary.simpleMessage("الشركة"),
    "generalDarkMode": MessageLookupByLibrary.simpleMessage("الوضع المظلم"),
    "generalDate": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "generalDownload": MessageLookupByLibrary.simpleMessage("تنزيل"),
    "generalEmail": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "generalFile": MessageLookupByLibrary.simpleMessage("الملف"),
    "generalFilter": MessageLookupByLibrary.simpleMessage("تصفية"),
    "generalIce": MessageLookupByLibrary.simpleMessage(
      "المعرّف الموحد للمقاولة",
    ),
    "generalLanguage": MessageLookupByLibrary.simpleMessage("اللغة"),
    "generalLogout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "generalNotifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "generalPassword": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "generalSearch": MessageLookupByLibrary.simpleMessage("بحث"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "generalSocialReason": MessageLookupByLibrary.simpleMessage(
      "السبب الاجتماعي",
    ),
    "generalTotal": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "generalValidate": MessageLookupByLibrary.simpleMessage("تحقق"),
    "genericSuccess": MessageLookupByLibrary.simpleMessage("تمت العملية بنجاح"),
    "homeDescription": MessageLookupByLibrary.simpleMessage(
      "الفاتورة الإلكترونية هي منصة إلكترونية لإيداع الفواتير من قبل موردي SNRT.",
    ),
    "homeHaveAccount": MessageLookupByLibrary.simpleMessage("هل لديك حساب؟"),
    "homeLogin": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "homeNoAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
    "homeSignup": MessageLookupByLibrary.simpleMessage("اشترك"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("الفاتورة الإلكترونية"),
    "iceLabel": MessageLookupByLibrary.simpleMessage("الـ ICE"),
    "inactiveStatus": MessageLookupByLibrary.simpleMessage("غير نشط"),
    "inactiveUsers": MessageLookupByLibrary.simpleMessage(
      "المستخدمين غير النشطين",
    ),
    "inactiveUsersStatus": MessageLookupByLibrary.simpleMessage(
      "مستخدمون غير نشطين",
    ),
    "inactive_label": MessageLookupByLibrary.simpleMessage("غير نشط"),
    "invoiceAddInvoice": MessageLookupByLibrary.simpleMessage("إضافة الفاتورة"),
    "invoiceAddPdf": MessageLookupByLibrary.simpleMessage("إضافة ملف PDF"),
    "invoiceAllAmounts": MessageLookupByLibrary.simpleMessage("جميع المبالغ"),
    "invoiceAllDates": MessageLookupByLibrary.simpleMessage("جميع التواريخ"),
    "invoiceAmount": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "invoiceAmountFilter": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "invoiceAmountRequirements": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون المبلغ أكبر من 5 ملايين.",
    ),
    "invoiceCount": MessageLookupByLibrary.simpleMessage("عدد الفواتير"),
    "invoiceCountResult": m7,
    "invoiceCreateInvoiceTitle": MessageLookupByLibrary.simpleMessage(
      "إنشاء فاتورة",
    ),
    "invoiceDate": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "invoiceDateFilter": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "invoiceDownload": MessageLookupByLibrary.simpleMessage("تحميل"),
    "invoiceError": m8,
    "invoiceFebruary": MessageLookupByLibrary.simpleMessage("فبراير"),
    "invoiceFileRequirements": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون الملف بصيغة PDF وأقل من 2 ميجابايت.",
    ),
    "invoiceHistory": MessageLookupByLibrary.simpleMessage("سجل الفواتير"),
    "invoiceID": MessageLookupByLibrary.simpleMessage("المعرف"),
    "invoiceJanuary": MessageLookupByLibrary.simpleMessage("يناير"),
    "invoiceLessThan2000": MessageLookupByLibrary.simpleMessage("أقل من 2000€"),
    "invoiceMarch": MessageLookupByLibrary.simpleMessage("مارس"),
    "invoiceMoreThan2000": MessageLookupByLibrary.simpleMessage(
      "أكثر من 2000€",
    ),
    "invoicePdfSelected": m9,
    "invoiceSearchInvoice": MessageLookupByLibrary.simpleMessage(
      "بحث عن فاتورة...",
    ),
    "invoiceTotal": MessageLookupByLibrary.simpleMessage("إجمالي المبلغ"),
    "invoice_activity_title": MessageLookupByLibrary.simpleMessage(
      "نشاط الفواتير",
    ),
    "invoicesFoundCount": m10,
    "invoicesLabel": MessageLookupByLibrary.simpleMessage("الفواتير"),
    "languagesArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "languagesEnglish": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "languagesFrench": MessageLookupByLibrary.simpleMessage("الفرنسية"),
    "last_seven_days": MessageLookupByLibrary.simpleMessage("آخر 7 أيام"),
    "loading": MessageLookupByLibrary.simpleMessage("جارٍ التحميل..."),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح.",
    ),
    "monthly_invoice_title": MessageLookupByLibrary.simpleMessage(
      "الفواتير حسب الشهر",
    ),
    "myInvoices": MessageLookupByLibrary.simpleMessage("فواتيري"),
    "navigationBack": MessageLookupByLibrary.simpleMessage("عودة"),
    "navigationDashboardAdmin": MessageLookupByLibrary.simpleMessage(
      "لوحة تحكم المسؤول",
    ),
    "navigationDashboardUser": MessageLookupByLibrary.simpleMessage(
      "لوحة تحكم المستخدم",
    ),
    "navigationHome": MessageLookupByLibrary.simpleMessage("الصفحة الرئيسية"),
    "never_returned_label": MessageLookupByLibrary.simpleMessage(
      "لم يعد بعد التسجيل",
    ),
    "noInvoicesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد فواتير متاحة.",
    ),
    "noInvoicesFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على فواتير",
    ),
    "noUserFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مستخدم",
    ),
    "no_data_message": MessageLookupByLibrary.simpleMessage(
      "لا توجد بيانات لعرضها.",
    ),
    "passwordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور بنجاح.",
    ),
    "profileRetrieved": MessageLookupByLibrary.simpleMessage(
      "تم استرجاع الملف الشخصي بنجاح.",
    ),
    "registrationSuccess": MessageLookupByLibrary.simpleMessage(
      "تم التسجيل بنجاح.",
    ),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال كلمة مرور مؤقتة إذا كانت المعلومات المقدمة صحيحة.",
    ),
    "returned_and_invoiced_label": MessageLookupByLibrary.simpleMessage(
      "عاد وأنشأ على الأقل فاتورة واحدة",
    ),
    "returned_without_invoice_label": MessageLookupByLibrary.simpleMessage(
      "عاد دون إنشاء فاتورة",
    ),
    "search": MessageLookupByLibrary.simpleMessage("بحث"),
    "searchInvoiceHint": MessageLookupByLibrary.simpleMessage(
      "ابحث عن فاتورة...",
    ),
    "searchQueryDisplay": m11,
    "searchQueryText": MessageLookupByLibrary.simpleMessage("بحث:"),
    "searchUserPlaceholder": MessageLookupByLibrary.simpleMessage(
      "ابحث عن مستخدم...",
    ),
    "showGridView": MessageLookupByLibrary.simpleMessage("عرض كشبكة"),
    "showListView": MessageLookupByLibrary.simpleMessage("عرض كقائمة"),
    "startDateLabel": MessageLookupByLibrary.simpleMessage("تاريخ البداية"),
    "startDatePlaceholder": MessageLookupByLibrary.simpleMessage(
      "تاريخ البداية",
    ),
    "statisticsTitle": MessageLookupByLibrary.simpleMessage("الإحصائيات"),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "statusLabel": m12,
    "toDateFilterDisplay": m13,
    "toDateLabel": m14,
    "totalAmountLabel": MessageLookupByLibrary.simpleMessage("المبلغ الإجمالي"),
    "userCount": m15,
    "userInvoicesTitle": MessageLookupByLibrary.simpleMessage(
      "فواتير المستخدم",
    ),
    "user_status_chart_title": MessageLookupByLibrary.simpleMessage(
      "المستخدمين النشطين مقابل غير النشطين",
    ),
    "viewInvoices": MessageLookupByLibrary.simpleMessage("عرض الفواتير"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "الفاتورة الإلكترونية هي منصة إلكترونية لإيداع الفواتير من قبل موردي SNRT.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("مرحبًا"),
  };
}
