@isTest(isParallel=true)
private class StringServiceTest {

@isTest
    static void shouldExtractNumbers() {
        // Valid text with numbers
        String text = 'This is some text, with a $pecial char, 123 and 123 again.';
        Assert.areEqual('123123', StringService.extractNumbers(text));

        Assert.areEqual( '', StringService.extractNumbers(null) );
    }
}