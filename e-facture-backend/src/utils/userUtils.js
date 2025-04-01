import User from "../models/user.model.js";

export const checkUserConflicts = async ({ email, ice, legalName }) => {
  const conflicts = {};
  if (await User.findOne({ legalName }))
    conflicts.legalName = "errorsLegalNameAlreadyUsed";
  if (await User.findOne({ ice })) conflicts.ice = "errorsIceAlreadyUsed";
  if (await User.findOne({ email })) conflicts.email = "errorsEmailAlreadyUsed";
  return conflicts;
};

export const formatUserForClient = (user) => ({
  id: user._id,
  email: user.email,
  legalName: user.legalName,
  ice: user.ice,
  isAdmin: user.isAdmin,
  isFirstLogin: user.isFirstLogin,
  isActive: user.isActive,
  createdAt: user.createdAt,
  updatedAt: user.updatedAt,
  password: "",
});
