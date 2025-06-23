import nodemailer from "nodemailer";
import dotenv from "dotenv";

// Charger les variables d'environnement depuis le fichier .env
dotenv.config();

// Configuration du transporteur pour envoyer l'email avec Mailersend
const transporter = nodemailer.createTransport({
  host: "smtp.mailersend.net", // Correct SMTP server
  port: 587, // Port pour TLS
  secure: false, // Utilise false pour TLS
  auth: {
    user: process.env.SMTP_USER, // Ton SMTP Username
    pass: process.env.SMTP_PASS, // Ton SMTP Password
  },
});

// Vérification de la connexion
transporter.verify((error, success) => {
  if (error) {
    console.error("Erreur de connexion SMTP :", error);
  } else {
    console.log("Connexion SMTP réussie !");
  }
});

// Fonction pour envoyer un email avec le mot de passe temporaire
export const sendWelcomeEmail = (userEmail, tempPassword, legalName) => {
  const mailOptions = {
    from: process.env.SMTP_USER, // Email expéditeur
    to: userEmail, // Email du destinataire
    subject: "Bienvenue sur E-Facture - Votre mot de passe temporaire", // Sujet de l'email
    html: `
      <h1>Bienvenue ${legalName} !</h1>
      <p>Nous sommes heureux de vous compter parmi nos utilisateurs. Votre inscription a été réussie.</p>
      <p>Voici votre mot de passe temporaire : <strong>${tempPassword}</strong></p>
      <p>Vous pourrez le modifier dès votre première connexion.</p>
      <p>Merci de faire confiance à notre service.</p>
    `,
  };

  // Envoi de l'email
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log("Erreur d'envoi d'email:", error);
    } else {
      console.log("Email envoyé avec succès. Réponse du serveur:", info.response);
      console.log("Détails de l'email envoyé (sendWelcomeEmail):", JSON.stringify(mailOptions, null, 2));
    }
  });
};
export const sendResetPasswordEmail = (userEmail, tempPassword, legalName) => {
  const mailOptions = {
    from: process.env.SMTP_USER,
    to: userEmail,
    subject: "Réinitialisation de votre mot de passe - E-Facture",
    html: `
      <h1>Réinitialisation de votre mot de passe</h1>
      <p>Bonjour ${legalName},</p>
      <p>Un mot de passe temporaire a été généré suite à votre demande.</p>
      <p>Voici votre nouveau mot de passe temporaire : <strong>${tempPassword}</strong></p>
      <p>Vous serez invité à le modifier dès votre prochaine connexion.</p>
      <p>Si vous n'avez pas initié cette demande, veuillez ignorer cet email.</p>
    `,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log("Erreur d'envoi du mail de réinit:", error);
    } else {
      console.log("Mail de réinit envoyé :", info.response);
    }
  });
};
