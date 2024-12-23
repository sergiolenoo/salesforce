/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public inherited sharing virtual class ZipCodeAddressOutboundService {

    public BrazilianZipCodeAddressResponse findBrazilian(String zipCode) {

        return (BrazilianZipCodeAddressResponse) fetchAddress(
            buildEndpoint('BRA', zipCode), BrazilianZipCodeAddressResponse.class
        );
    }

    public GermanZipCodeAddressResponse findGerman(String zipCode) {

        List<GermanZipCodeAddressResponse> address = (List<GermanZipCodeAddressResponse>) fetchAddress(
            buildEndpoint('DEU', zipCode), List<GermanZipCodeAddressResponse>.class
        );

        if( address == null || address.isEmpty() ) return null;
        
        return address[0];
    }

    @TestVisible
    virtual
    protected Object fetchAddress( String endpoint, System.Type apexType ) {
        return new GetRequest().withEndPoint( endpoint ).getParsedBody( apexType );
    }

    @TestVisible
    private String buildEndpoint( String countryIsoCode, String zipCode ) {
        
        ZipCodeEndpoint__mdt endpointInfo = ZipCodeEndpoint__mdt.getInstance(countryIsoCode);

        if( endpointInfo == null) throw new IllegalArgumentException( 
            System.Label.ZIPSInvalidCountryIso + countryIsoCode +'.'
        );

        return endpointInfo.BaseUrl__c + zipCode + (endpointInfo.AdditionalUrl__c ?? '');
    }
}