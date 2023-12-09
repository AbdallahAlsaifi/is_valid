import 'dart:convert';

enum TimeFormat {
  HH_MM_24, // 24-hour format (00:00 - 23:59)
  HH_MM_AM_PM, // AM/PM format (12-hour format)
  HH_MM_SS_24, // 24-hour format with seconds (00:00:00 - 23:59:59)
  HH_MM_SS_AM_PM, // AM/PM format with seconds (12-hour format)
  HH_MM_SS_MS_24, // 24-hour format with milliseconds (00:00:00.000 - 23:59:59.999)
  // Add more formats as needed
}

enum CardType { Visa, MasterCard, AmericanExpress, Discover, Other }

enum SubdomainType { None, Alphabetic, Numeric, AlphaNumeric }

enum PasswordValidation {
  minLength,
  maxLength,
  disallowLetters,
  disallowNumbers,
  disallowSpecialChars
}

enum PostalCodeValidation {
  USZipCode,
  UKPostalCode,
  Custom,
}

enum CountryCode {
  af,
  am,
  az,
  bh,
  bd,
  bt,
  bn,
  kh,
  cn,
  cy,
  ge,
  In,
  id,
  ir,
  iq,
  jp,
  jo,
  kz,
  kp,
  kr,
  kw,
  kg,
  la,
  lb,
  mo,
  my,
  mv,
  mn,
  mm,
  np,
  om,
  pk,
  ps,
  ph,
  qa,
  sa,
  sg,
  lk,
  sy,
  tw,
  tj,
  th,
  tl,
  tr,
  tm,
  ae,
  uz,
  vn,
  ye,
  dz,
  ao,
  bj,
  bw,
  bf,
  bi,
  cv,
  cm,
  cf,
  td,
  km,
  cd,
  dj,
  eg,
  gq,
  er,
  et,
  ga,
  gm,
  gh,
  gn,
  gw,
  ke,
  ls,
  lr,
  ly,
  mg,
  mw,
  ml,
  mr,
  mu,
  ma,
  mz,
  na,
  ne,
  ng,
  rw,
  st,
  sn,
  sc,
  sl,
  so,
  za,
  ss,
  sd,
  sz,
  tz,
  tg,
  tn,
  ug,
  zm,
  zw,
  al,
  ad,
  at,
  by,
  be,
  ba,
  bg,
  hr,
  cz,
  dk,
  ee,
  fi,
  de,
  gr,
  hu,
  Is,
  ie,
  it,
  lv,
  li,
  lt,
  lu,
  mk,
  mt,
  md,
  mc,
  me,
  nl,
  no,
  pl,
  pt,
  ro,
  ru,
  sm,
  rs,
  sk,
  si,
  es,
  se,
  ch,
  ua,
  gb,
  ca,
  us,
  mx,
  gt,
  bz,
  sv,
  hn,
  ni,
  cr,
  pa,
  cu,
  Do,
  ht,
  jm,
  tt,
  kn,
  lc,
  vc,
  bb,
  gd,
  ag,
  bs,
  dm,
  ar,
  bo,
  br,
  cl,
  co,
  ec,
  fk,
  gf,
  gy,
  py,
  pe,
  gs,
  sr,
  uy,
  ve,
  an,
}

enum IDType {
  ID,
}

// Feel free to call IsValid.withAnyFunction
class IsValid {
  bool isDigit(String c) {
    return c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  }

  bool isLetter(String c) {
    return (c.codeUnitAt(0) >= 65 && c.codeUnitAt(0) <= 90) ||
        (c.codeUnitAt(0) >= 97 && c.codeUnitAt(0) <= 122);
  }

  bool isLetterOrDigit(String c) {
    return isLetter(c) || isDigit(c);
  }

  bool isAtom(String c, bool allowInternational) {
    return c.codeUnitAt(0) < 128
        ? isLetterOrDigit(c) || "!#\$%&'*+-/=?^_`{|}~".contains(c)
        : allowInternational;
  }

  bool isDomain(String c, bool allowInternational, SubdomainType domainType) {
    if (c.codeUnitAt(0) < 128) {
      if (isLetter(c) || c == '-') {
        domainType = SubdomainType.Alphabetic;
        return true;
      }

      if (isDigit(c)) {
        domainType = SubdomainType.Numeric;
        return true;
      }

      return false;
    }

    if (allowInternational) {
      domainType = SubdomainType.Alphabetic;
      return true;
    }

    return false;
  }

  bool isDomainStart(
      String c, bool allowInternational, SubdomainType domainType) {
    if (c.codeUnitAt(0) < 128) {
      if (isLetter(c)) {
        domainType = SubdomainType.Alphabetic;
        return true;
      }

      if (isDigit(c)) {
        domainType = SubdomainType.Numeric;
        return true;
      }

      domainType = SubdomainType.None;
      return false;
    }

    if (allowInternational) {
      domainType = SubdomainType.Alphabetic;
      return true;
    }

    domainType = SubdomainType.None;
    return false;
  }

  bool skipAtom(String text, bool allowInternational, int index) {
    int startIndex = index;

    while (index < text.length && isAtom(text[index], allowInternational)) {
      index++;
    }

    return index > startIndex;
  }

  bool skipSubDomain(String text, bool allowInternational, int index,
      SubdomainType domainType) {
    int startIndex = index;

    if (!isDomainStart(text[index], allowInternational, domainType)) {
      return false;
    }

    index++;

    while (index < text.length &&
        isDomain(text[index], allowInternational, domainType)) {
      index++;
    }

    return (index - startIndex) < 64 && text[index - 1] != '-';
  }

// Other helper functions follow...

