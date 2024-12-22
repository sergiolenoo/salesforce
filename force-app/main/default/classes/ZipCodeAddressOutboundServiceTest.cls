/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
@isTest(isParallel=true)
public class ZipCodeAddressOutboundServiceTest {
    
    @IsTest
    static void givenZipCodeAddressWhenGetByAddressThenReturnValidResponse() {

        String brazipAddressPayload = '{ "cep": "01001-000", "logradouro": "Praça da Sé", "complemento": "lado ímpar", "unidade": "", "bairro": "Sé", "localidade": "São Paulo", "uf": "SP", "estado": "São Paulo", "regiao": "Sudeste", "ibge": "3550308", "gia": "1004", "ddd": "11", "siafi": "7107" }';

        HttpCalloutResponseMock mock = new HttpCalloutResponseMock(brazipAddressPayload);

        String germanAddressPayload = '[{"postalCode":"38110","name":"Braunschweig","municipality":{"key":"03101000","name":"Braunschweig, Stadt","type":"Kreisfreie Stadt"},"district":{"key":"03101","name":"Braunschweig, Stadt","type":"Kreisfreie Stadt"},"federalState":{"key":"03","name":"Niedersachsen"}}]';

        Test.startTest();

        ZipCodeAddressOutboundService zipService = new ZipCodeAddressOutboundService();

        BrazilianZipCodeAddressResponse brazipResponse = (BrazilianZipCodeAddressResponse) zipService
            .findBrazilian('01001000');

        mock.withBody(germanAddressPayload);
    
        GermanZipCodeAddressResponse germanResponse = (GermanZipCodeAddressResponse) zipService
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

    @IsTest
    static void givenInvalidCountryCodeWhenFetchAddressThenThrowException() {
        
        try {
            new ZipCodeAddressOutboundService().fetchAddress('invalidContryCode', '01001000', null);
            Assert.fail('Expected exception was not thrown');
        } catch (Exception ex) {
            Assert.isTrue(ex.getMessage().contains('invalidContryCode'));
        }
    }
}