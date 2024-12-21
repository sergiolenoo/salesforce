/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
@isTest
public class CalloutResponseMock implements HttpCalloutMock {

    HttpResponse response;
    private List<HttpRequest> requests = new List<HttpRequest>();

    public CalloutResponseMock () {
        this( 200 );
    }

    public CalloutResponseMock ( Integer status ) {

        this.response = new HttpResponse();
        this.response.setStatusCode( status );

        Test.setMock( HttpCalloutMock.class, this );
    }

    public CalloutResponseMock (String body ) {

        this();

        withBody(body);
    }

    public CalloutResponseMock ( Blob body ) {

        this();

        withBodyAsBlob(body);
    }

    public CalloutResponseMock withBody( String body ) {

        this.response.setBody( body );

        return this;
    }

    public CalloutResponseMock withBodyAsBlob( Blob body ) {

        this.response.setBodyAsBlob( body );

        return this;
    }

    public CalloutResponseMock withHeader( String key, String value ) {

        this.response.setHeader(key, value);

        return this;
    }

    public CalloutResponseMock withHeaders(Map<String, String> headers) {

        for (String key : headers.keySet()) {

            withHeader(key, headers.get(key));

        }

        return this;
    }
    
    public HttpResponse respond ( HttpRequest request ) {

        this.requests.add(request);
        
        return this.response;
    }
}