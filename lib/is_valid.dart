import 'dart:convert';

// Feel free to call IsValid.withAnyFunction
class IsValid {
  static bool validateEmail(String email) {
    // Email validation logic
    // This is a simple regex-based validation for demonstration
    // Replace this with a more robust email validation regex
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool validatePhoneNumber(String phoneNumber) {
    // Phone number validation logic
    // This is a basic example, you might need a more comprehensive validation
    RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  static bool validateIDNumber(String idNumber) {
    // ID number validation logic
    // Add specific validation rules for ID numbers (SSN, passport, etc.)
    // Example SSN format: ###-##-####
    RegExp ssnRegex = RegExp(r'^\d{3}-\d{2}-\d{4}$');
    return ssnRegex.hasMatch(idNumber);
  }

  static bool validateURL(String url) {
    // URL validation logic
    // Basic URL format check using regex
    RegExp urlRegex = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
    return urlRegex.hasMatch(url);
  }

  static bool validateDate(String date) {
    // Date validation logic
    // This is a basic example, validate against a specific date format
    RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegex.hasMatch(date);
  }

  static bool validateCreditCard(String cardNumber) {
    // Credit card validation logic
    // This is a simple Luhn's algorithm check for a valid credit card number
    // Replace with a more comprehensive validation algorithm
    cardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cardNumber.length != 16) return false;

    List<int> digits = cardNumber.split('').map(int.parse).toList();
    for (int i = 0; i < digits.length; i++) {
      if (i % 2 == 0) {
        digits[i] *= 2;
        if (digits[i] > 9) digits[i] -= 9;
      }
    }

    int sum = digits.reduce((value, element) => value + element);
    return sum % 10 == 0;
  }

  static bool validateIPAddress(String ipAddress) {
    // IP address validation logic
    // Basic IPv4 address format check using regex
    RegExp ipRegex = RegExp(
        r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return ipRegex.hasMatch(ipAddress);
  }

  static bool validatePassword(String password) {
    // Password validation logic
    // This is a basic example, you might want to add more password criteria
    return password.length >= 8;
  }

  static bool validatePostalCode(String postalCode) {
    // Postal code validation logic
    // Basic postal code format check using regex
    RegExp postalRegex = RegExp(r'^\d{5}(?:[-\s]\d{4})?$');
    return postalRegex.hasMatch(postalCode);
  }

  static bool validateNumericRange(int value, int min, int max) {
    // Numeric range validation logic
    // Check if the value falls within the specified range
    return value >= min && value <= max;
  }

  static bool validateSocialMediaHandle(String handle) {
    // Social media handle validation logic
    // Example: Check if it starts with '@' and contains alphanumeric characters
    RegExp handleRegex = RegExp(r'^@?[a-zA-Z0-9_]+$');
    return handleRegex.hasMatch(handle);
  }

  static bool validateFileExtension(String filename) {
    // File extension validation logic
    // Check if the filename ends with a valid file extension
    RegExp fileExtRegex =
        RegExp(r'\.(pdf|docx|jpg|png|txt)$', caseSensitive: false);
    return fileExtRegex.hasMatch(filename);
  }

// Bank account number
  static bool validateBankAccountNumber(String accountNumber) {
    // Bank account number validation logic
    // Add specific validation rules based on the bank's format
    // Example: Check for a certain length or pattern
    return accountNumber.length >= 8 && accountNumber.length <= 20;
  }

  static bool validateHexColorCode(String colorCode) {
    // Hexadecimal color code validation logic
    // Check if the input is a valid hexadecimal color code
    RegExp hexColorRegex = RegExp(r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');
    return hexColorRegex.hasMatch(colorCode);
  }

  static bool validateVIN(String vin) {
    // Vehicle Identification Number (VIN) validation logic
    // Add specific VIN validation rules based on the country of origin
    return vin.length == 17;
  }

  static bool validateISBN(String isbn) {
    // ISBN validation logic
    // Check if the input matches the ISBN format (10 or 13 digits)
    RegExp isbnRegex = RegExp(r'^\d{10}|\d{13}$');
    return isbnRegex.hasMatch(isbn);
  }

  static bool validateMACAddress(String macAddress) {
    // MAC address validation logic
    // Check if the input is a valid MAC address format (XX:XX:XX:XX:XX:XX)
    RegExp macRegex = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
    return macRegex.hasMatch(macAddress);
  }

  static bool validateCoordinates(String coordinates) {
    // Latitude and Longitude coordinates validation logic
    // Check if the input is in a valid format (e.g., 40.7128° N, 74.0060° W)
    RegExp coordRegex = RegExp(r'^-?([1-8]?[1-9]|[1-9]0)\.\d{1,6}');
    return coordRegex.hasMatch(coordinates);
  }

  static bool validateIMEINumber(String imei) {
    // IMEI number validation logic
    // Check if the input matches the IMEI format (15 digits)
    RegExp imeiRegex = RegExp(r'^\d{15}$');
    return imeiRegex.hasMatch(imei);
  }

  static bool validateCustomDataFormat(String data, String pattern) {
    // Custom data format validation logic
    // Check if the input matches a custom pattern provided by the user
    RegExp customRegex = RegExp(pattern);
    return customRegex.hasMatch(data);
  }

  static bool validateCurrencyCode(String currencyCode) {
    // Currency code validation logic
    // Check if the input matches valid currency codes (ISO 4217)
    RegExp currencyRegex = RegExp(r'^[A-Z]{3}$');
    return currencyRegex.hasMatch(currencyCode);
  }

  static bool validateTime(String time) {
    // Time validation logic
    // Check if the input matches valid time formats (24-hour, AM/PM)
    RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
    return timeRegex.hasMatch(time);
  }

  static bool validateHTMLInput(String htmlInput) {
    // HTML input validation logic
    // Check if the input contains HTML tags
    RegExp htmlRegex = RegExp(r'<[^>]+>');
    return !htmlRegex.hasMatch(htmlInput);
  }

  static bool validateDomainName(String domain) {
    // Domain name validation logic
    // Check if the input matches a valid domain name format
    RegExp domainRegex = RegExp(r'^[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');
    return domainRegex.hasMatch(domain);
  }

  static bool validateSSN(String ssn) {
    // Social Security Number (SSN) validation logic
    // Check if the input matches a valid SSN format (###-##-####)
    RegExp ssnRegex = RegExp(r'^\d{3}-\d{2}-\d{4}$');
    return ssnRegex.hasMatch(ssn);
  }

  static bool validateTwitterHashtag(String hashtag) {
    // Twitter hashtag validation logic
    // Check if the input matches a valid hashtag format (# followed by alphanumeric characters)
    RegExp hashtagRegex = RegExp(r'^#[a-zA-Z0-9_]+$');
    return hashtagRegex.hasMatch(hashtag);
  }

  static bool validateJSONData(String jsonData) {
    // JSON data validation logic
    // Check if the input is valid JSON format
    try {
      var decodedJson = json.decode(jsonData);
      return decodedJson is Map || decodedJson is List;
    } catch (e) {
      return false;
    }
  }

  static bool validateBinaryData(String binaryData) {
    // Binary data validation logic
    // Check if the input contains only 0s and 1s
    RegExp binaryRegex = RegExp(r'^[01]+$');
    return binaryRegex.hasMatch(binaryData);
  }

  static bool validateUserInputLength(
      String userInput, int minLength, int maxLength) {
    // User input length validation logic
    // Check if the input length falls within the specified range
    return userInput.length >= minLength && userInput.length <= maxLength;
  }

  static bool validateURLParameters(String url) {
    // URL query parameters validation logic
    // Check if the input contains valid URL query parameters
    RegExp urlParamsRegex = RegExp(
        r'^[?&a-zA-Z0-9]+(=[a-zA-Z0-9]*)?(&[a-zA-Z0-9]+(=[a-zA-Z0-9]*)?)*$');
    return urlParamsRegex.hasMatch(url);
  }

  static bool validateIPv6Address(String ipAddress) {
    // IPv6 address validation logic
    // Check if the input is a valid IPv6 address
    RegExp ipv6Regex = RegExp(
        r'^([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:|:([0-9a-fA-F]{1,4}:){1,5})$');
    return ipv6Regex.hasMatch(ipAddress);
  }

  static bool validateMedicalCode(String code) {
    // Medical code (e.g., ICD-10) validation logic
    // Check if the input matches a specific medical code format
    RegExp medicalCodeRegex = RegExp(r'^[A-Z]\d{2}$');
    return medicalCodeRegex.hasMatch(code);
  }

  static bool validateDNASequence(String sequence) {
    // DNA sequence data validation logic
    // Check if the input contains only valid DNA nucleotides (A, T, C, G)
    RegExp dnaRegex = RegExp(r'^[ATCG]+$');
    return dnaRegex.hasMatch(sequence);
  }

  static bool validateChecksumMD5(String checksum) {
    // MD5 checksum validation logic
    // Check if the input matches the MD5 hash format
    RegExp md5Regex = RegExp(r'^[0-9a-fA-F]{32}$');
    return md5Regex.hasMatch(checksum);
  }

  static bool validateChecksumSHA(String checksum) {
    // SHA checksum validation logic
    // Check if the input matches the SHA hash format
    RegExp shaRegex = RegExp(r'^[0-9a-fA-F]{40}$');
    return shaRegex.hasMatch(checksum);
  }

  static bool validateMIMEType(String mimeType) {
    // MIME type validation logic
    // Check if the input matches a valid MIME type format
    RegExp mimeRegex = RegExp(r'^[a-zA-Z0-9-]+\/[a-zA-Z0-9-]+$');
    return mimeRegex.hasMatch(mimeType);
  }

  static bool validateLanguageCode(String languageCode) {
    // Language code (ISO 639-1) validation logic
    // Check if the input matches a valid language code format
    RegExp languageRegex = RegExp(r'^[a-z]{2}$');
    return languageRegex.hasMatch(languageCode);
  }

  // Barcode validation
  static bool validateBarcode(String barcode) {
    // Barcode validation logic
    // Check if the input matches a valid barcode format (e.g., UPC or QR codes)
    // Add specific barcode validation rules
    return barcode.length >= 8 && barcode.length <= 20;
  }

  static bool validateUUID(String uuid) {
    // UUID (Universally Unique Identifier) validation logic
    // Check if the input matches the UUID format
    RegExp uuidRegex = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return uuidRegex.hasMatch(uuid);
  }

  static bool validateJobTitle(String jobTitle) {
    // Job title validation logic
    // Check if the input matches a valid job title format
    // Example: Only alphanumeric characters and spaces allowed
    RegExp jobTitleRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
    return jobTitleRegex.hasMatch(jobTitle);
  }

  static bool validateHTMLColor(String color) {
    // HTML color validation logic
    // Check if the input matches a valid HTML color code format
    RegExp colorRegex = RegExp(r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');
    return colorRegex.hasMatch(color);
  }

  static bool validatePostalAddress(String address) {
    // Postal address validation logic
    // Check if the input matches a valid postal address format
    // Example: Validate against common address patterns
    RegExp addressRegex = RegExp(r'^[a-zA-Z0-9\s,.-]+$');
    return addressRegex.hasMatch(address);
  }

  static bool validateRegexPattern(String input, String pattern) {
    // Regular expression pattern validation logic
    // Check if the input matches the provided regex pattern
    RegExp customRegex = RegExp(pattern);
    return customRegex.hasMatch(input);
  }

  static bool validateEncryptionKey(String key) {
    // Encryption key validation logic
    // Check if the input matches a valid encryption key format
    // Example: Verify the length or specific characters
    return key.length == 16 || key.length == 32;

    // Example: AES key lengths
  }

  static bool validateSchema(String data, String schema) {
    // XML/JSON schema validation logic
    // Check if the input data conforms to the provided schema
    // Implement schema validation based on your specific requirements
    // Example: Using third-party libraries for schema validation
    // Return true/false based on validation result
    return true;

    // Placeholder return for demonstration
  }

  static bool validateFinancialCode(String code) {
    // Financial transaction code validation logic
    // Check if the input matches a valid financial code format (e.g., SWIFT, IBAN)
    // Implement specific validation rules based on the code format
    return code.length >= 8 && code.length <= 34;

    // Placeholder validation
  }

  static bool validateTwitterHandle(String handle) {
    // Twitter handle validation logic
    // Check if the input matches a valid Twitter handle format
    // Example: Starts with '@' and contains alphanumeric characters
    RegExp twitterRegex = RegExp(r'^@?[a-zA-Z0-9_]+$');
    return twitterRegex.hasMatch(handle);
  }

  static bool validateQuery(String query) {
    // Database query string validation logic
    // Check if the input contains valid database query syntax
    // Example: Validate against common SQL syntax patterns
    RegExp queryRegex = RegExp(r'^[a-zA-Z0-9\s,.;*]+$');
    return queryRegex.hasMatch(query);
  }

  static bool validateSemanticVersioning(String version) {
    // Semantic versioning validation logic
    // Check if the input matches a valid semantic version format (X.Y.Z)
    RegExp semVerRegex = RegExp(r'^\d+\.\d+\.\d+$');
    return semVerRegex.hasMatch(version);
  }

  static bool validateTemperatureUnit(String unit) {
    // Temperature unit validation logic
    // Check if the input matches valid temperature units (e.g., Celsius, Fahrenheit)
    return unit == 'Celsius' || unit == 'Fahrenheit';

    // Placeholder validation
  }

  static bool validateBooleanValue(String value) {
    // Boolean value validation logic
    // Check if the input is a valid boolean value (true or false)
    return value.toLowerCase() == 'true' || value.toLowerCase() == 'false';
  }
}