  static bool validateEmail(String email) {
    if (email.isEmpty || email.length >= 255) {
      return false;
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  static bool validatePhoneNumber(
      {required String phoneNumber, required CountryCode countryCode}) {
    Map<String, String> countryCodes = {
      'af': r'^\+93[0-9]{9}$', // Afghanistan
      'am': r'^\+374[0-9]{7}$', // Armenia
      'az': r'^\+994[0-9]{8}$', // Azerbaijan
      'bh': r'^\+973[0-9]{7,8}$', // Bahrain
      'bd': r'^\+880[0-9]{8}$', // Bangladesh
      'bt': r'^\+975[0-9]{6}$', // Bhutan
      'bn': r'^\+673[0-9]{7}$', // Brunei
      'kh': r'^\+855[0-9]{7,8}$', // Cambodia
      'cn': r'^\+86[0-9]{11}$', // China
      'cy': r'^\+357[0-9]{8}$', // Cyprus
      'ge': r'^\+995[0-9]{8}$', // Georgia
      'in': r'^\+91[0-9]{10}$', // India
      'id': r'^\+62[0-9]{9,11}$', // Indonesia
      'ir': r'^\+98[0-9]{9,10}$', // Iran
      'iq': r'^\+964[0-9]{7,10}$', // Iraq
      'il': r'^\+972[0-9]{9}$', // Israel
      'jp': r'^\+81[0-9]{10}$', // Japan
      'jo': r'^\+962[0-9]{7,8}$', // Jordan
      'kz': r'^\+7[0-9]{10}$', // Kazakhstan
      'kp': r'^\+850[0-9]{8,9}$', // North Korea
      'kr': r'^\+82[0-9]{9,10}$', // South Korea
      'kw': r'^\+965[0-9]{7}$', // Kuwait
      'kg': r'^\+996[0-9]{9}$', // Kyrgyzstan
      'la': r'^\+856[0-9]{7,8}$', // Laos
      'lb': r'^\+961[0-9]{7,8}$', // Lebanon
      'mo': r'^\+853[0-9]{7}$', // Macau
      'my': r'^\+60[0-9]{9,10}$', // Malaysia
      'mv': r'^\+960[0-9]{6,7}$', // Maldives
      'mn': r'^\+976[0-9]{7}$', // Mongolia
      'mm': r'^\+95[0-9]{8,9}$', // Myanmar (Burma)
      'np': r'^\+977[0-9]{9}$', // Nepal
      'om': r'^\+968[0-9]{7,8}$', // Oman
      'pk': r'^\+92[0-9]{10}$', // Pakistan
      'ps': r'^\+970[0-9]{7,8}$', // Palestine
      'ph': r'^\+63[0-9]{10}$', // Philippines
      'qa': r'^\+974[0-9]{7,8}$', // Qatar
      'sa': r'^\+966[0-9]{9}$', // Saudi Arabia
      'sg': r'^\+65[0-9]{7,8}$', // Singapore
      'lk': r'^\+94[0-9]{9}$', // Sri Lanka
      'sy': r'^\+963[0-9]{8}$', // Syria
      'tw': r'^\+886[0-9]{8,9}$', // Taiwan
      'tj': r'^\+992[0-9]{8}$', // Tajikistan
      'th': r'^\+66[0-9]{9}$', // Thailand
      'tl': r'^\+670[0-9]{7}$', // Timor-Leste
      'tr': r'^\+90[0-9]{10}$', // Turkey
      'tm': r'^\+993[0-9]{8}$', // Turkmenistan
      'ae': r'^\+971[0-9]{8}$', // United Arab Emirates
      'uz': r'^\+998[0-9]{7}$', // Uzbekistan
      'vn': r'^\+84[0-9]{9,10}$', // Vietnam
      'ye': r'^\+967[0-9]{7}$', // Yemen
      'al': r'^\+355[0-9]{8}$', // Albania
      'ad': r'^\+376[0-9]{6}$', // Andorra
      'at': r'^\+43[0-9]{9,10}$', // Austria
      'by': r'^\+375[0-9]{9}$', // Belarus
      'be': r'^\+32[0-9]{8,9}$', // Belgium
      'ba': r'^\+387[0-9]{7,8}$', // Bosnia and Herzegovina
      'bg': r'^\+359[0-9]{8,9}$', // Bulgaria
      'hr': r'^\+385[0-9]{8,9}$', // Croatia
      'cy': r'^\+357[0-9]{8}$', // Cyprus
      'cz': r'^\+420[0-9]{9,10}$', // Czech Republic
      'dk': r'^\+45[0-9]{8}$', // Denmark
      'ee': r'^\+372[0-9]{7,8}$', // Estonia
      'fo': r'^\+298[0-9]{5}$', // Faroe Islands
      'fi': r'^\+358[0-9]{9,10}$', // Finland
      'fr': r'^\+33[0-9]{9}$', // France
      'de': r'^\+49[0-9]{8,12}$', // Germany
      'gi': r'^\+350[0-9]{5,7}$', // Gibraltar
      'gr': r'^\+30[0-9]{10}$', // Greece
      'hu': r'^\+36[0-9]{8}$', // Hungary
      'is': r'^\+354[0-9]{7}$', // Iceland
      'ie': r'^\+353[0-9]{7,9}$', // Ireland
      'it': r'^\+39[0-9]{10,11}$', // Italy
      'lv': r'^\+371[0-9]{7,8}$', // Latvia
      'li': r'^\+423[0-9]{5}$', // Liechtenstein
      'lt': r'^\+370[0-9]{8}$', // Lithuania
      'lu': r'^\+352[0-9]{6,9}$', // Luxembourg
      'mk': r'^\+389[0-9]{7,8}$', // North Macedonia
      'mt': r'^\+356[0-9]{7}$', // Malta
      'md': r'^\+373[0-9]{7,8}$', // Moldova
      'mc': r'^\+377[0-9]{8}$', // Monaco
      'me': r'^\+382[0-9]{7,8}$', // Montenegro
      'nl': r'^\+31[0-9]{9}$', // Netherlands
      'no': r'^\+47[0-9]{8}$', // Norway
      'pl': r'^\+48[0-9]{9}$', // Poland
      'pt': r'^\+351[0-9]{9}$', // Portugal
      'ro': r'^\+40[0-9]{9}$', // Romania
      'ru': r'^\+7[0-9]{10}$', // Russia
      'sm': r'^\+378[0-9]{5}$', // San Marino
      'rs': r'^\+381[0-9]{7,9}$', // Serbia
      'sk': r'^\+421[0-9]{9}$', // Slovakia
      'si': r'^\+386[0-9]{7,8}$', // Slovenia
      'es': r'^\+34[0-9]{9}$', // Spain
      'se': r'^\+46[0-9]{7,10}$', // Sweden
      'ch': r'^\+41[0-9]{9}$', // Switzerland
      'ua': r'^\+380[0-9]{9}$', // Ukraine
      'gb': r'^\+44[0-9]{10,11}$', // United Kingdom
      'va': r'^\+379[0-9]{5,10}$', // Vatican City
      'dz': r'^\+213[0-9]{9}$', // Algeria
      'ao': r'^\+244[0-9]{9}$', // Angola
      'bj': r'^\+229[0-9]{7,8}$', // Benin
      'bw': r'^\+267[0-9]{7}$', // Botswana
      'bf': r'^\+226[0-9]{7,8}$', // Burkina Faso
      'bi': r'^\+257[0-9]{7}$', // Burundi
      'cv': r'^\+238[0-9]{6}$', // Cape Verde
      'cm': r'^\+237[0-9]{8,9}$', // Cameroon
      'cf': r'^\+236[0-9]{8}$', // Central African Republic
      'td': r'^\+235[0-9]{6,7}$', // Chad
      'km': r'^\+269[0-9]{6}$', // Comoros
      'cd': r'^\+243[0-9]{9}$', // Democratic Republic of the Congo
      'dj': r'^\+253[0-9]{6}$', // Djibouti
      'eg': r'^\+20[0-9]{10}$', // Egypt
      'gq': r'^\+240[0-9]{7,9}$', // Equatorial Guinea
      'er': r'^\+291[0-9]{6}$', // Eritrea
      'et': r'^\+251[0-9]{9}$', // Ethiopia
      'ga': r'^\+241[0-9]{6}$', // Gabon
      'gm': r'^\+220[0-9]{7}$', // Gambia
      'gh': r'^\+233[0-9]{9}$', // Ghana
      'gn': r'^\+224[0-9]{7,9}$', // Guinea
      'gw': r'^\+245[0-9]{7}$', // Guinea-Bissau
      'ke': r'^\+254[0-9]{9}$', // Kenya
      'ls': r'^\+266[0-9]{8}$', // Lesotho
      'lr': r'^\+231[0-9]{6,8}$', // Liberia
      'ly': r'^\+218[0-9]{9,10}$', // Libya
      'mg': r'^\+261[0-9]{9}$', // Madagascar
      'mw': r'^\+265[0-9]{7}$', // Malawi
      'ml': r'^\+223[0-9]{7,8}$', // Mali
      'mr': r'^\+222[0-9]{7}$', // Mauritania
      'mu': r'^\+230[0-9]{7}$', // Mauritius
      'yt': r'^\+262[0-9]{9}$', // Mayotte
      'ma': r'^\+212[0-9]{9}$', // Morocco
      'mz': r'^\+258[0-9]{8,9}$', // Mozambique
      'na': r'^\+264[0-9]{9}$', // Namibia
      'ne': r'^\+227[0-9]{7,8}$', // Niger
      'ng': r'^\+234[0-9]{10}$', // Nigeria
      're': r'^\+262[0-9]{9}$', // Réunion
      'rw': r'^\+250[0-9]{9}$', // Rwanda
      'sh': r'^\+290[0-9]{4}$', // Saint Helena
      'st': r'^\+239[0-9]{7}$', // São Tomé and Príncipe
      'sn': r'^\+221[0-9]{7}$', // Senegal
      'sc': r'^\+248[0-9]{6}$', // Seychelles
      'sl': r'^\+232[0-9]{8}$', // Sierra Leone
      'so': r'^\+252[0-9]{7}$', // Somalia
      'za': r'^\+27[0-9]{9}$', // South Africa
      'ss': r'^\+211[0-9]{9}$', // South Sudan
      'sd': r'^\+249[0-9]{9}$', // Sudan
      'sz': r'^\+268[0-9]{7}$', // Eswatini (Swaziland)
      'tz': r'^\+255[0-9]{9}$', // Tanzania
      'tg': r'^\+228[0-9]{8}$', // Togo
      'tn': r'^\+216[0-9]{7,8}$', // Tunisia
      'ug': r'^\+256[0-9]{9}$', // Uganda
      'eh': r'^\+212[0-9]{9}$', // Western Sahara
      'zm': r'^\+260[0-9]{8,9}$', // Zambia
      'zw': r'^\+263[0-9]{5,9}$', // Zimbabwe
      'ag': r'^\+1[2-9][0-9]{9}$', // Antigua and Barbuda
      'bs': r'^\+1[2-9][0-9]{9}$', // Bahamas
      'bb': r'^\+1[2-9][0-9]{9}$', // Barbados
      'bz': r'^\+501[0-9]{7}$', // Belize
      'ca': r'^\+1[2-9][0-9]{9}$', // Canada
      'cr': r'^\+506[0-9]{8}$', // Costa Rica
      'cu': r'^\+53[0-9]{8}$', // Cuba
      'dm': r'^\+1[2-9][0-9]{9}$', // Dominica
      'do': r'^\+1[2-9][0-9]{9}$', // Dominican Republic
      'sv': r'^\+503[0-9]{7}$', // El Salvador
      'gd': r'^\+1[2-9][0-9]{9}$', // Grenada
      'gt': r'^\+502[0-9]{8}$', // Guatemala
      'ht': r'^\+509[0-9]{8}$', // Haiti
      'hn': r'^\+504[0-9]{8}$', // Honduras
      'jm': r'^\+1[2-9][0-9]{9}$', // Jamaica
      'mx': r'^\+52[1-9][0-9]{9}$', // Mexico
      'ni': r'^\+505[0-9]{8}$', // Nicaragua
      'pa': r'^\+507[0-9]{7,8}$', // Panama
      'kn': r'^\+1[2-9][0-9]{9}$', // Saint Kitts and Nevis
      'lc': r'^\+1[2-9][0-9]{9}$', // Saint Lucia
      'vc': r'^\+1[2-9][0-9]{9}$', // Saint Vincent and the Grenadines
      'tt': r'^\+1[2-9][0-9]{9}$', // Trinidad and Tobago
      'us': r'^\+1[2-9][0-9]{9}$', // United States
      'gt': r'^\+502[0-9]{8}$', // Guatemala
      'ar': r'^\+54[0-9]{10}$', // Argentina
      'bo': r'^\+591[0-9]{7,8}$', // Bolivia
      'br': r'^\+55[0-9]{10,11}$', // Brazil
      'cl': r'^\+56[0-9]{8,9}$', // Chile
      'co': r'^\+57[0-9]{10}$', // Colombia
      'ec': r'^\+593[0-9]{9}$', // Ecuador
      'gf': r'^\+594[0-9]{9}$', // French Guiana
      'gy': r'^\+592[0-9]{7}$', // Guyana
      'py': r'^\+595[0-9]{8}$', // Paraguay
      'pe': r'^\+51[0-9]{9}$', // Peru
      'sr': r'^\+597[0-9]{6}$', // Suriname
      'uy': r'^\+598[0-9]{7,9}$', // Uruguay
      've': r'^\+58[0-9]{10}$', // Venezuela
      'au': r'^\+61[0-9]{9,10}$', // Australia
      'fj': r'^\+679[0-9]{7}$', // Fiji
      'ki': r'^\+686[0-9]{5}$', // Kiribati
      'mh': r'^\+692[0-9]{5}$', // Marshall Islands
      'fm': r'^\+691[0-9]{7}$', // Micronesia
      'nr': r'^\+674[0-9]{4}$', // Nauru
      'nz': r'^\+64[0-9]{8,9}$', // New Zealand
      'pw': r'^\+680[0-9]{7}$', // Palau
      'pg': r'^\+675[0-9]{9}$', // Papua New Guinea
      'ws': r'^\+685[0-9]{6}$', // Samoa
      'sb': r'^\+677[0-9]{5}$', // Solomon Islands
      'to': r'^\+676[0-9]{5}$', // Tonga
      'tv': r'^\+688[0-9]{4}$', // Tuvalu
      'vu': r'^\+678[0-9]{5}$', // Vanuatu
    };

    String? regexPattern =
        countryCodes.containsKey(countryCode.name.toLowerCase())
            ? countryCodes[countryCode.name.toLowerCase()]
            : null;

    if (regexPattern != null) {
      RegExp phoneRegex = RegExp(regexPattern);
      return phoneRegex.hasMatch(phoneNumber);
    } else {
      return false; // Invalid country code provided
    }
  }

  static bool validateIDNumber(String idNumber,
      {required CountryCode countryCode, IDType idType = IDType.ID}) {
    Map<String, RegExp> ids = {
      'af': RegExp(r'^\d{10}$'),
      // Afghanistan
      'am': RegExp(r'^\d{9}$'),
      // Armenia
      'az': RegExp(r'^\d{9}$'),
      // Azerbaijan
      'bh': RegExp(r'^\d{8}$'),
      // Bahrain
      'bd': RegExp(r'^\d{13}$'),
      // Bangladesh
      'bt': RegExp(r'^\d{8}$'),
      // Bhutan
      'bn': RegExp(r'^\d{9}$'),
      // Brunei
      'kh': RegExp(r'^\d{9}$'),
      // Cambodia
      'cn': RegExp(r'^\d{18}$'),
      // China
      'cy': RegExp(r'^\d{8}$'),
      // Cyprus
      'ge': RegExp(r'^\d{9}$'),
      // Georgia
      'in': RegExp(r'^\d{12}$'),
      // India
      'id': RegExp(r'^\d{16}$'),
      // Indonesia
      'ir': RegExp(r'^\d{10}$'),
      // Iran
      'iq': RegExp(r'^\d{11}$'),
      // Iraq
      'il': RegExp(r'^\d{9}$'),
      // Israel
      'jp': RegExp(r'^\d{12}$'),
      // Japan
      'jo': RegExp(r'^\d{9}$'),
      // Jordan
      'kz': RegExp(r'^\d{12}$'),
      // Kazakhstan
      'kp': RegExp(r'^\d{12}$'),
      // North Korea
      'kr': RegExp(r'^\d{13}$'),
      // South Korea
      'kw': RegExp(r'^\d{12}$'),
      // Kuwait
      'kg': RegExp(r'^\d{9}$'),
      // Kyrgyzstan
      'la': RegExp(r'^\d{12}$'),
      // Laos
      'lb': RegExp(r'^\d{8}$'),
      // Lebanon
      'mo': RegExp(r'^\d{8}$'),
      // Macau
      'my': RegExp(r'^\d{12}$'),
      // Malaysia
      'mv': RegExp(r'^\d{11}$'),
      // Maldives
      'mn': RegExp(r'^\d{12}$'),
      // Mongolia
      'mm': RegExp(r'^\d{12}$'),
      // Myanmar
      'np': RegExp(r'^\d{9}$'),
      // Nepal
      'om': RegExp(r'^\d{7}$'),
      // Oman
      'pk': RegExp(r'^\d{13}$'),
      // Pakistan
      'ps': RegExp(r'^\d{9}$'),
      // Palestine
      'ph': RegExp(r'^\d{12}$'),
      // Philippines
      'qa': RegExp(r'^\d{11}$'),
      // Qatar
      'sa': RegExp(r'^\d{10}$'),
      // Saudi Arabia
      'sg': RegExp(r'^\d{7}$'),
      // Singapore
      'lk': RegExp(r'^\d{9}$'),
      // Sri Lanka
      'sy': RegExp(r'^\d{9}$'),
      // Syria
      'tw': RegExp(r'^\d{8}$'),
      // Taiwan
      'tj': RegExp(r'^\d{9}$'),
      // Tajikistan
      'th': RegExp(r'^\d{13}$'),
      // Thailand
      'tl': RegExp(r'^\d{12}$'),
      // Timor-Leste
      'tr': RegExp(r'^\d{11}$'),
      // Turkey
      'tm': RegExp(r'^\d{8}$'),
      // Turkmenistan
      'ae': RegExp(r'^\d{15}$'),
      // United Arab Emirates
      'uz': RegExp(r'^\d{14}$'),
      // Uzbekistan
      'vn': RegExp(r'^\d{12}$'),
      // Vietnam
      'ye': RegExp(r'^\d{9}$'),
      // Yemen
      'dz': RegExp(r'^\d{12}$'),
      // Algeria
      'ao': RegExp(r'^\d{9}$'),
      // Angola
      'bj': RegExp(r'^\d{11}$'),
      // Benin
      'bw': RegExp(r'^\d{8}$'),
      // Botswana
      'bf': RegExp(r'^\d{11}$'),
      // Burkina Faso
      'bi': RegExp(r'^\d{9}$'),
      // Burundi
      'cv': RegExp(r'^\d{8}$'),
      // Cape Verde
      'cm': RegExp(r'^\d{12}$'),
      // Cameroon
      'cf': RegExp(r'^\d{11}$'),
      // Central African Republic
      'td': RegExp(r'^\d{14}$'),
      // Chad
      'km': RegExp(r'^\d{14}$'),
      // Comoros
      'cd': RegExp(r'^\d{14}$'),
      // Democratic Republic of the Congo
      'dj': RegExp(r'^\d{11}$'),
      // Djibouti
      'eg': RegExp(r'^\d{14}$'),
      // Egypt
      'gq': RegExp(r'^\d{12}$'),
      // Equatorial Guinea
      'er': RegExp(r'^\d{16}$'),
      // Eritrea
      'et': RegExp(r'^\d{13}$'),
      // Ethiopia
      'ga': RegExp(r'^\d{11}$'),
      // Gabon
      'gm': RegExp(r'^\d{11}$'),
      // Gambia
      'gh': RegExp(r'^\d{11}$'),
      // Ghana
      'gn': RegExp(r'^\d{13}$'),
      // Guinea
      'gw': RegExp(r'^\d{12}$'),
      // Guinea-Bissau
      'ke': RegExp(r'^\d{8}$'),
      // Kenya
      'ls': RegExp(r'^\d{9}$'),
      // Lesotho
      'lr': RegExp(r'^\d{11}$'),
      // Liberia
      'ly': RegExp(r'^\d{12}$'),
      // Libya
      'mg': RegExp(r'^\d{14}$'),
      // Madagascar
      'mw': RegExp(r'^\d{12}$'),
      // Malawi
      'ml': RegExp(r'^\d{13}$'),
      // Mali
      'mr': RegExp(r'^\d{13}$'),
      // Mauritania
      'mu': RegExp(r'^\d{12}$'),
      // Mauritius
      'ma': RegExp(r'^\d{12}$'),
      // Morocco
      'mz': RegExp(r'^\d{11}$'),
      // Mozambique
      'na': RegExp(r'^\d{14}$'),
      // Namibia
      'ne': RegExp(r'^\d{11}$'),
      // Niger
      'ng': RegExp(r'^\d{11}$'),
      // Nigeria
      'rw': RegExp(r'^\d{16}$'),
      // Rwanda
      'st': RegExp(r'^\d{11}$'),
      // Sao Tome and Principe
      'sn': RegExp(r'^\d{13}$'),
      // Senegal
      'sc': RegExp(r'^\d{10}$'),
      // Seychelles
      'sl': RegExp(r'^\d{9}$'),
      // Sierra Leone
      'so': RegExp(r'^\d{18}$'),
      // Somalia
      'za': RegExp(r'^\d{13}$'),
      // South Africa
      'ss': RegExp(r'^\d{11}$'),
      // South Sudan
      'sd': RegExp(r'^\d{13}$'),
      // Sudan
      'sz': RegExp(r'^\d{12}$'),
      // Swaziland
      'tz': RegExp(r'^\d{13}$'),
      // Tanzania
      'tg': RegExp(r'^\d{11}$'),
      // Togo
      'tn': RegExp(r'^\d{8}$'),
      // Tunisia
      'ug': RegExp(r'^\d{14}$'),
      // Uganda
      'zm': RegExp(r'^\d{11}$'),
      // Zambia
      'zw': RegExp(r'^\d{12}$'),
      // Zimbabwe
      'al': RegExp(r'^\d{9}$'),
      // Albania
      'ad': RegExp(r'^\d{8}[A-Z]$'),
      // Andorra
      'at': RegExp(r'^\d{8}$'),
      // Austria
      'by': RegExp(r'^\d{14}$'),
      // Belarus
      'be': RegExp(r'^\d{11}$'),
      // Belgium
      'ba': RegExp(r'^\d{13}$'),
      // Bosnia and Herzegovina
      'bg': RegExp(r'^\d{10}$'),
      // Bulgaria
      'hr': RegExp(r'^\d{11}$'),
      // Croatia
      'cy': RegExp(r'^\d{8}[A-Z]$'),
      // Cyprus
      'cz': RegExp(r'^\d{10}$'),
      // Czech Republic
      'dk': RegExp(r'^\d{10}$'),
      // Denmark
      'ee': RegExp(r'^\d{11}$'),
      // Estonia
      'fi': RegExp(r'^\d{11}$'),
      // Finland
      'fr': RegExp(r'^\d{12}$'),
      // France
      'de': RegExp(r'^\d{9}$'),
      // Germany
      'gr': RegExp(r'^\d{9}$'),
      // Greece
      'hu': RegExp(r'^\d{10}$'),
      // Hungary
      'is': RegExp(r'^\d{10}$'),
      // Iceland
      'ie': RegExp(r'^\d{8}[A-Z]{1,2}$'),
      // Ireland
      'it': RegExp(r'^\d{11}$'),
      // Italy
      'lv': RegExp(r'^\d{11}$'),
      // Latvia
      'li': RegExp(r'^\d{11}$'),
      // Liechtenstein
      'lt': RegExp(r'^\d{11}$'),
      // Lithuania
      'lu': RegExp(r'^\d{13}$'),
      // Luxembourg
      'mk': RegExp(r'^\d{13}$'),
      // North Macedonia
      'mt': RegExp(r'^[A-Z]{2}\d{6}$'),
      // Malta
      'md': RegExp(r'^\d{13}$'),
      // Moldova
      'mc': RegExp(r'^\d{8}[A-Z]$'),
      // Monaco
      'me': RegExp(r'^\d{13}$'),
      // Montenegro
      'nl': RegExp(r'^\d{9}$'),
      // Netherlands
      'no': RegExp(r'^\d{11}$'),
      // Norway
      'pl': RegExp(r'^\d{10}$'),
      // Poland
      'pt': RegExp(r'^\d{12}$'),
      // Portugal
      'ro': RegExp(r'^\d{13}$'),
      // Romania
      'ru': RegExp(r'^\d{12}$'),
      // Russia
      'sm': RegExp(r'^[A-Z]\d{7}$'),
      // San Marino
      'rs': RegExp(r'^\d{13}$'),
      // Serbia
      'sk': RegExp(r'^\d{11}$'),
      // Slovakia
      'si': RegExp(r'^\d{8}$'),
      // Slovenia
      'es': RegExp(r'^\d{9}[A-Z]$'),
      // Spain
      'se': RegExp(r'^\d{12}$'),
      // Sweden
      'ch': RegExp(r'^\d{9}$'),
      // Switzerland
      'ua': RegExp(r'^\d{10}$'),
      // Ukraine
      'gb': RegExp(r'^\d{9}$'),
      // United Kingdom
      'ca': RegExp(r'^\d{9}$'),
      // Canada
      'us': RegExp(r'^\d{9}$'),
      // United States
      'mx': RegExp(r'^\d{18}$'),
      // Mexico
      'gt': RegExp(r'^[A-Z0-9]{13}$'),
      // Guatemala
      'bz': RegExp(r'^[A-Z0-9]{15}$'),
      // Belize
      'sv': RegExp(r'^[A-Z0-9]{16}$'),
      // El Salvador
      'hn': RegExp(r'^[A-Z0-9]{13}$'),
      // Honduras
      'ni': RegExp(r'^[A-Z0-9]{14}$'),
      // Nicaragua
      'cr': RegExp(r'^[A-Z0-9]{9}$'),
      // Costa Rica
      'pa': RegExp(r'^[A-Z0-9]{14}$'),
      // Panama
      'cu': RegExp(r'^[A-Z0-9]{11}$'),
      // Cuba
      'do': RegExp(r'^[A-Z0-9]{11}$'),
      // Dominican Republic
      'ht': RegExp(r'^[A-Z0-9]{13}$'),
      // Haiti
      'jm': RegExp(r'^[A-Z0-9]{12}$'),
      // Jamaica
      'tt': RegExp(r'^[A-Z0-9]{11}$'),
      // Trinidad and Tobago
      'kn': RegExp(r'^[A-Z0-9]{11}$'),
      // Saint Kitts and Nevis
      'lc': RegExp(r'^[A-Z0-9]{13}$'),
      // Saint Lucia
      'vc': RegExp(r'^[A-Z0-9]{10}$'),
      // Saint Vincent and the Grenadines
      'bb': RegExp(r'^[A-Z0-9]{12}$'),
      // Barbados
      'gd': RegExp(r'^[A-Z0-9]{14}$'),
      // Grenada
      'ag': RegExp(r'^[A-Z0-9]{9}$'),
      // Antigua and Barbuda
      'bs': RegExp(r'^[A-Z0-9]{7}$'),
      // Bahamas
      'dm': RegExp(r'^[A-Z0-9]{14}$'),
      // Dominica
      'vc': RegExp(r'^[A-Z0-9]{9}$'),
      // Saint Vincent and the Grenadines
      'bb': RegExp(r'^[A-Z0-9]{12}$'),
      // Barbados
      'ar': RegExp(r'^\d{7,8}$'),
      // Argentina
      'bo': RegExp(r'^\d{7,12}$'),
      // Bolivia
      'br': RegExp(r'^\d{9}$'),
      // Brazil
      'cl': RegExp(r'^\d{8,9}-\d{1}$'),
      // Chile
      'co': RegExp(r'^\d{5,12}$'),
      // Colombia
      'ec': RegExp(r'^\d{10}$'),
      // Ecuador
      'fk': RegExp(r'^[A-Z]{3}\d{4}$'),
      // Falkland Islands (Malvinas)
      'gf': RegExp(r'^\d{12}$'),
      // French Guiana
      'gy': RegExp(r'^\d{7,9}$'),
      // Guyana
      'py': RegExp(r'^\d{7}$'),
      // Paraguay
      'pe': RegExp(r'^\d{8,12}$'),
      // Peru
      'gs': RegExp(r'^\d{5}$'),
      // South Georgia and the South Sandwich Islands
      'sr': RegExp(r'^\d{9}$'),
      // Suriname
      'uy': RegExp(r'^\d{7,8}$'),
      // Uruguay
      've': RegExp(r'^[VEJPG]\d{6,9}$'),
      // Venezuela
      'an': RegExp(r'^\d{6}$'),
      // Netherlands Antilles
      'bo': RegExp(r'^\d{8,12}$'),
      // Bonaire, Sint Eustatius, and Saba
      'cl': RegExp(r'^\d{8,9}-\d{1}$'),
      // Easter Island
      'co': RegExp(r'^\d{5,12}$'),
      // San Andrés y Providencia
      'ec': RegExp(r'^\d{10}$'),
      // Galápagos Islands
      'pe': RegExp(r'^\d{8,12}$'),
      // Machu Picchu
      'fk': RegExp(r'^[A-Z]{3}\d{4}$'),
      // South Georgia and the South Sandwich Islands
      've': RegExp(r'^[VEJPG]\d{6,9}$'),
      // Isla Aves, Isla de Patos, Isla de Aves de Barlovento
      'fk': RegExp(r'^[A-Z]{3}\d{4}$'),
      // South Georgia and the South Sandwich Islands
      'sr': RegExp(r'^\d{9}$'),
      // Saint Helena, Ascension, and Tristan da Cunha
      'uy': RegExp(r'^\d{7,8}$'),
      // Isla de Lobos
    };

    if (countryCode != null &&
        ids.containsKey(countryCode.name.toLowerCase())) {
      RegExp regexPattern = ids[countryCode.name.toLowerCase()]!;
      return regexPattern.hasMatch(idNumber);
    }

    return false; // Invalid country code or ID type provided
  }

  static bool validateURL({required String url}) {
    // URL validation logic
    // Basic URL format check using regex
    RegExp urlRegex = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
    return urlRegex.hasMatch(url);
  }

  static bool validateDate(dynamic date, [String mask = 'yyyy-MM-dd']) {
    if (date is DateTime) {
      // If 'date' is a DateTime object, it's considered valid
      return true;
    } else if (date is String && mask != null) {
      String dateRegexPattern = _buildDateRegex(mask);
      RegExp dateRegex = RegExp(dateRegexPattern);
      return dateRegex.hasMatch(date);
    } else {
      // If 'date' is neither a DateTime object nor a String with mask, it's invalid
      return false;
    }
  }

// Function to build the regex pattern based on the provided mask
  static String _buildDateRegex(String mask) {
    String regexPattern = mask
        .replaceAllMapped('d', (_) => r'\d')
        .replaceAllMapped('m', (_) => r'\d')
        .replaceAllMapped('y', (_) => r'\d');

    return '^$regexPattern\$';
  }

  static CardType detectCardType({required String cardNumber}) {
    if (RegExp(r'^4').hasMatch(cardNumber)) {
      return CardType.Visa;
    } else if (RegExp(r'^5[1-5]').hasMatch(cardNumber)) {
      return CardType.MasterCard;
    } else if (RegExp(r'^3[47]').hasMatch(cardNumber)) {
      return CardType.AmericanExpress;
    } else if (RegExp(r'^6(?:011|5)').hasMatch(cardNumber)) {
      return CardType.Discover;
    } else {
      return CardType.Other;
    }
  }

  static bool validateCreditCard({required String cardNumber}) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cardNumber.length < 13 || cardNumber.length > 19) return false;

    List<int> digits = cardNumber.split('').map(int.parse).toList();
    for (int i = digits.length - 2; i >= 0; i -= 2) {
      digits[i] *= 2;
      if (digits[i] > 9) digits[i] -= 9;
    }

    int sum = digits.reduce((value, element) => value + element);
    return sum % 10 == 0;
  }

