
# IsValid
![GitHub License](https://img.shields.io/github/license/abdallahAlsaifi/is_valid)
![Pub Version](https://img.shields.io/pub/v/is_valid)
![Pub Popularity](https://img.shields.io/pub/popularity/is_valid)
![Pub Likes](https://img.shields.io/pub/likes/is_valid)
![Pub Points](https://img.shields.io/pub/points/is_valid)
[![Youtube](https://img.shields.io/badge/YouTube-FF0000?logo=youtube&logoColor=white)](https://www.youtube.com/@AbdallahAlsaifi)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-in-0e76a8)](https://www.linkedin.com/in/abdallahAlsaifi)

[![Alt text](https://bmc-cdn.nyc3.digitaloceanspaces.com/BMC-button-images/custom_images/orange_img.png)](https://www.buymeacoffee.com/abdallahalsaifi)

![Visitor Count](https://profile-counter.glitch.me/abdallahAlsaifi_IsValid/count.svg)

The IsValid Package provides various methods for validating different types of data in Dart. Each method performs specific validation based on the input provided.


## To use the IsValid in your Flutter project, follow these steps:
Step 1: Import the IsValid class
```dart
import 'package:is_valid/is_valid.dart';
```
Step 2: Perform Validations
```dart
bool isValidEmail = IsValid.validateEmail('example@email.com');
bool isValidPhoneNumber = IsValid.validatePhoneNumber('1234567890');
```
## Available Validation Methods

### **validateEmail**

The `validateEmail` function checks whether the provided input matches a valid email address format.

Parameters:
- `email` (String): The email address string to be validated.

Returns:
- `true` if the `email` matches the standard email address format; otherwise, `false`.

Example:
```dart
String emailAddress = 'example@email.com';

if (validateEmail(emailAddress)) {
  print('Email address is valid.');
} else {
  print('Invalid email address format.');
}
```

### **validatePhoneNumber**
Validates a phone number based on the provided country code.

Parameters:

- `phoneNumber`: The phone number to be validated.
- `countryCode`: An enumerated type representing the country code.

Example:
```dart
bool isValidPhoneNumber = YourClassName.validatePhoneNumber(
  phoneNumber: '+1234567890',
  countryCode: CountryCode.US, // Use the appropriate country code enum value
);
```
### **Password Validation**
The `validatePassword` function checks the validity of a password based on specified validation options.

Parameters:
- `password` (String): The password to be validated.
- `options` (Map<PasswordValidation, dynamic>): A map containing validation rules for the password.
  Available option:
- PasswordValidation.minLength: Minimum length for the password.
- PasswordValidation.maxLength: Maximum length for the password.
- PasswordValidation.disallowLetters: Disallow letters in the password.
- PasswordValidation.disallowNumbers: Disallow numbers in the password.
- PasswordValidation.disallowSpecialChars: Disallow special characters in the password.

Example:
```dart
String userPassword = 'SecurePwd123';

Map<PasswordValidation, dynamic> validationOptions = {
  PasswordValidation.minLength: 8,
  PasswordValidation.disallowSpecialChars: false,
  PasswordValidation.disallowNumbers: false,
  PasswordValidation.disallowLetters: false,
};

if (validatePassword(userPassword, validationOptions)) {
print('Password is valid.');
} else {
print('Password is invalid.');
}
```
*************
### **ID Number Validator**
This function, `validateIDNumber`, is designed to validate identification numbers based on country-specific patterns. It accepts an ID number string along with a `CountryCode` and an optional `IDType`, checking the provided ID against predefined regular expression patterns associated with specific countries.

Parameters:
- `idNumber` (String): The ID number to be validated.
- `countryCode` (CountryCode enum): The country code enum representing the country associated with the ID number.
- `idType` (IDType enum, optional): Specifies the type of ID (default value is `IDType.ID`).

Example:
```dart
String idNumber = '1234567890'; // Sample ID number
CountryCode countryCode = CountryCode.Af; // Sample country code

bool isValid = validateIDNumber(idNumber, countryCode);

if (isValid) {
print('The ID number is valid.');
} else {
print('The ID number is invalid.');
}
```
### **URL Validator**
The `validateURL` function is designed to check the format of a URL string using a basic regular expression pattern. It ensures that the provided URL matches a standard URL format.

Parameters:
- `url` (String): The URL string to be validated.

Example:
```dart
String url = 'https://www.example.com'; // Sample URL

bool isValidURL = validateURL(url: url);

if (isValidURL) {
print('The URL is valid.');
} else {
print('The URL is invalid.');
}
```
### **Date Validator**
The `validateDate` function is designed to validate date inputs in various formats, checking against a specified mask or as a `DateTime` object.

Parameters:
- `date` (dynamic): The date value to be validated. It can be a `DateTime` object or a string representing a date.
- `mask` (String): (Optional) A string specifying the format of the date string. Defaults to `'yyyy-MM-dd'`.

Example:
```dart
// Sample date and mask
dynamic date1 = DateTime.now();
String date2 = '2023-12-31';
String mask = 'yyyy-MM-dd';

bool isValidDate1 = validateDate(date1);
bool isValidDate2 = validateDate(date2, mask);

if (isValidDate1) {
print('Date 1 is a valid DateTime object.');
} else {
print('Date 1 is invalid.');
}

if (isValidDate2) {
print('Date 2 is a valid date according to the mask.');
} else {
print('Date 2 is invalid or does not match the specified mask.');
}
```



### **Card Type Detector**
The `detectCardType` function is used to identify the type of credit card based on the provided card number's initial digits.

Parameters:
- `cardNumber` (String): The credit card number whose type needs to be detected.

Example:
```dart
String cardNumber = '4532764251581234';

CardType type = detectCardType(cardNumber);

switch (type) {
case CardType.Visa:
print('Visa card detected.');
break;
case CardType.MasterCard:
print('MasterCard detected.');
break;
case CardType.AmericanExpress:
print('American Express card detected.');
break;
case CardType.Discover:
print('Discover card detected.');
break;
case CardType.Other:
print('Other card type detected.');
break;
}
```

### **Credit Card Validation**
The `validateCreditCard` function implements the Luhn algorithm to validate credit card numbers.

Parameters:
- `cardNumber` (String): The credit card number to be validated.

Example:
```dart
String cardNumber = '4532764251581234';

if (validateCreditCard(cardNumber)) {
print('Credit card number is valid.');
} else {
print('Credit card number is invalid.');
}
```

### **IPv4 Address Validation**
The `validateIP4Address` function is used to validate IPv4 addresses.

Parameters:
- `ipAddress` (String): The IPv4 address to be validated.

Example:
```dart
String ipAddress = '192.168.0.1';

if (validateIP4Address(ipAddress)) {
print('IPv4 address is valid.');
} else {
print('IPv4 address is invalid.');
}
```

### **IPv6 Address Validation**
The `validateIP6Address` function is used to validate IPv6 addresses.

Parameters:
- `ipAddress` (String): The IPv6 address to be validated.

Example:
```dart
String ipAddress = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';

if (validateIPv6Address(ipAddress)) {
print('IPv6 address is valid.');
} else {
print('IPv6 address is invalid.');
}
```


### **Postal Code Validation**
The `validatePostalCode` function checks the validity of a postal code based on specified validation options.

Parameters:
- `postalCode` (String): The postal code to be validated.
- `option` (PostalCodeValidation): An enum representing the type of postal code validation to perform.
- `customRegex` (String, optional): A custom regular expression to use for validation when the option is set to `PostalCodeValidation.Custom`.

Available Options:
- `PostalCodeValidation.USZipCode`: Validates US ZIP codes.
- `PostalCodeValidation.UKPostalCode`: Validates UK postal codes.
- `PostalCodeValidation.Custom`: Allows custom validation using a provided regular expression.

Example:
```dart
 String userPostalCode = '94107';

if (validatePostalCode(
userPostalCode, option: PostalCodeValidation.USZipCode)) {
print('Postal code is valid.');
} else {
print('Postal code is invalid.');
}
```
### **Numeric Range Validation**

The `validateNumericRange` function checks if a given value falls within a specified numeric range.

Parameters:
- `value` (int): The value to be validated.
- `min` (int): The minimum value allowed in the range (inclusive).
- `max` (int): The maximum value allowed in the range (inclusive).

Returns:
- `true` if the `value` falls within the specified range, otherwise `false`.

Example:
```dart
int userValue = 25;
int minValue = 10;
int maxValue = 50;

if (validateNumericRange(value: userValue, min: minValue, max: maxValue)) {
print('Value is within the specified range.');
} else {
print('Value is outside the specified range.');
}
```
### **Social Media Handle Validation**

The `validateSocialMediaHandle` function checks the validity of a social media handle.

Parameters:
- `handle` (String): The social media handle to be validated.

Returns:
- `true` if the `handle` matches the specified format, otherwise `false`.

Example:
```dart
String userHandle = '@my_social_handle';

if (validateSocialMediaHandle(handle: userHandle)) {
print('Social media handle is valid.');
} else {
print('Invalid social media handle format.');
}
```
### **File Extension Validation**

The `validateFileExtension` function validates the file extension of a given filename.

Parameters:
- `filename` (String): The name of the file to validate.
- `validExtensions` (Set<String>, optional): A set of valid file extensions to compare against. Defaults to common file extensions: `.pdf`, `.docx`, `.jpg`, `.png`, `.txt`.

Returns:
- `true` if the file extension is among the specified `validExtensions`, otherwise `false`.

Example:
```dart
String userFile = 'document.pdf';

if (validateFileExtension(userFile)) {
print('File extension is valid.');
} else {
print('Invalid file extension.');
}
```
### **Bank Account Number Validation**

The `validateBankAccountNumber` function checks the validity of a bank account number based on specified length and optional pattern.

Parameters:
- `accountNumber` (String): The bank account number to be validated.
- `minLength` (int, optional): The minimum allowed length for the account number. Defaults to 8.
- `maxLength` (int, optional): The maximum allowed length for the account number. Defaults to 20.
- `regExpPattern` (String, optional): A custom regular expression pattern to use for additional validation.

Returns:
- `true` if the `accountNumber` satisfies the length constraints and, if provided, matches the specified regular expression pattern; otherwise, `false`.

Example:
```dart
String userAccountNumber = '1234567890';

if (validateBankAccountNumber(userAccountNumber)) {
print('Bank account number is valid.');
} else {
print('Bank account number is invalid.');
}
```
### **Hexadecimal Color Code Validation**

The `validateHexColorCode` function checks whether a provided string represents a valid hexadecimal color code.

Parameters:
- `colorCode` (String): The color code string to be validated.

Returns:
- `true` if the `colorCode` represents a valid hexadecimal color code; otherwise, `false`.

Example:
```dart
String userColorCode = '#1a2b3c';

if (validateHexColorCode(colorCode: userColorCode)) {
print('Hex color code is valid.');
} else {
print('Hex color code is invalid.');
}
```
### **VIN Validation**

The `validateVIN` function checks whether a provided string conforms to the standard VIN (Vehicle Identification Number) length.

Parameters:
- `vin` (String): The VIN string to be validated.
- `vinLength` (int): The expected length of the VIN.

Returns:
- `true` if the `vin` string matches the expected `vinLength`; otherwise, `false`.

Example:
```dart
String userVIN = 'ABC123XYZ456DEF78';

if (validateVIN(vin: userVIN, vinLength: 17)) {
print('Valid VIN.');
} else {
print('Invalid VIN.');
}
```
### **ISBN Validation**

The `validateISBN` function validates whether a provided string adheres to the ISBN (International Standard Book Number) format.

Parameters:
- `isbn` (String): The ISBN string to be validated.

Returns:
- `true` if the `isbn` string matches the ISBN format (10 or 13 digits); otherwise, `false`.

Example:
```dart
String userISBN = '9780141036144'; // Replace with user's ISBN

if (validateISBN(userISBN)) {
print('Valid ISBN.');
} else {
print('Invalid ISBN.');
}
```
### **MAC Address Validation**

The `validateMACAddress` function checks if a provided string adheres to the valid MAC address format (XX:XX:XX:XX:XX:XX).

Parameters:
- `macAddress` (String): The MAC address string to be validated.

Returns:
- `true` if the `macAddress` string represents a valid MAC address; otherwise, `false`.

Example:
```dart
String userMAC = '00:1A:2B:3C:4D:5E'; // Replace with user's MAC address

if (validateMACAddress(userMAC)) {
print('Valid MAC address.');
} else {
print('Invalid MAC address.');
}
```
### **Coordinates Validation**

The `validateCoordinates` function validates a string to determine if it represents valid geographical coordinates.

Parameters:
- `coordinates` (String): The string to be validated as coordinates.

Returns:
- `true` if the `coordinates` string represents valid geographical coordinates; otherwise, `false`.

Example:
```dart
String userCoordinates = '37.7749'; // Replace with user's coordinates

if (validateCoordinates(userCoordinates)) {
print('Valid coordinates.');
} else {
print('Invalid coordinates.');
}
```

### **IMEI Number Validation**

The `validateIMEINumber` function verifies whether a given string matches the IMEI format (15 digits).

Parameters:
- `imei` (String): The string to be validated as an IMEI number.

Returns:
- `true` if the `imei` string matches the IMEI format (15 digits); otherwise, `false`.

Example:
```dart
String userIMEI = '123456789012345'; // Replace with user's IMEI number

if (validateIMEINumber(userIMEI)) {
print('Valid IMEI number.');
} else {
print('Invalid IMEI number.');
}
```
### **Custom Data Format Validation**

The `validateCustomDataFormat` function checks whether a provided string matches a custom pattern specified by the user.

Parameters:
- `data` (String): The data string to be validated.
- `pattern` (String): The custom regular expression pattern to match against the `data`.

Returns:
- `true` if the `data` string matches the provided `pattern`; otherwise, `false`.

Example:
```dart
String userData = 'CustomData123'; // Replace with user's data
String userPattern = r'^[A-Za-z0-9]+$'; // Replace with user's custom pattern

if (validateCustomDataFormat(userData, userPattern)) {
print('Data format is valid.');
} else {
print('Data format is invalid.');
}
```


### **Currency Code Validation**

The `validateCurrencyCode` function validates whether a provided string matches a valid currency code based on ISO 4217.

Parameters:
- `currencyCode` (String): The currency code string to be validated.

Returns:
- `true` if the `currencyCode` matches a valid currency code; otherwise, `false`.

Example:
```dart
String userCurrencyCode = 'USD';

if (validateCurrencyCode(userCurrencyCode)) {
print('Currency code is valid.');
} else {
print('Currency code is invalid.');
}
```

### **Time Validation**

The `validateTime` function checks if a given string represents a valid time according to the specified format.

Parameters:
- `time` (String): The time string to be validated.
- `format` (TimeFormat): An enum representing various time formats.

Returns:
- `true` if the `time` matches the specified format; otherwise, `false`.

Example:
```dart
String userTime = '13:45';

if (validateTime(userTime, format: TimeFormat.HH_MM_24)) {
print('Time is valid.');
} else {
print('Time is invalid.');
}
```

### **HTML Input Validation**

The `validateHTMLInput` function checks if an input string contains HTML tags.

Parameters:
- `htmlInput` (String): The input string to be validated.

Returns:
- `true` if the `htmlInput` doesn't contain HTML tags; otherwise, `false`.

Example:
```dart
String userInput = '<p>Hello!</p>';

if (validateHTMLInput(userInput)) {
print('Input does not contain HTML tags.');
} else {
print('Input contains HTML tags.');
}
```



### **Domain Name Validation**

The `validateDomainName` function verifies whether the given input string matches a valid domain name format.

Parameters:
- `domain` (String): The domain name string to be validated.

Returns:
- `true` if the `domain` matches a valid domain name format; otherwise, `false`.

Example:
```dart
String userDomain = 'example.com';

if (validateDomainName(userDomain)) {
print('Domain name is valid.');
} else {
print('Invalid domain name format.');
}
```

### **Social Security Number (SSN) Validation**

The `validateSSN` function checks if the provided input matches a valid Social Security Number format (###-##-####).

Parameters:
- `ssn` (String): The SSN string to be validated.

Returns:
- `true` if the `ssn` matches a valid SSN format; otherwise, `false`.

Example:
```dart
String userSSN = '123-45-6789';

if (validateSSN(userSSN)) {
print('SSN is valid.');
} else {
print('Invalid SSN format.');
}
```

### **Twitter Hashtag Validation**

The `validateTwitterHashtag` function verifies whether the given input matches a valid Twitter hashtag format (# followed by alphanumeric characters).

Parameters:
- `hashtag` (String): The hashtag string to be validated.

Returns:
- `true` if the `hashtag` matches a valid Twitter hashtag format; otherwise, `false`.

Example:
```dart
String userHashtag = '#MyHashtag';

if (validateTwitterHashtag(userHashtag)) {
print('Hashtag is valid.');
} else {
print('Invalid hashtag format.');
}
```

### **JSON Data Validation**

The `validateJSONData` function checks if the provided input is in valid JSON format.

Parameters:
- `jsonData` (String): The JSON data string to be validated.

Returns:
- `true` if the `jsonData` is in valid JSON format; otherwise, `false`.

Example:
```dart
String userJSONData = '{"name": "John", "age": 30}';

if (validateJSONData(userJSONData)) {
print('Valid JSON data.');
} else {
print('Invalid JSON format.');
}
```


### **Binary Data Validation**

The `validateBinaryData` function verifies whether the given input contains only binary data (0s and 1s).

Parameters:
- `binaryData` (String): The binary data string to be validated.

Returns:
- `true` if the `binaryData` contains only 0s and 1s; otherwise, `false`.

Example:
```dart
String binaryInput = '101010101';

if (validateBinaryData(binaryInput)) {
print('Binary data is valid.');
} else {
print('Invalid binary data format.');
}
```

### **User Input Length Validation**

The `validateUserInputLength` function checks if the length of the provided input falls within a specified range.

Parameters:
- `userInput` (String): The user input string to be validated.
- `minLength` (int): The minimum length allowed for the input.
- `maxLength` (int): The maximum length allowed for the input.

Returns:
- `true` if the length of `userInput` falls within the specified range; otherwise, `false`.

Example:
```dart
String input = 'example';

if (validateUserInputLength(input, 5, 10)) {
print('Input length is within the specified range.');
} else {
print('Input length is not within the specified range.');
}
```

### **URL Parameters Validation**

The `validateURLParameters` function checks if the provided input contains valid URL query parameters.

Parameters:
- `url` (String): The URL string to be validated.

Returns:
- `true` if the `url` contains valid URL query parameters; otherwise, `false`.

Example:
```dart
String urlString = 'https://example.com/api?param1=value1&param2=value2';

if (validateURLParameters(urlString)) {
print('URL parameters are valid.');
} else {
print('Invalid URL parameters.');
}
```

### **Medical Code Validation**

The `validateMedicalCode` function validates whether the input matches a specific medical code format (e.g., ICD-10).

Parameters:
- `code` (String): The medical code string to be validated.

Returns:
- `true` if the `code` matches the specified medical code format; otherwise, `false`.

Example:
```dart
String medicalCode = 'A23';

if (validateMedicalCode(medicalCode)) {
print('Medical code is valid.');
} else {
print('Invalid medical code format.');
}
```

### **DNA Sequence Data Validation**

The `validateDNASequence` function checks if the provided input contains only valid DNA nucleotides (A, T, C, G).

Parameters:
- `sequence` (String): The DNA sequence string to be validated.

Returns:
- `true` if the `sequence` contains only valid DNA nucleotides; otherwise, `false`.

Example:
```dart
String dnaSequence = 'ATGCTA';

if (validateDNASequence(dnaSequence)) {
print('DNA sequence is valid.');
} else {
print('Invalid DNA sequence format.');
}
```


### **MD5 Checksum Validation**
The `validateChecksumMD5` function checks whether the provided input matches the MD5 hash format.

Parameters:
- `checksum` (String): The checksum string to be validated.

Returns:
- `true` if the `checksum` matches the MD5 hash format; otherwise, `false`.

Example:
```dart
String md5Checksum = '5d41402abc4b2a76b9719d911017c592';

if (validateChecksumMD5(md5Checksum)) {
print('MD5 checksum is valid.');
} else {
print('Invalid MD5 checksum format.');
}
```

### **SHA Checksum Validation**
The `validateChecksumSHA` function verifies whether the provided input matches the SHA hash format.

Parameters:
- `checksum` (String): The checksum string to be validated.

Returns:
- `true` if the `checksum` matches the SHA hash format; otherwise, `false`.

Example:
```dart
String shaChecksum = '2ef7bde608ce5404e97d5f042f95f89f1c232871';

if (validateChecksumSHA(shaChecksum)) {
print('SHA checksum is valid.');
} else {
print('Invalid SHA checksum format.');
}
```

### **MIME Type Validation**
The `validateMIMEType` function checks if the provided input matches a valid MIME type format.

Parameters:
- `mimeType` (String): The MIME type string to be validated.

Returns:
- `true` if the `mimeType` matches a valid MIME type format; otherwise, `false`.

Example:
```dart
String mimeType = 'application/json';

if (validateMIMEType(mimeType)) {
print('MIME type is valid.');
} else {
print('Invalid MIME type format.');
}
```

### **Language Code Validation**
The `validateLanguageCode` function verifies whether the provided input matches a valid language code format (ISO 639-1).

Parameters:
- `languageCode` (String): The language code string to be validated.

Returns:
- `true` if the `languageCode` matches a valid language code format; otherwise, `false`.

Example:
```dart
String languageCode = 'en';

if (validateLanguageCode(languageCode)) {
print('Language code is valid.');
} else {
print('Invalid language code format.');
}
```

### **Barcode Validation**
The `validateBarcode` function checks if the provided input matches a valid barcode format (e.g., UPC or QR codes).

Parameters:
- `barcode` (String): The barcode string to be validated.

Returns:
- `true` if the `barcode` matches a valid barcode format; otherwise, `false`.

Example:
```dart
String barcode = '012345678912';

if (validateBarcode(barcode)) {
print('Barcode is valid.');
} else {
print('Invalid barcode format.');
}
```

### **UUID Validation**
The `validateUUID` function validates whether the provided input matches the UUID format.

Parameters:
- `uuid` (String): The UUID string to be validated.

Returns:
- `true` if the `uuid` matches the UUID format; otherwise, `false`.

Example:
```dart
String uuid = '550e8400-e29b-41d4-a716-446655440000';

if (validateUUID(uuid)) {
print('UUID is valid.');
} else {
print('Invalid UUID format.');
}
```


### **validateJobTitle**

The `validateJobTitle` function validates whether the provided input adheres to a valid job title format.

Parameters:
- `jobTitle` (String): The job title string to be validated.

Returns:
- `true` if the `jobTitle` contains only alphanumeric characters and spaces; otherwise, `false`.

Example:
```dart
String jobTitle = 'Software Engineer';

if (validateJobTitle(jobTitle)) {
print('Job title is valid.');
} else {
print('Invalid job title format.');
}
```

### **validateHTMLColor**

The `validateHTMLColor` function validates whether the provided input matches a valid HTML color code format.

Parameters:
- `color` (String): The HTML color code string to be validated.

Returns:
- `true` if the `color` matches the HTML color code format; otherwise, `false`.

Example:
```dart
String color = '#FFA500';

if (validateHTMLColor(color)) {
print('HTML color is valid.');
} else {
print('Invalid HTML color code format.');
}
```

### **validatePostalAddress**

The `validatePostalAddress` function validates whether the provided input matches a valid postal address format.

Parameters:
- `address` (String): The postal address string to be validated.

Returns:
- `true` if the `address` matches the valid postal address format; otherwise, `false`.

Example:
```dart
String address = '123 Main St, City, Country';

if (validatePostalAddress(address)) {
print('Postal address is valid.');
} else {
print('Invalid postal address format.');
}
```

### **validateRegexPattern**

The `validateRegexPattern` function validates whether the provided input matches a custom regex pattern.

Parameters:
- `input` (String): The input string to be validated.
- `pattern` (String): The custom regex pattern to match against the input.

Returns:
- `true` if the `input` matches the provided `pattern`; otherwise, `false`.

Example:
```dart
String input = 'example@email.com';
String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

if (validateRegexPattern(input, pattern)) {
print('Input matches the custom regex pattern.');
} else {
print('Input does not match the custom regex pattern.');
}
```

### **validateEncryptionKey**

The `validateEncryptionKey` function validates whether the provided input matches a valid encryption key format.

Parameters:
- `key` (String): The encryption key string to be validated.

Returns:
- `true` if the `key` length is either 16 or 32 characters; otherwise, `false`.

Example:
```dart
String key = 'abcdefghijklmnop';

if (validateEncryptionKey(key)) {
print('Encryption key is valid.');
} else {
print('Invalid encryption key format.');
}
```


### **validateFinancialCode**

The `validateFinancialCode` function validates whether the provided input matches a valid financial transaction code format (e.g., SWIFT, IBAN).

Parameters:
- `code` (String): The financial transaction code string to be validated.

Returns:
- `true` if the `code` length is between 8 and 34 characters; otherwise, `false`.

Example:
```dart
String financialCode = 'SWIFT1234';

if (validateFinancialCode(financialCode)) {
print('Financial code is valid.');
} else {
print('Invalid financial code format.');
}
```

### **validateTwitterHandle**

The `validateTwitterHandle` function validates whether the provided input matches a valid Twitter handle format.

Parameters:
- `handle` (String): The Twitter handle string to be validated.

Returns:
- `true` if the `handle` starts with '@' and contains only alphanumeric characters and underscores; otherwise, `false`.

Example:
```dart
String twitterHandle = '@example_user';

if (validateTwitterHandle(twitterHandle)) {
print('Twitter handle is valid.');
} else {
print('Invalid Twitter handle format.');
}
```

### **validateQuery**

The `validateQuery` function validates whether the provided input contains valid database query syntax.

Parameters:
- `query` (String): The database query string to be validated.

Returns:
- `true` if the `query` contains only alphanumeric characters, spaces, and common SQL syntax characters (e.g., `,`, `;`, `*`); otherwise, `false`.

Example:
```dart
String databaseQuery = 'SELECT * FROM table';

if (validateQuery(databaseQuery)) {
print('Database query is valid.');
} else {
print('Invalid database query syntax.');
}
```

### **validateSemanticVersioning**

The `validateSemanticVersioning` function validates whether the provided input matches a valid semantic version format (X.Y.Z).

Parameters:
- `version` (String): The semantic version string to be validated.

Returns:
- `true` if the `version` matches the X.Y.Z format; otherwise, `false`.

Example:
```dart
String semVersion = '1.2.3';

if (validateSemanticVersioning(semVersion)) {
print('Semantic version is valid.');
} else {
print('Invalid semantic version format.');
}
```

### **validateTemperatureUnit**

The `validateTemperatureUnit` function validates whether the provided input matches a valid temperature unit.

Parameters:
- `unit` (String): The temperature unit string to be validated.
- `allowCustomUnit` (bool): Flag indicating whether custom units are allowed (default is `false`).

Returns:
- `true` if the `unit` is either 'celsius' or 'fahrenheit' (or a custom unit if `allowCustomUnit` is `true`); otherwise, `false`.

Example:
```dart
String temperatureUnit = 'celsius';

if (validateTemperatureUnit(temperatureUnit, allowCustomUnit: true)) {
print('Temperature unit is valid.');
} else {
print('Invalid temperature unit.');
}
```

### **validateBooleanValue**

The `validateBooleanValue` function validates whether the provided input is a valid boolean value ('true' or 'false').

Parameters:
- `value` (String): The boolean value string to be validated.

Returns:
- `true` if the `value` is 'true' or 'false' (case insensitive); otherwise, `false`.

Example:
```dart
String booleanValue = 'True';

if (validateBooleanValue(booleanValue)) {
print('Boolean value is valid.');
} else {
print('Invalid boolean value.');
}
```


#### Feel free to use these methods according to your validation requirements!

### Contributors

<a href="https://github.com/abdallahAlsaifi/is_valid/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=abdallahAlsaifi/is_valid" />
</a>