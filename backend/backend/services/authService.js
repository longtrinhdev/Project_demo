const { OAuth2Client } = require("google-auth-library");
const client = new OAuth2Client(process.env.CLIENT_ID);

const authService = {
  verifyGoogleIdToken: async (idToken) => {
    try {
      const ticket = await client.verifyIdToken({
        idToken: idToken,
        audience: process.env.CLIENT_ID,
      });
      return ticket;
    } catch (error) {
      console.log(error);
      return null;
    }
  },
};

module.exports = authService;
