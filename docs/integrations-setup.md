# Setting up the AI assistant, codes and sign-in

The app works without any of these services: it falls back to the demo
code `123456` and tells the person the service is not set up. Sign-in is by
email (one-time code) or Google; there are no phone or SMS codes. Each service
needs its own free account. Add each key as a repository secret (GitHub >
Settings > Secrets and variables > Actions > New repository secret) with the
exact name below; the next CI build bakes it into the APK.

Keys built into an APK can be pulled out of it. That is fine for testing; a
production release should move the Gemini call and code sending behind the
clinic's own server.

SMS codes were removed.

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
5. Secrets: `EMAILJS_PRIVATE_KEY`. The service ID, template ID and public key
   are public identifiers, so the CI workflow already has this project's
   values as defaults; add `EMAILJS_SERVICE_ID`, `EMAILJS_TEMPLATE_ID` or
   `EMAILJS_PUBLIC_KEY` secrets only to use a different EmailJS account.
   The private key is only needed when **Use Private Key** is on under
   Account > Security; never commit it, since the repository is public.

The person types their email on the sign-in or sign-up screen, the app sends
a 6-digit code there, and the code works for 90 seconds; the screen counts
down and offers a new code when it runs out.

## 3. Google sign-in

1. In https://console.cloud.google.com create (or pick) a project.
2. **APIs & Services** > **OAuth consent screen**: choose **External**, fill
   in the app name and support email. While it is in **Testing**, add each
   tester's Gmail under **Test users** (or **Publish app**).
3. **Credentials** > **Create credentials** > **OAuth client ID** >
   **Android**: package name `com.maternal.maternal`, SHA-1
   `F9:0A:AF:BE:C0:B4:02:7B:B1:FE:A7:D1:DB:4A:69:CF:DA:CF:47:4C` (the shared
   debug key in `android/app/debug.keystore`, used by every debug build).
4. **Create credentials** > **OAuth client ID** > **Web application** (no
   URLs needed). Copy its **Client ID**.
5. Secret: `GOOGLE_SERVER_CLIENT_ID` = that Web client ID.

New people are asked before the app copies their Google name, email and
photo into a profile; they then land straight on Home. People whose email
already has an account sign straight in.

## 4. Authenticator app (no setup needed)

Sign in with the demo account, open Profile > Sign-in & security >
**Set up authenticator app**, tap **Open authenticator app** (or type the
setup key into Google Authenticator), enter the 6-digit code to turn it on.
After signing out, signing in with that account asks for the authenticator
code; "Send a code by email instead" is still offered.

## 5. Bluetooth watch (no setup needed)

The first time each person signs in on a phone, the app shows Android's own
Bluetooth permission box. Profile > Connected devices has **Turn on Bluetooth
and find my watch** for pairing. It reads the standard Bluetooth
heart-rate service and saves one reading a minute to the Health log. Many
watches only share heart rate when **Broadcast heart rate** (HR broadcast) is
on in the watch settings; watches that only sync through their own app need
Health Connect instead, which is still a demo in this build.
