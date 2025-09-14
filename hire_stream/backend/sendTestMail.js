import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config(); // load .env file

async function sendTestEmail() {
  try {
    // configure transporter
    const transporter = nodemailer.createTransport({
      host: "smtp-relay.brevo.com",
      port: 587, // TLS
      secure: false, // true for 465
      auth: {
        user: process.env.BREVO_USER,     // should be "apikey"
        pass: process.env.BREVO_PASSWORD, // your Brevo SMTP key
      },
    });

    // send email
    const info = await transporter.sendMail({
      from: '"HireStream Test" <no-reply@hirestream.com>', // sender name & email
      to: "khushikp0211@gmail.com",                           // <-- replace with your email
      subject: "✅ HireStream SMTP Test",
      text: "Hello! This is a test email from HireStream via Brevo SMTP.",
    });

    console.log("✅ Test Email Sent:", info.messageId);
  } catch (error) {
    console.error("❌ Error sending email:", error);
  }
}

sendTestEmail();
