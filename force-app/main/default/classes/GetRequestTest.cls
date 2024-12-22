/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
@isTest(isParallel=true)
public class GetRequestTest {
    
    @IsTest
    static void givenValidRequestWhenGetParsedResponseCalledThenRetrieveExpectedResponse() {

        String payload = '{ "cep": "01001-000", "logradouro": "Praça da Sé", "complemento": "lado ímpar", "unidade": "", "bairro": "Sé", "localidade": "São Paulo", "uf": "SP", "estado": "São Paulo", "regiao": "Sudeste", "ibge": "3550308", "gia": "1004", "ddd": "11", "siafi": "7107" }';

        new HttpCalloutResponseMock(payload);
        
        Test.startTest();
        
        Request request = new GetRequest()
            .withEndPoint('http://test.com/endpoint')
            .withBody( Blob.valueOf(payload) )
            .withBody(payload)
            .withTimeout(10000)
            .withClientCertificateName('test')
            .withContentType('application/json');


        Object response = request.getParsedResponse(BrazilianZipCodeAddressResponse.class);

        Test.stopTest();

        Assert.isTrue(response instanceOf BrazilianZipCodeAddressResponse);

        Assert.areEqual(payload, request.getHttpRequest().getBody());
        Assert.isFalse( String.isBlank( request.getString() ) );
    }

    @IsTest
    static void givenInvalidResponseWhenGetParsedResponseCalledThenReturnNull() {

        new HttpCalloutResponseMock(400);
        
        Test.startTest();
        
        Assert.isNull(
            new GetRequest().getParsedResponse(BrazilianZipCodeAddressResponse.class)
        );

        Test.stopTest();
    }

    @IsTest
    static void givenInvalidParametersWhenBuildRequestThenThrowException() {

        GetRequest request = new GetRequest();
        
        String nullString;
        Blob nullBlob;
        Integer nullInteger;

        try {
            request.withBody(nullString);
            Assert.fail('Expected exception was not thrown');
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('Body'));
        }

        try {
            request.withBody(nullBlob);
            Assert.fail('Expected exception was not thrown');
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('Body'));
        }

        try {
            request.withEndPoint(nullString);
            Assert.fail('Expected exception was not thrown');
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('Endpoint'));
        }

        try {
            request.withTimeout(nullInteger);
            Assert.fail('Expected exception was not thrown');
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('Timeout'));
        }

        try {
            request.withContentType(nullString);
            Assert.fail('Expected exception was not thrown');
        } catch (IllegalArgumentException ex) {
            Assert.isTrue(ex.getMessage().contains('Header'));
        }

    }
}