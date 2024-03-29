class EmailFormFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null; // Return null if the email is valid
  }
}

class PasswordFormFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    final passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long with 1 uppercase, 1 lowercase, and 1 numeric character.';
    }

    return null; // Return null if the password is valid
  }
}

class FullNameFormFieldValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required.';
    }

    final fullNameRegex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)?$');
    if (!fullNameRegex.hasMatch(value)) {
      return 'Please enter a valid full name.';
    }

    return null; // Return null if the full name is valid
  }
}

class MobileNumberValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required.';
    }

    final mobileNumberRegex = RegExp(r'^[6-9]\d{9}$');
    if (!mobileNumberRegex.hasMatch(value)) {
      return 'Please enter a valid mobile number.';
    }

    return null; // Return null if the mobile number is valid
  }
}

String abbreviateString(String input) {
  RegExp mdFormat = RegExp(r'^[A-Z]{2}-\d+$'); // Regex pattern for "MD-1" format

  // Check if the input matches the "MD-1" format, return it directly if it does
  if (mdFormat.hasMatch(input)) {
    return input;
  }

  List<String> words = input.split(' ');
  String abbreviation = '';

  bool isFirstWord = true;
  bool isHyphenEncountered = false;

  for (String word in words) {
    if (word == '-') {
      isHyphenEncountered = true;
      continue; // Skip hyphens
    }

    if (isFirstWord || isHyphenEncountered) {
      abbreviation += word[0].toUpperCase(); // Take the first character of the word
      isHyphenEncountered = false;
    }
    isFirstWord = false;
  }

  // Find the number after the hyphen and append it to the abbreviation
  RegExp regExp = RegExp(r'(\d+)$');
  Iterable<Match> matches = regExp.allMatches(input);
  if (matches.isNotEmpty) {
    Match match = matches.first;
    abbreviation += '-${match.group(0)}';
  }

  return abbreviation;
}