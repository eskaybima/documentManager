<%@page import="com.fasyl.util.FormatAmount"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/xml_rt" prefix="x" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="application/pdf" %>       
<%@ page import="
     java.io.*,
     java.util.*,
     java.text.*,
     com.itextpdf.text.pdf.draw.*,
     com.itextpdf.text.pdf.*,
     com.itextpdf.text.*,
     com.fasyl.newjobBo.SaveToDb"
     %>

<% response.setHeader("Content-Disposition", "attachment; filename=\"Receipt.pdf\"");
    SaveToDb sb = new SaveToDb();
    String  name = sb.getValue2("select first_name from fas_mst_users where user_id = '" + (String)session.getAttribute("username") + "'");
    //CustomerTrx customerTrx = new CustomerTrx();
    com.itextpdf.text.Document document = new com.itextpdf.text.Document(PageSize.A4); //new Document();
    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
    ServletContext context = getServletContext();
    String amtPd = request.getParameter("amtPd");
    amtPd = FormatAmount.formatAmount(amtPd);
    String payDate = request.getParameter("payDate");
    String amtDue = request.getParameter("amtDue");
    String bal = request.getParameter("bal");
    bal = FormatAmount.formatAmount(bal);
    String desc = request.getParameter("desc");
    String formattedNumber = "";
    try {
        PdfPTable table = new PdfPTable(2);
        Paragraph coyNoParagraph;
        Paragraph coyStringParagraph;
        Paragraph headerParagraph;
        Paragraph dateParagraph;
        Paragraph lineParagraph;
        Paragraph disclaimerParagraph;
        Paragraph disclaimerHeaderParagraph;
        PdfWriter writer;
        PdfContentByte canvas;
        Rectangle rectangle;
        Font headerFont;
        Font coyStringFont;
        Font receiptContentFont;
        Font disclaimerFont;
        Font disclaimerHedearFont;
        Font dateFont;
        //String headerString = "INCOME TAX CLEARANCE CERTIFICATE";
        String headerString = "OYO STATE INTERNAL REVENUE BOARD\n INCOME TAX CLEARANCE CERTIFICATE\n (Receipt No: 489405497)";
        String coyString = "PROOF OF PAYMENT";
        String coyRCNo = "RC: 196748";
        String disclaimerText = "";


        NumberFormat formatter = new DecimalFormat("0.00");


        String path = context.getRealPath("source/img/img.png");
        //String tempPdfPath = context.getRealPath("screens/scripts/resources/temp" + txnCode + ".pdf");

        //writer = PdfWriter.getInstance(document,
        //new FileOutputStream(tempPdfPath));
        writer = PdfWriter.getInstance(document, buffer); //for web
        document.open();

        System.out.println("This is the contextpath : " + document.right(document.rightMargin()) + " y coord " + document.top());
        Image image = Image.getInstance(path);

        //String date = sdf.format(ftDto.getTimeStamp());

        com.itextpdf.text.pdf.draw.LineSeparator underline = new com.itextpdf.text.pdf.draw.LineSeparator(1, 100, null, com.itextpdf.text.Element.ALIGN_CENTER, -2);

        headerParagraph = new Paragraph();
        coyStringParagraph = new Paragraph();
        coyNoParagraph = new Paragraph();
        dateParagraph = new Paragraph();
        lineParagraph = new Paragraph();

        //align header and coy name accordingly
        headerParagraph.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
        //headerParagraph.setSpacingBefore(200f); //new
        //headerParagraph.setIndentationRight(70f); //new
        coyStringParagraph.setAlignment(com.itextpdf.text.Element.ALIGN_RIGHT);
        coyNoParagraph.setAlignment(com.itextpdf.text.Element.ALIGN_RIGHT);
        //design font
        headerFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
        coyStringFont = new Font(Font.FontFamily.COURIER, 8);
        receiptContentFont = new Font(Font.FontFamily.HELVETICA, 7, Font.NORMAL);
        disclaimerFont = new Font(Font.FontFamily.HELVETICA, 7, Font.NORMAL);
        disclaimerHedearFont = new Font(Font.FontFamily.HELVETICA, 8, Font.BOLD | Font.UNDERLINE);
        dateFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL | Font.UNDERLINE);
        
        image.scaleAbsolute(140f, 50f); //102, 50
        //image.setAbsolutePosition(420f, 780f);
        //image.setAbsolutePosition(210f, 560f);
        //image.scaleAbsoluteHeight(100f);
        //image.scaleAbsoluteWidth(500f);
        image.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
        
      
       
        headerParagraph.add(new Chunk(headerString, headerFont));
        coyStringParagraph.add(new Chunk(coyString, coyStringFont));
        coyNoParagraph.add(new Chunk(coyRCNo, coyStringFont));
        document.add(image);
        document.add(headerParagraph);
        //document.add(image);
        document.add(Chunk.NEWLINE);
        
        //draw a rectangle on the document
        //canvas = writer.getDirectContent();
        //rectangle = new Rectangle(36, 360, 559, 740); //increase the 2nd cordinate to pull the rectangle up
        //rectangle.setBorder(Rectangle.BOX);
        //rectangle.setBorderWidth(1);
        //canvas.rectangle(rectangle);

        //display timestamp
        dateParagraph.setIndentationRight(50f);  //indentation not working yet
        
        //dateParagraph.add(new Chunk("Transaction Date:" + payDate));
        //document.add(dateParagraph);

        PdfPCell cell20 = new PdfPCell(new Paragraph(new Chunk("Tax Type : " + desc, receiptContentFont)));
        PdfPCell celldummy = new PdfPCell(new Paragraph(new Chunk("Form of payment : " + "via Oyo state BIR Portal", receiptContentFont)));
        PdfPCell cell21 = new PdfPCell(new Paragraph(new Chunk("Name : " + name, receiptContentFont)));
        PdfPCell cell22 = new PdfPCell(new Paragraph(new Chunk("Transaction date : " + payDate, receiptContentFont)));
        PdfPCell cell23 = new PdfPCell(new Paragraph(new Chunk("Amount Paid : " + amtPd, receiptContentFont)));
        PdfPCell cell24 = new PdfPCell(new Paragraph(new Chunk("Balance : " + bal, receiptContentFont)));
        PdfPCell cell25 = new PdfPCell(new Paragraph(new Chunk("Form of payment : " + "via Oyo state BIR Portal", receiptContentFont)));

        celldummy.setBorder(Rectangle.NO_BORDER);
        cell20.setBorder(Rectangle.NO_BORDER);
        celldummy.setPadding(15f);
        cell20.setPadding(15f);
        cell20.setNoWrap(true);
        cell21.setBorder(Rectangle.NO_BORDER);
        cell22.setBorder(Rectangle.NO_BORDER);
        cell21.setPadding(15f);
        cell22.setPadding(15f);
        cell23.setBorder(Rectangle.NO_BORDER);
        cell24.setBorder(Rectangle.NO_BORDER);
        cell23.setPadding(15f);
        cell24.setPadding(15f);
        cell25.setBorder(Rectangle.NO_BORDER);

        table.addCell(cell20);
        table.addCell(celldummy);
        table.addCell(cell21);
        table.addCell(cell22);
        table.addCell(cell23);
        table.addCell(cell24);
        table.addCell(cell25);

        document.add(Chunk.NEWLINE);
        document.add(table);
        document.add(Chunk.NEWLINE);
        document.add(Chunk.NEWLINE);
        lineParagraph.add(underline);

        //document.add(lineParagraph);

        document.add(Chunk.NEWLINE);

        //add disclaimer
        disclaimerHeaderParagraph = new Paragraph(new Chunk("", disclaimerHedearFont));
        disclaimerParagraph = new Paragraph(new Chunk(disclaimerText, disclaimerFont));
        disclaimerParagraph.setLeading(10f);
        document.add(disclaimerHeaderParagraph);
        document.add(disclaimerParagraph);
        document.close();
        addWaterColor(response, buffer, context); //add water color effect to the tempFile.pdf
