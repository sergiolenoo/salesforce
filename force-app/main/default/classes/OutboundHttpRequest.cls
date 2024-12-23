/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public interface OutboundHttpRequest {
    
    HttpRequest getHttpRequest();

    OutboundHttpRequest withEndPoint(String endpoint);

    OutboundHttpRequest withBody(String body);

    OutboundHttpRequest withBody(Blob body);

    OutboundHttpRequest withTimeout(Integer timeout);

    OutboundHttpRequest withContentType(String contentType);

    OutboundHttpRequest withHeader(String key, String value);

    OutboundHttpRequest withHeaders(Map<String, String> headers);

    OutboundHttpRequest withClientCertificateName(String certDevName);

    String getString();

    HttpResponse send();

    Object getParsedBody(System.Type parseClass);
}