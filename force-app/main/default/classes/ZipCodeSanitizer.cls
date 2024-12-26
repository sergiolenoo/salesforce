public class ZipCodeSanitizer {

    private static final Integer BRAZILIAN_ZIP_CODE_LENGTH = 8;
    private static final Integer GERMAN_ZIP_CODE_LENGTH = 5;

    public String sanitizeBrazilian(String zipCode) {
        return sanitize(zipCode, BRAZILIAN_ZIP_CODE_LENGTH);
    }

    public String sanitizeGerman(String zipCode) {
        return sanitize(zipCode, GERMAN_ZIP_CODE_LENGTH);
    }

    private String sanitize(String zipCode, Integer expectedLenght) {

        String sanitizedZipCode = StringService.extractNumbers(zipCode);

        if( sanitizedZipCode.length() != expectedLenght ) throw new IllegalArgumentException(
            System.Label.ZIPSInvalidZipCode + zipCode + '.'
        );

        return sanitizedZipCode;
    }
}