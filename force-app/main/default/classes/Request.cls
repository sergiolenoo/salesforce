public interface Request {
    
    HttpRequest getHttpRequest();

    Object withEndPoint(String endpoint);

    Object withBody(String body);

    Object withBody(Blob body);

    Object withTimeout(Integer timeout);

    Object withContentType(String contentType);

    Object withHeader(String key, String value);

    Object withHeaders(Map<String, String> headers);

    Object withClientCertificateName(String certDevName);

    String getString();

    HttpResponse send();

    Object getParsedResponse(System.Type parseClass);
}