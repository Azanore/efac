export const validateEmail = (email) =>
  /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email);

export const validateICE = (ice) => /^\d{8,15}$/.test(ice);

export const validateLegalName = (name) =>
  name.length >= 3 && name.length <= 100;
export const validateStrongPassword = (password) => {
  const hasUppercase = /[A-Z]/.test(password);
  const hasLowercase = /[a-z]/.test(password);
  const hasDigit = /\d/.test(password);
  const hasMinLength = password.length >= 8;

  return hasUppercase && hasLowercase && hasDigit && hasMinLength;
};
