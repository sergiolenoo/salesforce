/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
@isTest
public class HttpCalloutResponseMock implements HttpCalloutMock {

    public HttpResponse response;
    public List<HttpRequest> requests = new List<HttpRequest>();

    public HttpCalloutResponseMock () {
        this( 200 );
    }

    public HttpCalloutResponseMock ( Integer status ) {

        this.response = new HttpResponse();
        this.response.setStatusCode( status );

        Test.setMock( HttpCalloutMock.class, this );
    }

    public HttpCalloutResponseMock (String body ) {

        this();

        withBody(body);
    }

    public HttpCalloutResponseMock ( Blob body ) {

        this();

        withBodyAsBlob(body);
    }

    public HttpCalloutResponseMock withBody( String body ) {

        this.response.setBody( body );

        return this;
    }

    public HttpCalloutResponseMock withBodyAsBlob( Blob body ) {

        this.response.setBodyAsBlob( body );

        return this;
    }

    public HttpCalloutResponseMock withHeader( String key, String value ) {
        return this.withHeaders(new Map<String, String>{key => value});
    }

    public HttpCalloutResponseMock withHeaders(Map<String, String> headers) {

        for (String key : headers.keySet()) {

            this.response.setHeader(key, headers.get(key));

        }

        return this;
    }
    
    public HttpResponse respond ( HttpRequest request ) {

        this.requests.add(request);
        
        return this.response;
    }
}