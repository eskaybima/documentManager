/*   1:    */ package com.fasyl.newjobBo;
/*   2:    */ 
/*   3:    */ import java.io.BufferedInputStream;
/*   4:    */ import java.io.BufferedOutputStream;
/*   5:    */ import java.io.File;
/*   6:    */ import java.io.FileInputStream;
/*   7:    */ import java.io.FileNotFoundException;
/*   8:    */ import java.io.FileOutputStream;
/*   9:    */ import java.io.IOException;
/*  10:    */ import java.io.InputStream;
/*  11:    */ import java.io.OutputStream;
/*  12:    */ import java.util.zip.ZipEntry;
/*  13:    */ import java.util.zip.ZipInputStream;
/*  14:    */ import java.util.zip.ZipOutputStream;
/*  15:    */ import org.apache.commons.io.FileUtils;
/*  16:    */ import org.apache.commons.io.IOUtils;
/*  17:    */ 
/*  18:    */ public class ZipUtil
/*  19:    */ {
/*  20:    */   public static File zip(File[] sourceFiles, String destination)
/*  21:    */   {
/*  22: 36 */     return zip(sourceFiles, destination, false, 8);
/*  23:    */   }
/*  24:    */   
/*  25:    */   public static File zip(File[] sourceFiles, File destination)
/*  26:    */   {
/*  27: 40 */     return zip(sourceFiles, destination, false, 8);
/*  28:    */   }
/*  29:    */   
/*  30:    */   public static File zip(File[] sourceFiles, String destination, int compressionMethod)
/*  31:    */   {
/*  32: 52 */     return zip(sourceFiles, destination, false, compressionMethod);
/*  33:    */   }
/*  34:    */   
/*  35:    */   public static File zip(File[] sourceFiles, File destination, int compressionMethod)
/*  36:    */   {
/*  37: 56 */     return zip(sourceFiles, destination, false, compressionMethod);
/*  38:    */   }
/*  39:    */   
/*  40:    */   public static File zip(File[] sourceFiles, String destination, boolean recursively)
/*  41:    */   {
/*  42: 68 */     return zip(sourceFiles, new File(destination), recursively, 8);
/*  43:    */   }
/*  44:    */   
/*  45:    */   public static File zip(File[] sourceFiles, String destination, boolean recursively, int compressionMethod)
/*  46:    */   {
/*  47: 81 */     return zip(sourceFiles, new File(destination), recursively, compressionMethod);
/*  48:    */   }
/*  49:    */   
/*  50:    */   public static File zip(File[] sourceFiles, File destination, boolean recursively)
/*  51:    */   {
/*  52: 85 */     return zip(sourceFiles, destination, recursively, 8);
/*  53:    */   }
/*  54:    */   
/*  55:    */   public static File zip(File[] sourceFiles, File destination, boolean recursively, int compressionMethod)
/*  56:    */   {
/*  57: 89 */     if ((sourceFiles == null) || (sourceFiles.length <= 0)) {
/*  58: 90 */       throw new IllegalArgumentException("sourceFiles must include at least 1 file");
/*  59:    */     }
/*  60: 92 */     if (destination == null) {
/*  61: 93 */       throw new IllegalArgumentException("destination must be set");
/*  62:    */     }
/*  63: 95 */     ZipOutputStream out = new ZipOutputStream(outputStream(destination));
/*  64:    */     try
/*  65:    */     {
/*  66: 97 */       _zip(sourceFiles, out, -1, recursively, compressionMethod);
/*  67: 98 */       return destination;
/*  68:    */     }
/*  69:    */     catch (Exception e)
/*  70:    */     {
/*  71:100 */       throw new RuntimeException(e);
/*  72:    */     }
/*  73:    */     finally
/*  74:    */     {
/*  75:102 */       IOUtils.closeQuietly(out);
/*  76:    */     }
/*  77:    */   }
/*  78:    */   
/*  79:    */   private static void _zip(File[] files, ZipOutputStream out, int basePath, boolean recursively, int compressionMethod)
/*  80:    */   {
/*  81:107 */     for (File file : files) {
/*  82:108 */       if (file.isDirectory())
/*  83:    */       {
/*  84:109 */         if (recursively) {
/*  85:110 */           _zip(file.listFiles(), out, curBasePath(file, basePath), recursively, compressionMethod);
/*  86:    */         }
/*  87:    */       }
/*  88:    */       else
/*  89:    */       {
/*  90:112 */         InputStream in = inputStream(file);
/*  91:    */         try
/*  92:    */         {
/*  93:114 */           ZipEntry z = new ZipEntry(entryName(file, curBasePath(file, basePath)));
/*  94:115 */           z.setCrc(FileUtils.checksumCRC32(file.getAbsoluteFile()));
/*  95:116 */           z.setSize(file.length());
/*  96:117 */           z.setMethod(compressionMethod);
/*  97:118 */           out.putNextEntry(z);
/*  98:119 */           IOUtils.copy(in, out);
/*  99:    */         }
/* 100:    */         catch (IOException e)
/* 101:    */         {
/* 102:121 */           throw new RuntimeException(e);
/* 103:    */         }
/* 104:    */         finally
/* 105:    */         {
/* 106:123 */           IOUtils.closeQuietly(in);
/* 107:    */         }
/* 108:    */       }
/* 109:    */     }
/* 110:    */   }
/* 111:    */   
/* 112:    */   private static int curBasePath(File f, int basePath)
/* 113:    */   {
/* 114:130 */     return basePath >= 0 ? basePath : f.getParentFile().getAbsolutePath().length();
/* 115:    */   }
/* 116:    */   
/* 117:    */   private static String entryName(File f, int basePath)
/* 118:    */   {
/* 119:134 */     return rel(f.getAbsolutePath().substring(basePath));
/* 120:    */   }
/* 121:    */   
/* 122:    */   private static InputStream inputStream(File file)
/* 123:    */   {
/* 124:    */     try
/* 125:    */     {
/* 126:139 */       return new BufferedInputStream(new FileInputStream(file));
/* 127:    */     }
/* 128:    */     catch (FileNotFoundException e)
/* 129:    */     {
/* 130:141 */       throw new RuntimeException(e);
/* 131:    */     }
/* 132:    */   }
/* 133:    */   
/* 134:    */   private static OutputStream outputStream(File file)
/* 135:    */   {
/* 136:    */     try
/* 137:    */     {
/* 138:147 */       return new BufferedOutputStream(new FileOutputStream(file));
/* 139:    */     }
/* 140:    */     catch (FileNotFoundException e)
/* 141:    */     {
/* 142:149 */       e.printStackTrace();
/* 143:150 */       throw new RuntimeException(e);
/* 144:    */     }
/* 145:    */   }
/* 146:    */   
/* 147:    */   private static String rel(String path)
/* 148:    */   {
/* 149:156 */     return path.startsWith(File.separator) ? path.substring(1) : path;
/* 150:    */   }
/* 151:    */   
/* 152:    */   public static void unzip(File zipFile, File destination)
/* 153:    */   {
/* 154:167 */     if (zipFile == null) {
/* 155:168 */       throw new IllegalArgumentException("zipFile must be set");
/* 156:    */     }
/* 157:170 */     if (destination == null) {
/* 158:171 */       throw new IllegalArgumentException("destination must be set");
/* 159:    */     }
/* 160:173 */     if ((destination.exists()) && (destination.isFile())) {
/* 161:174 */       throw new IllegalArgumentException("destination file must be a directory");
/* 162:    */     }
/* 163:176 */     if ((!destination.exists()) && 
/* 164:177 */       (!destination.mkdirs())) {
/* 165:178 */       throw new RuntimeException("cannot create " + destination);
/* 166:    */     }
/* 167:180 */     ZipInputStream in = new ZipInputStream(inputStream(zipFile));
/* 168:    */     try
/* 169:    */     {
/* 170:    */       ZipEntry entry;
/* 171:183 */       while ((entry = in.getNextEntry()) != null)
/* 172:    */       {
/* 173:184 */         File file = new File(destination, entry.getName());
/* 174:185 */         if (entry.isDirectory())
/* 175:    */         {
/* 176:186 */           file.mkdirs();
/* 177:    */         }
/* 178:    */         else
/* 179:    */         {
/* 180:189 */           file.getParentFile().mkdirs();
/* 181:190 */           OutputStream out = outputStream(file);
/* 182:    */           try
/* 183:    */           {
/* 184:192 */             IOUtils.copy(in, out);
/* 185:    */           }
/* 186:    */           finally {}
/* 187:    */         }
/* 188:    */       }
/* 189:    */     }
/* 190:    */     catch (IOException e)
/* 191:    */     {
/* 192:198 */       throw new RuntimeException(e);
/* 193:    */     }
/* 194:    */     finally
/* 195:    */     {
/* 196:200 */       IOUtils.closeQuietly(in);
/* 197:    */     }
/* 198:    */   }
/* 199:    */ }


/* Location:           H:\lasrracentralregistry\WEB-INF\classes\
 * Qualified Name:     com.LasrraCenRep.util.ZipUtil
 * JD-Core Version:    0.7.0.1
 */