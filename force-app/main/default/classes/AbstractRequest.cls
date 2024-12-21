public inherited sharing abstract class AbstractRequest {
    
    private HttpRequest request;

    public AbstractRequest(String method) {
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

    public AbstractRequest withBlobBody(Blob body) {

        if ( body == null ) paramError('Body');

        this.request.setBodyAsBlob(body);

        return this;
    }

    public AbstractRequest withTimeout(Integer timeout) {

        if ( timeout == null ) paramError('Timeout');

        this.request.setTimeout(timeout);

        return this;
    }

    public AbstractRequest withContentType(String contentType) {
        return withHeader('Content-Type', contentType);
    }

    public AbstractRequest withHeader(String key, String value) {
        return withHeaders(new Map<String, String>{key => value});
    }

    public AbstractRequest withHeaders(Map<String, String> headers) {

        if ( headers==null || headers.isEmpty() ) paramError('Headers');

        for (String key : headers.keySet()) {
            this.request.setHeader( key, headers.get(key) );
        }

        return this;
    }

    public AbstractRequest withClientCertificateName(String certDevName) {

        if ( String.isBlank(certDevName) ) paramError('Certificate');

        this.request.setClientCertificateName(certDevName);
        
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
        
        if( response.getStatusCode() != 200 ) return null;

        if ( String.isBlank( response.getBody() ) ) return null;

        return JSON.deserialize(response.getBody(), parseClass);
    }

    private void paramError(String paramName) {
        error( paramName + ' cannot be null or empty.');
    }

    private void error(String message) {
        throw new IllegalArgumentException( message );
    }
}