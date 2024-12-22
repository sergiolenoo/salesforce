/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public inherited sharing abstract class AbstractRequest implements Request {
    
    private HttpRequest request;
    public static final String SUCCESS_MESSAGE = 'Success';

    protected AbstractRequest(String method) {
        this.request = new HttpRequest();
        this.request.setMethod(method);
    }

    public HttpRequest getHttpRequest() {
        return this.request;
    }

    public AbstractRequest withEndPoint(String endpoint) {

        if ( String.isBlank(endpoint) ) paramError('Endpoint');
        
        this.request.setEndpoint(endpoint);
        return this;
    }

    public AbstractRequest withBody(String body) {

        if ( String.isBlank(body) ) paramError('Body');

        this.request.setBody(body);

        return this;
    }

    public AbstractRequest withBody(Blob body) {

        if ( body == null ) paramError('Body');

        this.request.setBodyAsBlob(body);

        return this;
    }

    public AbstractRequest withTimeout(Integer timeout) {

        if ( timeout == null ) paramError('Timeout');

        this.request.setTimeout( Math.abs(timeout) );

        return this;
    }

    public AbstractRequest withContentType(String contentType) {
        return withHeader('Content-Type', contentType);
    }

    public AbstractRequest withHeader(String key, String value) {

        if( String.isBlank(key) || String.isBlank(value) ) paramError('Header');

        return withHeaders(new Map<String, String>{key => value});
    }

    public AbstractRequest withHeaders(Map<String, String> headers) {

        if ( headers == null || headers.isEmpty() ) paramError('Headers');

        for (String key : headers.keySet()) {
            this.request.setHeader( key, headers.get(key) );
        }

        return this;
    }

    public AbstractRequest withClientCertificateName(String certDevName) {

        if ( String.isBlank(certDevName) ) paramError('Certificate');

        if( !Test.isRunningTest() ) this.request.setClientCertificateName(certDevName);
        
        return this;
    }

    public String getString() {
        return this.request.toString();
    }

    virtual
    public HttpResponse send() {
        return new Http().send(this.request);
    }

    public Object getParsedResponse(System.Type parseClass) {

        HttpResponse response = this.send();
        
        if( isNotSuccess(response) ) return null;

        if ( String.isBlank( response.getBody() ) ) return SUCCESS_MESSAGE;

        return JSON.deserialize(response.getBody(), parseClass);
    }

    private Boolean isNotSuccess(HttpResponse response) {
        return response.getStatusCode() > 299 || response.getStatusCode() > 200;
    }

    private void paramError(String paramName) {
        error( paramName + ' cannot be null or empty.');
    }

    private void error(String message) {
        throw new IllegalArgumentException( message );
    }
}