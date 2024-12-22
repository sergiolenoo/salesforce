/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public interface Request {
    
    HttpRequest getHttpRequest();

    Request withEndPoint(String endpoint);

    Request withBody(String body);

    Request withBody(Blob body);

    Request withTimeout(Integer timeout);

    Request withContentType(String contentType);

    Request withHeader(String key, String value);

    Request withHeaders(Map<String, String> headers);

    Request withClientCertificateName(String certDevName);

    String getString();

    HttpResponse send();

    Object getParsedResponse(System.Type parseClass);
}