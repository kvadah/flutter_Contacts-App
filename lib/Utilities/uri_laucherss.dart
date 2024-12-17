import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

Future<void> sendSMS(String phoneNumber) async {
  final Uri smsUri =
      Uri(scheme: 'sms', path: phoneNumber); // No query parameters
  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    throw 'Could not launch $smsUri';
  }
}

Future<void> sendEmail(String emailAddress) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: emailAddress, // Recipient email
  );

  try {
    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $emailUri';
    }
    // ignore: empty_catches
  } catch (e) {}
}