  static bool validateIP4Address(String ipAddress) {
    RegExp ipRegex = RegExp(
        r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return ipRegex.hasMatch(ipAddress);
  }

  static bool validateIPv6Address(String ipAddress) {
    // IPv6 address validation logic
    // Check if the input is a valid IPv6 address
    RegExp ipv6Regex = RegExp(
        r'^([0-9a-fA-F]{1,4}:){7}([0-9a-fA-F]{1,4}|:|:([0-9a-fA-F]{1,4}:){1,5})$');
    return ipv6Regex.hasMatch(ipAddress);
  }

  static bool validatePassword(
      String password, Map<PasswordValidation, dynamic> options) {
    if (options.containsKey(PasswordValidation.minLength) &&
        password.length < options[PasswordValidation.minLength]) {
      return false;
    }

    if (options.containsKey(PasswordValidation.maxLength) &&
        password.length > options[PasswordValidation.maxLength]) {
      return false;
    }

    if (options.containsKey(PasswordValidation.disallowLetters) &&
        options[PasswordValidation.disallowLetters] &&
        RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return false;
    }

    if (options.containsKey(PasswordValidation.disallowNumbers) &&
        options[PasswordValidation.disallowNumbers] &&
        RegExp(r'\d').hasMatch(password)) {
      return false;
    }

    if (options.containsKey(PasswordValidation.disallowSpecialChars) &&
        options[PasswordValidation.disallowSpecialChars] &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return false;
    }

    return true;
  }

  static bool validatePostalCode(String postalCode,
      {required PostalCodeValidation option, String? customRegex}) {
    if (option == PostalCodeValidation.USZipCode) {
      RegExp usZipRegex = RegExp(r'^\d{5}(?:[-\s]\d{4})?$');
      return usZipRegex.hasMatch(postalCode);
    } else if (option == PostalCodeValidation.UKPostalCode) {
      RegExp ukPostalRegex = RegExp(r'^[A-Z]{1,2}\d{1,2}[A-Z]?\s*\d[A-Z]{2}$');
      return ukPostalRegex.hasMatch(postalCode.toUpperCase());
    } else if (option == PostalCodeValidation.Custom && customRegex != null) {
      RegExp customPostalRegex = RegExp(customRegex);
      return customPostalRegex.hasMatch(postalCode);
    } else {
      // Default validation (basic numeric postal code)
      RegExp defaultPostalRegex = RegExp(r'^\d{5}(?:[-\s]\d{4})?$');
      return defaultPostalRegex.hasMatch(postalCode);
    }
  }

  static bool validateNumericRange(
      {required int value, required int min, required int max}) {
    return value >= min && value <= max;
  }

  static bool validateSocialMediaHandle({required String handle}) {
    RegExp handleRegex = RegExp(r'^@?[a-zA-Z0-9_]+$');
    return handleRegex.hasMatch(handle);
  }

  static bool validateFileExtension(String filename,
      {Set<String> validExtensions = const {
        '.pdf',
        '.docx',
        '.jpg',
        '.png',
        '.txt'
      }}) {
    String extension = filename.toLowerCase().split('.').last;

    return validExtensions.contains('.$extension');
  }

  static bool validateBankAccountNumber(String accountNumber,
      {int minLength = 8, int maxLength = 20, String? regExpPattern}) {
    // Bank account number validation logic
    // Validate based on length and optional pattern

    // Check length constraints
    if (accountNumber.length < minLength || accountNumber.length > maxLength) {
      return false;
    }

    // Check if the pattern is provided and validate against the pattern
    if (regExpPattern != null) {
      RegExp regex = RegExp(regExpPattern);
      return regex.hasMatch(accountNumber);
    }

    return true; // No specific pattern to check
  }

  static bool validateHexColorCode({required String colorCode}) {
    // Hexadecimal color code validation logic
    // Check if the input is a valid hexadecimal color code
    RegExp hexColorRegex = RegExp(r'^#?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');
    return hexColorRegex.hasMatch(colorCode);
  }

  static bool validateVIN({required String vin, required int vinLength}) {
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

  bool validateTime(String time, {TimeFormat format = TimeFormat.HH_MM_24}) {
    RegExp timeRegex;
    switch (format) {
      case TimeFormat.HH_MM_24:
        timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
        break;
      case TimeFormat.HH_MM_AM_PM:
        timeRegex = RegExp(r'^(1[0-2]|0?[1-9]):([0-5]\d)\s?(AM|PM|am|pm)?$');
        break;
      case TimeFormat.HH_MM_SS_24:
        timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$');
        break;
      case TimeFormat.HH_MM_SS_AM_PM:
        timeRegex =
            RegExp(r'^(1[0-2]|0?[1-9]):([0-5]\d):([0-5]\d)\s?(AM|PM|am|pm)?$');
        break;
      case TimeFormat.HH_MM_SS_MS_24:
        timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)\.\d{1,3}$');
        break;
      default:
        return false; // Return false for unsupported formats
    }
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

  static bool validateTemperatureUnit(String unit,
      {bool allowCustomUnit = false}) {
    unit = unit.toLowerCase();

    if (unit == 'celsius' || unit == 'fahrenheit') {
      return true;
    }

    if (allowCustomUnit) {
      // Add more conditions for custom units if needed
      return true;
    }

    return false;
  }

  static bool validateBooleanValue(String value) {
    // Boolean value validation logic
    // Check if the input is a valid boolean value (true or false)
    return value.toLowerCase() == 'true' || value.toLowerCase() == 'false';
  }
}
