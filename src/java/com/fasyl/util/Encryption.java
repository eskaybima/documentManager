/*   1:    */ package com.fasyl.util;
/*   2:    */ 
/*   3:    */ import java.io.IOException;
/*   4:    */ import java.io.UnsupportedEncodingException;
/*   5:    */ import java.net.URLDecoder;
/*   6:    */ import java.net.URLEncoder;
/*   7:    */ import java.security.InvalidKeyException;
/*   8:    */ import java.security.NoSuchAlgorithmException;
/*   9:    */ import java.security.spec.InvalidKeySpecException;
/*  10:    */ import java.security.spec.KeySpec;
/*  11:    */ import javax.crypto.BadPaddingException;
/*  12:    */ import javax.crypto.Cipher;
/*  13:    */ import javax.crypto.IllegalBlockSizeException;
/*  14:    */ import javax.crypto.NoSuchPaddingException;
/*  15:    */ import javax.crypto.SecretKey;
/*  16:    */ import javax.crypto.SecretKeyFactory;
/*  17:    */ import javax.crypto.spec.DESKeySpec;
/*  18:    */ import sun.misc.BASE64Decoder;
/*  19:    */ import sun.misc.BASE64Encoder;
/*  20:    */ 
/*  21:    */ public class Encryption
/*  22:    */ {
/*  23:    */   private static final String tope = "temitope";
/*  24:    */   private static String decurl;
/*  25:    */   private static String enurl;
/*  26:    */   private static SecretKey key;
/*  27:    */   private static KeySpec keySpec;
/*  28:    */   
/*  29:    */   public Encryption()
/*  30:    */   {
/*  31:    */     try
/*  32:    */     {
/*  33: 35 */       keySpec = new DESKeySpec("temitope".getBytes());
/*  34: 36 */       key = SecretKeyFactory.getInstance("DES").generateSecret(keySpec);
/*  35:    */     }
/*  36:    */     catch (InvalidKeySpecException e)
/*  37:    */     {
/*  38: 38 */       e.printStackTrace();
/*  39:    */     }
/*  40:    */     catch (InvalidKeyException e)
/*  41:    */     {
/*  42: 40 */       e.printStackTrace();
/*  43:    */     }
/*  44:    */     catch (NoSuchAlgorithmException e)
/*  45:    */     {
/*  46: 42 */       e.printStackTrace();
/*  47:    */     }
/*  48:    */   }
/*  49:    */   
/*  50:    */   public static String encrypt(String msg)
/*  51:    */   {
/*  52:    */     try
/*  53:    */     {
/*  54: 49 */       keySpec = new DESKeySpec("temitope".getBytes());
/*  55: 50 */       key = SecretKeyFactory.getInstance("DES").generateSecret(keySpec);
/*  56:    */       
/*  57: 52 */       Cipher ecipher = Cipher.getInstance(key.getAlgorithm());
/*  58:    */       
/*  59: 54 */       ecipher.init(1, key);
/*  60:    */       
/*  61: 56 */       byte[] utf8 = msg.getBytes("UTF8");
/*  62: 57 */       byte[] enc = ecipher.doFinal(utf8);
/*  63:    */       
/*  64: 59 */       enurl = new BASE64Encoder().encode(enc);
/*  65:    */       
/*  66: 61 */      return URLEncoder.encode(enurl);
/*  67:    */     }
/*  68:    */     catch (InvalidKeyException e)
/*  69:    */     {
/*  70: 63 */       e.printStackTrace();
/*  71:    */     }
/*  72:    */     catch (NoSuchAlgorithmException e)
/*  73:    */     {
/*  74: 65 */       e.printStackTrace();
/*  75:    */     }
/*  76:    */     catch (NoSuchPaddingException e)
/*  77:    */     {
/*  78: 67 */       e.printStackTrace();
/*  79:    */     }
/*  80:    */     catch (IllegalStateException e)
/*  81:    */     {
/*  82: 69 */       e.printStackTrace();
/*  83:    */     }
/*  84:    */     catch (IllegalBlockSizeException e)
/*  85:    */     {
/*  86: 71 */       e.printStackTrace();
/*  87:    */     }
/*  88:    */     catch (BadPaddingException e)
/*  89:    */     {
/*  90: 73 */       e.printStackTrace();
/*  91:    */     }
/*  92:    */     catch (UnsupportedEncodingException e)
/*  93:    */     {
/*  94: 75 */       e.printStackTrace();
/*  95:    */     }
/*  96:    */     catch (InvalidKeySpecException e)
/*  97:    */     {
/*  98: 77 */       e.printStackTrace();
/*  99:    */     }
/* 100: 81 */     return enurl;
/* 101:    */   }
/* 102:    */   
/* 103:    */   public static String decrypt(String msg)
/* 104:    */   {
/* 105: 86 */     byte[] decode = null;
/* 106: 87 */     String ss = URLDecoder.decode(msg);
/* 107:    */     try
/* 108:    */     {
/* 109: 90 */       Cipher decipher = Cipher.getInstance(key.getAlgorithm());
/* 110:    */       
/* 111: 92 */       decipher.init(2, key);
/* 112: 93 */       decode = new BASE64Decoder().decodeBuffer(ss);
/* 113:    */       
/* 114: 95 */       byte[] utf8 = decipher.doFinal(decode);
/* 115:    */       
/* 116: 97 */       decurl = new String(utf8, "UTF8");
/* 117:    */       
/* 118:    */ 
/* 119:100 */       return decurl;
/* 120:    */     }
/* 121:    */     catch (InvalidKeyException e)
/* 122:    */     {
/* 123:104 */       e.printStackTrace();
/* 124:    */     }
/* 125:    */     catch (NoSuchAlgorithmException e)
/* 126:    */     {
/* 127:109 */       e.printStackTrace();
/* 128:    */     }
/* 129:    */     catch (NoSuchPaddingException e)
/* 130:    */     {
/* 131:111 */       e.printStackTrace();
/* 132:    */     }
/* 133:    */     catch (IOException e)
/* 134:    */     {
/* 135:113 */       e.printStackTrace();
/* 136:    */     }
/* 137:    */     catch (IllegalStateException e)
/* 138:    */     {
/* 139:115 */       e.printStackTrace();
/* 140:    */     }
/* 141:    */     catch (IllegalBlockSizeException e)
/* 142:    */     {
/* 143:117 */       e.printStackTrace();
/* 144:    */     }
/* 145:    */     catch (BadPaddingException e)
/* 146:    */     {
/* 147:119 */       e.printStackTrace();
/* 148:    */     }
/* 149:124 */     return decurl;
/* 150:    */   }
/* 151:    */   
/* 152:    */   public String encodeURL(String url)
/* 153:    */   {
/* 154:    */     try
/* 155:    */     {
/* 156:129 */       return URLEncoder.encode(url, "UTF-8");
/* 157:    */     }
/* 158:    */     catch (UnsupportedEncodingException e)
/* 159:    */     {
/* 160:133 */       e.printStackTrace();
/* 161:    */     }
/* 162:136 */     return null;
/* 163:    */   }
/* 164:    */ }


/* Location:           H:\lasrracentralregistry\WEB-INF\classes\
 * Qualified Name:     com.LasrraCenRep.util.Encryption
 * JD-Core Version:    0.7.0.1
 */