/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;



import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Admin
 */
public class Test {
    
    public static  void main(String[] args) throws IOException{
//        String passportNumber = "A0367328";
//     File file = new File("C://ImmArchive//"+ passportNumber + ".txt" );
////             file.createNewFile();   
//        String lines = "\n" + "Dr Murphy" + "\n" + "Oyewole";
//        System.out.println(lines);
        
//  File f = new File("C://Users//Admin//Desktop//test.txt");  //C:\Users\Admin\Desktop
//  
//  
//              String form = "Surame :......\n"
//                           +"Firstname :....\n"
//                           + "Middlename :....\n";
//                    
//                    FileUtils.writeStringToFile(f, form, true);
////                    FileUtils.writeStringToFile(f, "\n", true);
////                    FileUtils.writeStringToFile(f, "FIRSTNAME : " +"MORUFF"  + "\n", true);
////                     FileUtils.writeStringToFile(f, "\n", true);
////                    FileUtils.writeStringToFile(f, "MIDDLENAME : " +"OLAWALE"  + "\n", true);
////                     FileUtils.writeStringToFile(f, "\n", true);
////                    FileUtils.writeStringToFile(f, "STATE OF ORIGIN : " +"OSUN"  + "\n", true);
////                      FileUtils.writeStringToFile(f, "\n", true);
//// 
 //       FileUtils.writeStringToFile(f, "DATE OF BIRTH : " + "08/08/86" + "\n", true);
// //        String[] dir =  listDirectory("C://ImmArchive//"); //  C:\Immigration //C:\Users\Admin\Desktop\Profile Pictures
//        String kk = "C://Users//Admin//Desktop//Profile Pictures//";
//         String[] dir =  listDirectory("C://Users//Admin//Desktop//Profile Pictures//");
//       // String imagePath = "C://Immigration//" + dir[0];
//        System.out.println(" This is the number of the file " + dir.length);
//        for (int i = 0; i <= dir.length - 1; i++) {
//            String imagePath = kk + dir[i];
//        System.out.println(".........." + imagePath);
//        }
        
//        Collection<File> files = FileUtils.listFiles(new File("C://Users//Admin//Desktop//Profile Pictures//"), new String[] {"jpg", "txt"}, false);
//        Iterator<File> itr = files.iterator();
//        File[] file = new File[4]; int i = 0;    
//                while (itr.hasNext()) {
//                   File f = (File) itr.next();
//                   file[i] = f;
//                   i++;
//                   System.out.println("..........,,,......."+f.getPath());
//                   
//                }  
//                File dest = new File("C://Users//Admin//Desktop//mm.zip");
//                ZipUtil.zip(file, dest, true);
//                
//                Iterator<File> itrr = files.iterator();
//                int k = 0;   
//                while (itrr.hasNext()) {
//                   File f = (File) itrr.next();
//                   file[k] = f;
//                   k++;
//                   System.out.println("..........deleting now,.......");
//                   f.delete();
//                }  
//            (new File("C://Users//Admin//Desktop//Profile Pictures//")).delete();
            
//     
//      
//        Collection<File> filetxt = FileUtils.listFiles(new File("C://ImmArchive//"), new String[]{"txt"}, false);
//        Iterator<File> itr = filetxt.iterator();
//        while (itr.hasNext()) {
//            File f = (File) itr.next();
//            System.out.println("................doing one " + f.getPath());
//        }
            
//        String[] dir = listDirectory("C://ImmArchive//");
//        String[] dirprocessed = listDirectory("C://Users//Admin//Desktop//ProcessedJobs//");  
//         
//        List<String> listone = new ArrayList<String>();
//        List<String> listtwo = new ArrayList<String>();
//        
////        listone.add("123");
////        listone.add("322");
////        listone.add("325");
////        listone.add("326");
////        
////        listtwo.add("123");
////        listtwo.add("122");
////        listtwo.add("125");
////        listtwo.add("126");
//        
//        
//        
//        String toprocess = null;
//        for(int i = 0; i < dir.length; i++){
//        System.out.println(dir[i] + "...in two");
//        listtwo.add(dir[i]);
//        }
//        //AD1245637 
//        //AD1245637
//        Collection<File> files = FileUtils.listFiles(new File("C://Users//Admin//Desktop//ProcessedJobs//"), new String[]{"zip"}, false);
//        Iterator<File> itr = files.iterator();
//        while(itr.hasNext()){
//        File f = (File)itr.next();
// //       System.out.println(f.getName().replace(".zip", ""));
////         System.out.println((f.getName().replace(".zip", "")).equals(ii) );
//         String name = f.getName().replace(".zip", "");
//         System.out.println(name);
//        listone.add(name);
//        }
//        
//        
//        for(int i = 0; i < listtwo.size(); i++){
//            if (!listone.contains(listtwo.get(i))) {
//                System.out.println(listtwo.get(i) + ".....to be processed");
//            }
//        }
//        
        
        
//        for(int i = 0; i < listtwo.size(); i++){
//            boolean found = false;
//           for (int j = 0; j < listone.size(); j++){
//           found =  listone.get(j).equalsIgnoreCase(listtwo.get(i));
//           System.out.println(listone.get(j) + "vs " +listtwo.get(i));
//           System.out.println(found);
//           if (!found) {
//               continue;
//           }
//           toprocess = listtwo.get(i);
//           System.out.println(toprocess + "to process");
//           break;
//           }
//        }
//    String  passportNumber = "A142562783";   
//    String search = " passport_no like '%" + passportNumber + "%' and ";
//    search = search.substring(0, search.length() - 4);ber + "%' and ";
//    String query = "select ref_id from fas_int_doc where " + search;    
        String dd = "2010-03-04";
        dd = dd.substring(0, 4);
    System.out.println(dd);
    }
    public static String[] listDirectory(String path)
  {
    File file = new File(path);
    String[] directories = file.list(new FilenameFilter()
    {
      public boolean accept(File dir, String name)
      {
        return new File(dir, name).isDirectory();
      }
    });
    return directories;
  } 
        
    }
    
