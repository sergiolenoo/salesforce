/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public inherited sharing virtual class ZipCodeAddressOutboundService {

    public BrazilianZipCodeAddressResponse findBrazilian(String zipCode) {

        return (BrazilianZipCodeAddressResponse) findAddress(
            'BRA', zipCode, BrazilianZipCodeAddressResponse.class
        );
    }

    public GermanZipCodeAddressResponse findGerman(String zipCode) {

        List<GermanZipCodeAddressResponse> address = (List<GermanZipCodeAddressResponse>) findAddress(
            'DEU', zipCode, List<GermanZipCodeAddressResponse>.class
        );

        if( address == null || address.isEmpty() ) return null;
        
        return address[0];
    }

    virtual
    protected Object findAddress( String countryIsoCode
                                , String zipCode
                                , System.Type apexType ) {
        
        ZipCodeEndpoint__mdt endpointInfo = ZipCodeEndpoint__mdt.getInstance(countryIsoCode);

        if( endpointInfo == null) throw new IllegalArgumentException( 
            System.Label.ZIPSInvalidCountryIso + countryIsoCode +'.'
        );

        String endPoint = endpointInfo.BaseUrl__c + zipCode;
        endPoint += endpointInfo.AdditionalUrl__c ?? '';

        return new GetRequest().withEndPoint( endPoint ).getParsedResponse( apexType );
    }
}