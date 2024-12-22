/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public class GermanZipCodeAddressResponse {
    public String postalCode;
    public String name;
    public Municipality municipality;
    public District district;
    public FederalState federalState;

    public virtual class FederalState {
        public String key;
        public String name;
    }

    public virtual class District extends FederalState {
        public String type;
    }

    public class Municipality extends District{ }
}