# Setting up the AI assistant, codes and sign-in

The app works without any of these services: it falls back to the demo
code `123456` and tells the person the service is not set up. Phone numbers
always use the demo code; real codes go by email. Each service
needs its own free account, and the keys reach the app in one of two ways:

- **Built into the APK.** Add each value as a repository secret
  (GitHub > Settings > Secrets and variables > Actions > New repository
  secret) with the exact name below. The next CI build bakes them in.
- **Typed on the phone.** Profile > Connections (also linked from the
  sign-in screens). Values typed there stay on that phone and win over the
  built-in ones. This is the quickest way to test.

Keys built into an APK can be pulled out of it. That is fine for testing; a
production release should move the Gemini call and code sending behind the
clinic's own server.

SMS codes and Google / Microsoft sign-in were removed for now.

## 1. AI assistant: Google Gemini

1. Go to https://aistudio.google.com, sign in, then **Get API key** >
   **Create API key**.
2. Secret: `GEMINI_API_KEY`. Optional: `GEMINI_MODEL` (default
   `gemini-flash-latest`).

The assistant answers only pregnancy, maternity and women's health questions,
always in the language picked under "Answer in", and shows the urgent-care
card before answering when a question mentions a warning sign.

## 2. Email codes: EmailJS with Gmail

1. Create a free account at https://www.emailjs.com.
2. **Email Services** > **Add New Service** > **Gmail**, connect the Gmail
   account that should send the codes. Note the **Service ID**.
3. **Email Templates** > **Create New Template**. Set **To Email** to
   `{{to_email}}` and put `{{passcode}}` in the message, for example
   "Your Maternal code is {{passcode}}. It expires at {{time}}." Note the
   **Template ID**.
4. **Account** > **General**: copy the **Public Key**. **Account** >
   **Security**: turn on **Allow EmailJS API for non-browser applications**
   and copy the **Private Key**.
5. Secrets: `EMAILJS_SERVICE_ID`, `EMAILJS_TEMPLATE_ID`, `EMAILJS_PUBLIC_KEY`,
   `EMAILJS_PRIVATE_KEY`.

## 3. Authenticator app (no setup needed)

Sign in with the demo account, open Profile > Sign-in & security >
**Set up authenticator app**, tap **Open authenticator app** (or type the
setup key into Google Authenticator), enter the 6-digit code to turn it on.
After signing out, signing in with that account asks for the authenticator
code; "Send a code by SMS or email instead" is still offered.

## 4. Bluetooth watch (no setup needed)

The first time each person signs in on a phone, the app shows Android's own
Bluetooth permission box. Profile > Connected devices has **Turn on Bluetooth
and find my watch** for pairing. It reads the standard Bluetooth
heart-rate service and saves one reading a minute to the Health log. Many
watches only share heart rate when **Broadcast heart rate** (HR broadcast) is
on in the watch settings; watches that only sync through their own app need
Health Connect instead, which is still a demo in this build.
