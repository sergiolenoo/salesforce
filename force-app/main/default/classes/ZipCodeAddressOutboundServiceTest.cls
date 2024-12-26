/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
@isTest(isParallel=true)
public class ZipCodeAddressOutboundServiceTest {

    static ZipCodeAddressOutboundService service = new ZipCodeAddressOutboundService();

    @IsTest
    static void givenValidCountryCodeWhenBuildEndpointCalledThenReturnExpectedUrl() {

        Assert.isTrue( service.buildEndpoint('BRA', '01001000').contains('01001000') );

        String germanEndpoint = service.buildEndpoint('DEU', '38110');
        
        Assert.isTrue( germanEndpoint.contains('38110') );
        Assert.isFalse( germanEndpoint.contains('null') );
    }

    @IsTest
    static void givenInvalidContryCodeWhenBuildEndpointCalledThenThrowException() {
        
        try {
            service.buildEndpoint('invalid', '01001000');
            Assert.fail('Expected exception was not thrown');

        } catch (Exception ex) {
            Assert.isTrue(ex.getMessage().contains('invalid'));
        }
    }    
    
    @IsTest
    static void givenZipCodeAddressWhenFindCalledThenReturnParsedAddress() {

        String brazipAddressPayload = '{ "cep": "01001-000", "logradouro": "Praça da Sé", "complemento": "lado ímpar", "unidade": "", "bairro": "Sé", "localidade": "São Paulo", "uf": "SP", "estado": "São Paulo", "regiao": "Sudeste", "ibge": "3550308", "gia": "1004", "ddd": "11", "siafi": "7107" }';
        String germanAddressPayload = '[{"postalCode":"38110","name":"Braunschweig","municipality":{"key":"03101000","name":"Braunschweig, Stadt","type":"Kreisfreie Stadt"},"district":{"key":"03101","name":"Braunschweig, Stadt","type":"Kreisfreie Stadt"},"federalState":{"key":"03","name":"Niedersachsen"}}]';

        HttpCalloutResponseMock mock = new HttpCalloutResponseMock(brazipAddressPayload);

        Test.startTest();
        
        BrazilianZipCodeAddressResponse brazipResponse = (BrazilianZipCodeAddressResponse) service
        .findBrazilian('01001000');
        
        mock.withBody(germanAddressPayload);
    
        GermanZipCodeAddressResponse germanResponse = (GermanZipCodeAddressResponse) service
            .findGerman('38110');
        
        Test.stopTest();

        Assert.areEqual(brazipResponse.cep, '01001-000');
        Assert.areEqual(brazipResponse.localidade, 'São Paulo');
        Assert.areEqual(germanResponse.postalCode, '38110');
        Assert.areEqual(germanResponse.municipality.name, 'Braunschweig, Stadt');

        Assert.areEqual(2, mock.requests.size());

        Assert.isTrue(mock.requests.get(0).getEndpoint().contains('01001000'));
        Assert.isTrue(mock.requests.get(1).getEndpoint().contains('38110'));

    }

}