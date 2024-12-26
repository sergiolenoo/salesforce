@isTest(isParallel=true)
private class ZipCodeSanitizerTest {

@isTest
    private static void shouldReturnValid() {

        ZipCodeSanitizer sanitizer  = new ZipCodeSanitizer();

        Assert.areEqual('01001000',  sanitizer.sanitizeBrazilian('01001-000'));
        Assert.areEqual('38110',  sanitizer.sanitizeGerman('38.110'));

    }

    @IsTest
    static void shouldThrowException() {

        ZipCodeSanitizer sanitizer  = new ZipCodeSanitizer();
        
        try {
            sanitizer.sanitizeBrazilian(null);
            Assert.fail('Expected exception was not thrown');
        
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('null'));
        }

        try {
            sanitizer.sanitizeBrazilian('38.110');
            Assert.fail('Expected exception was not thrown');
        
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('38.110'));
        }

        try {
            sanitizer.sanitizeGerman('01001-000');
            Assert.fail('Expected exception was not thrown');
        
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('01001-000'));
        }
    }
}