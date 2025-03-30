// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(company) => "Compte de ${company} désactivé";

  static String m1(invoice) => "Téléchargement de ${invoice}...";

  static String m2(year) => "${year}";

  static String m3(error) => "Erreur: ${error}";

  static String m4(error) => "Erreur: ${error}";

  static String m5(date) => "Du ${date}";

  static String m6(date) => "Du: ${date}";

  static String m7(count) => "${count} facture(s) trouvée(s)";

  static String m8(error) => "Erreur: ${error}";

  static String m9(filename) => "Fichier PDF sélectionné : ${filename}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'Aucune facture trouvée', one: '1 facture trouvée', other: '${count} factures trouvées')}";

  static String m11(query) => "Recherche: \"${query}\"";

  static String m12(status) => "Statut: ${status}";

  static String m13(date) => "Au ${date}";

  static String m14(date) => "Au: ${date}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'Aucun utilisateur trouvé', one: '1 utilisateur trouvé', other: '${count} utilisateurs trouvés')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "activate": MessageLookupByLibrary.simpleMessage("Activer"),
    "activeFilter": MessageLookupByLibrary.simpleMessage("Filtre actif"),
    "activeStatus": MessageLookupByLibrary.simpleMessage("Actif"),
    "activeUsers": MessageLookupByLibrary.simpleMessage("Utilisateurs actifs"),
    "activeUsersStatus": MessageLookupByLibrary.simpleMessage(
      "Utilisateurs actifs",
    ),
    "active_label": MessageLookupByLibrary.simpleMessage("Actifs"),
    "adminAccountDeactivated": m0,
    "adminCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Raison Sociale :",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez les utilisateurs et consultez toutes les factures.",
    ),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Tableau de bord Admin",
    ),
    "adminDeactivate": MessageLookupByLibrary.simpleMessage("Désactiver"),
    "adminDownloading": m1,
    "adminEmailLabel": MessageLookupByLibrary.simpleMessage("Email :"),
    "adminIceLabel": MessageLookupByLibrary.simpleMessage("ICE :"),
    "adminInvoicesManagement": MessageLookupByLibrary.simpleMessage(
      "Gestion des Factures (Admin)",
    ),
    "adminInvoicesSubmitted": MessageLookupByLibrary.simpleMessage(
      "Factures Déposées :",
    ),
    "adminManageUsers": MessageLookupByLibrary.simpleMessage(
      "Gérer les utilisateurs",
    ),
    "adminSearchByCompany": MessageLookupByLibrary.simpleMessage(
      "Rechercher par Raison Sociale",
    ),
    "adminTotalInvoices": MessageLookupByLibrary.simpleMessage(
      "Total des factures",
    ),
    "adminTotalUsers": MessageLookupByLibrary.simpleMessage(
      "Total des utilisateurs",
    ),
    "adminUsersManagement": MessageLookupByLibrary.simpleMessage(
      "Gestion des Utilisateurs",
    ),
    "adminViewInvoice": MessageLookupByLibrary.simpleMessage("Voir la Facture"),
    "adminViewInvoices": MessageLookupByLibrary.simpleMessage(
      "Voir toutes les factures",
    ),
    "adoption_rate_title": MessageLookupByLibrary.simpleMessage(
      "Taux d’adoption de la plateforme",
    ),
    "allInvoicesLoaded": MessageLookupByLibrary.simpleMessage(
      "Toutes les factures sont chargées.",
    ),
    "allInvoicesTitle": MessageLookupByLibrary.simpleMessage(
      "Toutes les Factures",
    ),
    "allUsers": MessageLookupByLibrary.simpleMessage("Tous les utilisateurs"),
    "allUsersLoaded": MessageLookupByLibrary.simpleMessage(
      "Tous les utilisateurs sont chargés.",
    ),
    "applyFilter": MessageLookupByLibrary.simpleMessage("Appliquer"),
    "authChangePassword": MessageLookupByLibrary.simpleMessage(
      "Changer le mot de passe",
    ),
    "authCompanyName": MessageLookupByLibrary.simpleMessage("Raison Sociale"),
    "authConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre nouveau mot de passe",
    ),
    "authConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "authEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
    "authEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "L\'e-mail est déjà utilisé.",
    ),
    "authEmailPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Un email vous a été envoyé pour changer votre mot de passe.",
    ),
    "authEnterCompanyName": MessageLookupByLibrary.simpleMessage(
      "Entrez votre raison sociale",
    ),
    "authEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Entrez votre email",
    ),
    "authEnterIce": MessageLookupByLibrary.simpleMessage("Entrez l\'ICE"),
    "authEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Entrez votre nouveau mot de passe",
    ),
    "authEnterOldPassword": MessageLookupByLibrary.simpleMessage(
      "Entrez votre ancien mot de passe",
    ),
    "authEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Entrez votre mot de passe",
    ),
    "authFirstLogin": MessageLookupByLibrary.simpleMessage(
      "Première Connexion",
    ),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié ?",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "E-mail invalide.",
    ),
    "authLogin": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authLoginMessage": MessageLookupByLibrary.simpleMessage(
      "Vous avez un compte ? Connectez-vous.",
    ),
    "authLoginPageTitle": MessageLookupByLibrary.simpleMessage(
      "Page de Connexion",
    ),
    "authLoginSuccessful": MessageLookupByLibrary.simpleMessage(
      "Connexion réussie !",
    ),
    "authLogoutButton": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "authMissingToken": MessageLookupByLibrary.simpleMessage(
      "Jeton manquant. Veuillez vous reconnecter.",
    ),
    "authNewPassword": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "authOldPassword": MessageLookupByLibrary.simpleMessage(
      "Ancien mot de passe",
    ),
    "authPassword": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "authPasswordChanged": MessageLookupByLibrary.simpleMessage(
      "Mot de passe changé avec succès !",
    ),
    "authPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas.",
    ),
    "authPasswordStrength": MessageLookupByLibrary.simpleMessage(
      "Force du mot de passe",
    ),
    "authRegisterMessage": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas de compte ? Inscrivez-vous maintenant.",
    ),
    "authRegistrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Inscription réussie ! Un mot de passe temporaire a été envoyé à votre email.",
    ),
    "authSameOldAndNewPassword": MessageLookupByLibrary.simpleMessage(
      "Le nouveau mot de passe ne peut pas être identique à l\'ancien.",
    ),
    "authSendLink": MessageLookupByLibrary.simpleMessage("Envoyer le lien"),
    "authSignupButton": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "authSignupPageTitle": MessageLookupByLibrary.simpleMessage(
      "Page d\'Inscription",
    ),
    "authWeakPassword": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe est trop faible. Il doit contenir au moins 8 caractères, une majuscule, une minuscule et un chiffre.",
    ),
    "clearFilter": MessageLookupByLibrary.simpleMessage("Effacer le filtre"),
    "clearFilterTooltip": MessageLookupByLibrary.simpleMessage(
      "Effacer le filtre",
    ),
    "collapseAll": MessageLookupByLibrary.simpleMessage("Réduire tous"),
    "collapseAllTooltip": MessageLookupByLibrary.simpleMessage("Réduire tous"),
    "currencySymbol": MessageLookupByLibrary.simpleMessage("DH"),
    "current_year_label": m2,
    "dashboardCreateInvoice": MessageLookupByLibrary.simpleMessage(
      "Créer une facture",
    ),
    "dashboardManageUsers": MessageLookupByLibrary.simpleMessage(
      "Gérer les utilisateurs",
    ),
    "dashboardViewInvoices": MessageLookupByLibrary.simpleMessage(
      "Voir les factures",
    ),
    "dashboardViewMyInvoices": MessageLookupByLibrary.simpleMessage(
      "Voir mes factures",
    ),
    "dateRangeText": MessageLookupByLibrary.simpleMessage("Date :"),
    "deactivate": MessageLookupByLibrary.simpleMessage("Désactiver"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "endDateLabel": MessageLookupByLibrary.simpleMessage("Date Fin"),
    "endDatePlaceholder": MessageLookupByLibrary.simpleMessage("Date fin"),
    "error": MessageLookupByLibrary.simpleMessage("Erreur"),
    "errorFetchingInvoices": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de la récupération des factures.",
    ),
    "errorMessage": m3,
    "errorPrefix": m4,
    "errorsAccountDisabled": MessageLookupByLibrary.simpleMessage(
      "Ce compte a été désactivé. Veuillez contacter l\'administrateur.",
    ),
    "errorsEmptyField": MessageLookupByLibrary.simpleMessage(
      "Ce champ ne peut pas être vide.",
    ),
    "errorsEmptyServerResponse": MessageLookupByLibrary.simpleMessage(
      "Réponse vide du serveur.",
    ),
    "errorsIncorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "Email ou mot de passe incorrect.",
    ),
    "errorsInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer un email valide.",
    ),
    "errorsInvalidIce": MessageLookupByLibrary.simpleMessage(
      "L\'ICE doit être numérique et contenir entre 8 et 15 chiffres.",
    ),
    "errorsInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe fourni n\'est pas valide.",
    ),
    "errorsLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la connexion. Veuillez vérifier vos identifiants.",
    ),
    "errorsNetwork": MessageLookupByLibrary.simpleMessage(
      "Network error, please try again.",
    ),
    "errorsPasswordChangeRequired": MessageLookupByLibrary.simpleMessage(
      "Vous devez changer votre mot de passe.",
    ),
    "errorsPasswordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "Un nouveau mot de passe temporaire a été envoyé à votre adresse email.",
    ),
    "errorsRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de l\'inscription.",
    ),
    "errorsServerLoginError": MessageLookupByLibrary.simpleMessage(
      "Erreur serveur lors de la connexion.",
    ),
    "errorsServerResponseProcessing": MessageLookupByLibrary.simpleMessage(
      "Erreur lors du traitement de la réponse du serveur.",
    ),
    "errorsTooLongCompanyName": MessageLookupByLibrary.simpleMessage(
      "La raison sociale ne peut pas dépasser 100 caractères.",
    ),
    "errorsTooShortCompanyName": MessageLookupByLibrary.simpleMessage(
      "La raison sociale doit contenir au moins 3 caractères.",
    ),
    "errorsUnexpected": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again later.",
    ),
    "expandAll": MessageLookupByLibrary.simpleMessage("Développer tous"),
    "expandAllTooltip": MessageLookupByLibrary.simpleMessage("Développer tous"),
    "filterByDate": MessageLookupByLibrary.simpleMessage("Filtrer par date"),
    "filterByStatus": MessageLookupByLibrary.simpleMessage(
      "Filtrer par statut",
    ),
    "fromDateFilterDisplay": m5,
    "fromDateLabel": m6,
    "generalAdd": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "generalAmount": MessageLookupByLibrary.simpleMessage("Montant"),
    "generalCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "generalCompany": MessageLookupByLibrary.simpleMessage("Entreprise"),
    "generalDarkMode": MessageLookupByLibrary.simpleMessage("Mode Sombre"),
    "generalDate": MessageLookupByLibrary.simpleMessage("Date"),
    "generalDownload": MessageLookupByLibrary.simpleMessage("Télécharger"),
    "generalEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "generalFile": MessageLookupByLibrary.simpleMessage("Fichier"),
    "generalFilter": MessageLookupByLibrary.simpleMessage("Filtrer"),
    "generalIce": MessageLookupByLibrary.simpleMessage("ICE"),
    "generalLanguage": MessageLookupByLibrary.simpleMessage("Langue"),
    "generalLogout": MessageLookupByLibrary.simpleMessage("Déconnexion"),
    "generalNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "generalPassword": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "generalSearch": MessageLookupByLibrary.simpleMessage("Rechercher"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "generalSocialReason": MessageLookupByLibrary.simpleMessage(
      "Raison Sociale",
    ),
    "generalTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "generalValidate": MessageLookupByLibrary.simpleMessage("Valider"),
    "homeDescription": MessageLookupByLibrary.simpleMessage(
      "e-Facture est une plateforme électronique de dépôt des factures des fournisseurs de la SNRT.",
    ),
    "homeHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ?",
    ),
    "homeLogin": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "homeNoAccount": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas de compte ?",
    ),
    "homeSignup": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("E-Facture"),
    "iceLabel": MessageLookupByLibrary.simpleMessage("ICE"),
    "inactiveStatus": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "inactiveUsers": MessageLookupByLibrary.simpleMessage(
      "Utilisateurs inactifs",
    ),
    "inactiveUsersStatus": MessageLookupByLibrary.simpleMessage(
      "Utilisateurs inactifs",
    ),
    "inactive_label": MessageLookupByLibrary.simpleMessage("Inactifs"),
    "invoiceAddInvoice": MessageLookupByLibrary.simpleMessage(
      "Ajouter la facture",
    ),
    "invoiceAddPdf": MessageLookupByLibrary.simpleMessage(
      "Ajouter un fichier PDF",
    ),
    "invoiceAllAmounts": MessageLookupByLibrary.simpleMessage(
      "Tous les montants",
    ),
    "invoiceAllDates": MessageLookupByLibrary.simpleMessage("Toutes les dates"),
    "invoiceAmount": MessageLookupByLibrary.simpleMessage("Montant"),
    "invoiceAmountFilter": MessageLookupByLibrary.simpleMessage("Montant"),
    "invoiceAmountRequirements": MessageLookupByLibrary.simpleMessage(
      "Le montant doit être supérieur à 5 millions.",
    ),
    "invoiceCount": MessageLookupByLibrary.simpleMessage("Nombre de factures"),
    "invoiceCountResult": m7,
    "invoiceCreateInvoiceTitle": MessageLookupByLibrary.simpleMessage(
      "Créer une Facture",
    ),
    "invoiceDate": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDateFilter": MessageLookupByLibrary.simpleMessage("Date"),
    "invoiceDownload": MessageLookupByLibrary.simpleMessage("Télécharger"),
    "invoiceError": m8,
    "invoiceFebruary": MessageLookupByLibrary.simpleMessage("Février"),
    "invoiceFileRequirements": MessageLookupByLibrary.simpleMessage(
      "Le fichier doit être un PDF et < 2 Mo.",
    ),
    "invoiceHistory": MessageLookupByLibrary.simpleMessage(
      "Historique des Factures",
    ),
    "invoiceID": MessageLookupByLibrary.simpleMessage("ID"),
    "invoiceJanuary": MessageLookupByLibrary.simpleMessage("Janvier"),
    "invoiceLessThan2000": MessageLookupByLibrary.simpleMessage(
      "Moins de 2000€",
    ),
    "invoiceMarch": MessageLookupByLibrary.simpleMessage("Mars"),
    "invoiceMoreThan2000": MessageLookupByLibrary.simpleMessage(
      "Plus de 2000€",
    ),
    "invoicePdfSelected": m9,
    "invoiceSearchInvoice": MessageLookupByLibrary.simpleMessage(
      "Rechercher une facture...",
    ),
    "invoiceTotal": MessageLookupByLibrary.simpleMessage("Montant total"),
    "invoice_activity_title": MessageLookupByLibrary.simpleMessage(
      "Activité des Factures",
    ),
    "invoicesFoundCount": m10,
    "invoicesLabel": MessageLookupByLibrary.simpleMessage("Factures"),
    "languagesArabic": MessageLookupByLibrary.simpleMessage("Arabe"),
    "languagesEnglish": MessageLookupByLibrary.simpleMessage("Anglais"),
    "languagesFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "last_seven_days": MessageLookupByLibrary.simpleMessage("7 derniers jours"),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
    "monthly_invoice_title": MessageLookupByLibrary.simpleMessage(
      "Factures par Mois",
    ),
    "myInvoices": MessageLookupByLibrary.simpleMessage("Mes Factures"),
    "navigationBack": MessageLookupByLibrary.simpleMessage("Retour"),
    "navigationDashboardAdmin": MessageLookupByLibrary.simpleMessage(
      "Tableau de Bord Admin",
    ),
    "navigationDashboardUser": MessageLookupByLibrary.simpleMessage(
      "Tableau de Bord Utilisateur",
    ),
    "navigationHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "never_returned_label": MessageLookupByLibrary.simpleMessage(
      "Jamais reconnecté après inscription",
    ),
    "noInvoicesAvailable": MessageLookupByLibrary.simpleMessage(
      "Aucune facture disponible.",
    ),
    "noInvoicesFound": MessageLookupByLibrary.simpleMessage(
      "Aucune facture trouvée",
    ),
    "noUserFound": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur trouvé",
    ),
    "no_data_message": MessageLookupByLibrary.simpleMessage(
      "Aucune donnée à afficher.",
    ),
    "returned_and_invoiced_label": MessageLookupByLibrary.simpleMessage(
      "Revenu et a créé au moins 1 facture",
    ),
    "returned_without_invoice_label": MessageLookupByLibrary.simpleMessage(
      "Revenu sans créer de facture",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Recherche"),
    "searchInvoiceHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une facture...",
    ),
    "searchQueryDisplay": m11,
    "searchQueryText": MessageLookupByLibrary.simpleMessage("Recherche :"),
    "searchUserPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Rechercher un utilisateur...",
    ),
    "showGridView": MessageLookupByLibrary.simpleMessage("Afficher en grille"),
    "showListView": MessageLookupByLibrary.simpleMessage("Afficher en liste"),
    "startDateLabel": MessageLookupByLibrary.simpleMessage("Date Début"),
    "startDatePlaceholder": MessageLookupByLibrary.simpleMessage("Date début"),
    "statisticsTitle": MessageLookupByLibrary.simpleMessage("Statistiques"),
    "status": MessageLookupByLibrary.simpleMessage("Statut"),
    "statusLabel": m12,
    "toDateFilterDisplay": m13,
    "toDateLabel": m14,
    "totalAmountLabel": MessageLookupByLibrary.simpleMessage("Montant Total"),
    "userCount": m15,
    "userInvoicesTitle": MessageLookupByLibrary.simpleMessage(
      "Factures Utilisateur",
    ),
    "user_status_chart_title": MessageLookupByLibrary.simpleMessage(
      "Utilisateurs Actifs vs Inactifs",
    ),
    "viewInvoices": MessageLookupByLibrary.simpleMessage("Voir Factures"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "e-Facture est une plateforme électronique de dépôt des factures des fournisseurs de la SNRT.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage("Bienvenue"),
  };
}
