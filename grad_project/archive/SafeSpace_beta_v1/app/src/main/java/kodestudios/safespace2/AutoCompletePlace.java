package kodestudios.safespace2;

/**
 * Created by kosba on 12/1/15.
 */
public class AutoCompletePlace {

    private String id;
    private String description;

    public AutoCompletePlace( String id, String description ) {
        this.id = id;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription( String description ) {
        this.description = description;
    }

    public String getId() {
        return id;
    }

    public void setId( String id ) {
        this.id = id;
    }
}
