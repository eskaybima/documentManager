// bayeesoft.com;

//import bayeesoft.com.convertScannedImage;
//import com.asprise.imaging.scan.Device;
//import com.asprise.imaging.scan.FunctionalUnit;
//import com.asprise.imaging.scan.PaperSize;
//import com.asprise.imaging.scan.ScanManager;
//import com.asprise.imaging.scan.Utils;
//import java.applet.Applet;

import java.io.File;
import java.io.IOException;
//import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JApplet;

/**
 *
 * @author Adebayo
 */
public class callAppletClass   extends JApplet {
    //FunctionalUnit   functionalUnit  ;
    ///public static void main(String[] args) throws IOException {
         
      //  callAppletClass scandoc = new callAppletClass();
       /// scandoc.scanImage();
    //scanImage() ;
   // }
     
     @Override
     public void init()  {
         try {
             Runtime.getRuntime().exec("C:\\NAPS2\\NAPS2.exe", null, new File("C:\\NAPS2\\"));    
         //List devices = ScanManager.getDefaultManager().getDevices(); // list all devices
         //String deviceId = ScanManager.getDefaultManager().selectDeviceUsingUI(); // UI select
         //Device device = Utils.searchDevice(devices, deviceId); // device object obtained
         //
         //
         //List<FunctionalUnit> functionalUnits = device.getFunctionalUnits();
         //FunctionalUnit functionalUnit = functionalUnits.get(0);
         //
         //
         //functionalUnit.setPixelDataType((FunctionalUnit.PixelDataType.COLOR)); // set capabilities
         //functionalUnit.setBitDepth(FunctionalUnit.BitDepth.BIT_DEPTH_24_BITS);
         //functionalUnit.setResolution(300);
         //functionalUnit.setContrast(20);
         //functionalUnit.setBrightness(10);
         //functionalUnit.setPaperSize(PaperSize.LETTER);
         //System.out.println("About to call scan function");
         //
         //File[] files = ScanManager.getDefaultManager().quickScanUsingUI(new File("C://Users//Adebayo//Desktop//A2000127"), null);
         //convertScannedImage converttoXml = new convertScannedImage();
         //converttoXml.useOcrtoConvert(files) ;
         /**
         functionalUnit.scanOnePage(new File("c://doc.JPEG"), new ScanProgressListener() {
           @Override
           public void started() {
             // progressBarScanPureJava.setValue(0);
           }

           @Override
           public void progress(final int percent) {
             // progressBarScanPureJava.setValue(percent);
           }

           @Override
           public void finished(String error) {
             // progressBarScanPureJava.setValue(100);
           }
         }, null);
              
              }
              **/
         } catch (IOException ex) {
             Logger.getLogger(callAppletClass.class.getName()).log(Level.SEVERE, null, ex);
         }

     }
}
