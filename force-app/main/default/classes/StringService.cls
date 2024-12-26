/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public class StringService {
    
    public static String extractNumbers(String text) {
        return text == null ? '' : text.replaceAll('[^0-9]','');
    }
}