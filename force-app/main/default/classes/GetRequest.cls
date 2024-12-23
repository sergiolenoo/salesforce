/**
 * @author @sergiolenoo - Sérgio Murilo Moreira de Oliveira
 */
public virtual class GetRequest extends AbstractOutboundHttpRequest {//sharing mode inhited from abstract class
    public GetRequest() {
        super('GET');
    }
}