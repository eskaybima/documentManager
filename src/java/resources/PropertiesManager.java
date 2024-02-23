package resources;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.apache.log4j.Logger;


public class PropertiesManager {

    final static Logger logger = Logger.getLogger(PropertiesManager.class);
    private final Properties configProp = new Properties();

    private PropertiesManager() {
        //Private constructor to restrict new instances
         InputStream inStream  = null;
        try {
         // inStream = this.getClass().getResourceAsStream("/app.properties");
         inStream = this.getClass().getResourceAsStream("/resources/app.properties");
            configProp.load(inStream);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error while loading properties file: " + e.getMessage());
        }
    }

    //Bill Pugh Solution for singleton pattern
    private static class LazyHolder {

        private static final PropertiesManager INSTANCE = new PropertiesManager();
    }

    public static PropertiesManager getInstance() {
        return LazyHolder.INSTANCE;
    }

    public String getProperty(String key) {
        return configProp.getProperty(key);
    }

}
