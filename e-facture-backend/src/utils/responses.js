export const successResponse = (res, code, data = {}) =>
  res.status(200).json({ success: true, code, ...data });

export const errorResponse = (res, code, status = 400) => {
  const response = { success: false, code };
  console.log(
    "🧾 Sending error response:",
    JSON.stringify(response),
    "with status:",
    status
  );
  return res.status(status).json(response);
};