//      addWaterColor(response, buffer, context, txnCode);
    } catch (DocumentException ex) {
        System.out.println("Error message1: " + ex.getMessage());
    } catch (FileNotFoundException ex) {
        System.out.println("Error message2: " + ex.getMessage());
    }

%>

<%!
    public void addWaterColor(HttpServletResponse response, ByteArrayOutputStream buffer, ServletContext context) {
//        String tempPdfPath = context.getRealPath("screens/scripts/resources/temp" + txnCode.toString() + ".pdf");
//        String PdfFilePath = context.getRealPath("screens/scripts/resources/TFTReceipt.pdf");
        try {
            PdfReader Read_PDF_To_Watermark = new PdfReader(buffer.toByteArray()); //read the temp pdf to apply water color effect on
            int number_of_pages = Read_PDF_To_Watermark.getNumberOfPages();
            //PdfStamper stamp = new PdfStamper(Read_PDF_To_Watermark, new FileOutputStream(PdfFilePath));
            PdfStamper stamp = new PdfStamper(Read_PDF_To_Watermark, buffer);
            int i = 0;
            String path = context.getRealPath("source/img/receipt_template.JPG");
            Image watermark_image = Image.getInstance(path);
//            watermark_image.setAbsolutePosition(50, 400);
            watermark_image.setAbsolutePosition(350, 650);
//            watermark_image2.setAbsolutePosition(350, 650);
//            watermark_image3.setAbsolutePosition(350, 500);
            PdfContentByte add_watermark;
            while (i < number_of_pages) {
                i++;
                add_watermark = stamp.getUnderContent(i);
                add_watermark.addImage(watermark_image);
//                add_watermark.addImage(watermark_image1);
//                add_watermark.addImage(watermark_image2);
//                add_watermark.addImage(watermark_image3);
            }
            stamp.close();
            DataOutput dataOutput = new DataOutputStream(response.getOutputStream());
            byte[] bytes = buffer.toByteArray();
            response.setContentLength(bytes.length);
            for (int j = 0; j < bytes.length; j++) {
                dataOutput.writeByte(bytes[j]);
            }
            response.flushBuffer();
        } catch (Exception i1) {
            i1.printStackTrace();
        }
    }

%>