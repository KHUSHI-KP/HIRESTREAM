// hash.js
import bcrypt from "bcrypt";

const run = async () => {
  try {
    const hash = await bcrypt.hash("khushikp200411", 10);
    console.log("Generated Hash:", hash);
  } catch (err) {
    console.error("Error:", err);
  }
};

run();

