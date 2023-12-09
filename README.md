# IsValid

[![Pub Version](https://img.shields.io/pub/v/badges?color=blueviolet)](https://pub.dev/packages/is_valid)
[![popularity](https://img.shields.io/pub/popularity/badges?logo=dart)](https://pub.dev/packages/is_valid/score)
[![likes](https://img.shields.io/pub/likes/badges?logo=dart)](https://pub.dev/packages/is_valid/score)
[![Youtube](https://img.shields.io/badge/YouTube-FF0000?logo=youtube&logoColor=white)](https://www.youtube.com/@AbdallahAlsaifi)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-in-0e76a8)](https://www.linkedin.com/in/abdallahAlsaifi)

[![Alt text](https://bmc-cdn.nyc3.digitaloceanspaces.com/BMC-button-images/custom_images/orange_img.png)](https://www.buymeacoffee.com/abdallahalsaifi)

![Visitor Count](https://profile-counter.glitch.me/abdallahAlsaifi/count.svg)

The IsValid Package provides various methods for validating different types of data in Dart. Each method performs specific validation based on the input provided.


### To use the IsValid in your Flutter project, follow these steps:
Step 1: Import the IsValid class
```dart
import 'package:is_valid/is_valid.dart';
```
Step 2: Perform Validations
```dart
bool isValidEmail = IsValid.validateEmail('example@email.com');
bool isValidPhoneNumber = IsValid.validatePhoneNumber('1234567890');
```
### Available Validation Methods
#### Basic Usage
- `validateEmail(String email)`: Validates an email address.
- `validatePhoneNumber(String phoneNumber)`: Validates a phone number.
- `validateIDNumber(String idNumber)`: Validates an ID number.
- `validateURL(String url)`: Validates a URL.
- `validateDate(String date)`: Validates a date.
- `validateCreditCard(String cardNumber)`: Validates a credit card number.
- `validateIPAddress(String ipAddress)`: Validates an IP address.
- `validatePassword(String password)`: Validates a password.
- `validatePostalCode(String postalCode)`: Validates a postal code.
#### Advanced Usage
- `validateNumericRange(int value, int min, int max)`: Validates if a value falls within a numeric range.
- `validateSocialMediaHandle(String handle)`: Validates a social media handle.
- `validateFileExtension(String filename)`: Validates a file extension.
- `validateBankAccountNumber(String accountNumber)`: Validates a bank account number.
- `validateHexColorCode(String colorCode)`: Validates a hexadecimal color code.
- `validateISBN(String isbn)`: Validates an ISBN.
- `validateMACAddress(String macAddress)`: Validates a MAC address.
- `validateCoordinates(String coordinates)`: Validates latitude and longitude coordinates.
- `validateIMEINumber(String imei)`: Validates an IMEI number.
- `validateCustomDataFormat(String data, String pattern)`: Validates custom data against a pattern.
- `validateCurrencyCode(String currencyCode)`: Validates a currency code.
- `validateTime(String time)`: Validates a time format.
- `validateHTMLInput(String htmlInput)`: Validates HTML input.
- `validateDomainName(String domain)`: Validates a domain name.
- `validateSSN(String ssn)`: Validates a Social Security Number (SSN).
- `validateTwitterHashtag(String hashtag)`: Validates a Twitter hashtag.
- `validateJSONData(String jsonData)`: Validates JSON data.
- `validateBinaryData(String binaryData)`: Validates binary data.
- `validateUserInputLength(String userInput, int minLength, int maxLength)`: Validates user input length.
- `validateURLParameters(String url)`: Validates URL query parameters.
- `validateIPv6Address(String ipAddress)`: Validates an IPv6 address.
- `validateMedicalCode(String code)`: Validates a medical code.
- `validateDNASequence(String sequence)`: Validates a DNA sequence.
- `validateChecksumMD5(String checksum)`: Validates an MD5 checksum.
- `validateChecksumSHA(String checksum)`: Validates a SHA checksum.
- `validateMIMEType(String mimeType)`: Validates a MIME type.
- `validateLanguageCode(String languageCode)`: Validates a language code.
- `validateBarcode(String barcode)`: Validates a barcode.
- `validateUUID(String uuid)`: Validates a UUID.
- `validateJobTitle(String jobTitle)`: Validates a job title.
- `validateHTMLColor(String color)`: Validates an HTML color.
- `validatePostalAddress(String address)`: Validates a postal address.
- `validateRegexPattern(String input, String pattern)`: Validates against a custom regex pattern.
- `validateEncryptionKey(String key)`: Validates an encryption key.
- `validateSchema(String data, String schema)`: Validates against XML/JSON schema.
- `validateFinancialCode(String code)`: Validates a financial transaction code.
- `validateTwitterHandle(String handle)`: Validates a Twitter handle.
- `validateQuery(String query)`: Validates a database query string.
- `validateSemanticVersioning(String version)`: Validates a semantic version.
- `validateTemperatureUnit(String unit)`: Validates a temperature unit.
- `validateBooleanValue(String value)`: Validates a boolean value.

#### Feel free to use these methods according to your validation requirements!

### Contributors

<a href="https://github.com/abdallahAlsaifi/is_valid/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=abdallahAlsaifi/is_valid" />
</a>