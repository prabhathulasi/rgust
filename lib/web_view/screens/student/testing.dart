// import 'dart:convert';
// import 'dart:html' as html;
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';




// /// Represents the PDF widget class.
// class CreatePdfWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CreatePdfStatefulWidget(),
//     );
//   }
// }

// /// Represents the PDF stateful widget class.
// class CreatePdfStatefulWidget extends StatefulWidget {
//   /// Initalize the instance of the [CreatePdfStatefulWidget] class.
//   const CreatePdfStatefulWidget({Key? key}) : super(key: key);

//   @override
//   _CreatePdfState createState() => _CreatePdfState();
// }

// class _CreatePdfState extends State<CreatePdfStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create PDF document'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.lightBlue,
//                 disabledForegroundColor: Colors.grey,
//               ),
//               onPressed: generateInvoice,
//               child: const Text('Generate PDF'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Future<Uint8List> _readImageData(String imagePath) async {
//   final ByteData data = await rootBundle.load(imagePath);
//   return data.buffer.asUint8List();
// }

//   Future<void> generateInvoice() async {
//     //Create a PDF document.
//     final PdfDocument document = PdfDocument();
//     //Add page to the PDF
//     final PdfPage page = document.pages.add();
//     //Get page client size
//     final Size pageSize = page.getClientSize();
//       final Uint8List imageData =  await _readImageData('assets/rgust.png');
//   final PdfBitmap image = PdfBitmap(imageData);
//     //Draw rectangle
//     // page.graphics.drawRectangle(
//     //     bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
//     //     pen: PdfPen(PdfColor(142, 170, 219)));
//     //Generate PDF grid.
//     final PdfGrid grid = getGrid();
    
//     //Draw the header section by creating text element
//     final PdfLayoutResult result = drawHeader(page, pageSize, grid,image);
//     //Draw grid
//     drawGrid(page, grid, result);
//      page.graphics.drawString(
      
//         'Important: ', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold,multiStyle: [
//           PdfFontStyle.underline
//         ]),
//         brush: PdfBrushes.black,
//         bounds: Rect.fromLTWH(0, pageSize.height/2.5, 150, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
//           // Create a list
//   final PdfList list = PdfOrderedList();

//   // Add list items
  
//   list.items.add(PdfListItem(text: 'Please Scan and email all wire transfer slips/deposit slips with your name and details of payment to tf@rgust.edu.gy'));
  
//   list.items.add(PdfListItem(text: 'Submit a hard copy of you deposit slip to the Administrative office'));
//   list.items.add(PdfListItem(text: 'Ensure you submit this invoice to the bank when making payments'));

//   // Draw the list on the PDF page
//   list.draw(
//     page: page,
//     bounds: Rect.fromLTWH(0, pageSize.height/2.1, page.getClientSize().width, page.getClientSize().height),
//   );
//       page.graphics.drawString(
      
//         'Note :This is a computer-generated invoice and does not necessarily require an authorized signature.', PdfStandardFont(PdfFontFamily.helvetica, 8,style: PdfFontStyle.bold),
//         brush: PdfBrushes.red,
//         bounds:  Rect.fromLTWH(0, pageSize.height/2, pageSize.width, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
//     //Add invoice footer
//     drawFooter(page, pageSize);
//     //Save the PDF document
//     final List<int> bytes = document.saveSync();
//     //Dispose the document.
//     document.dispose();
//     //Save and launch the file.
//     await saveAndLaunchFile(bytes, 'Invoice.pdf');
//   }
// Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//   Uint8List uint8List = Uint8List.fromList(
//     bytes.map((value) => value.clamp(0, 255)).toList()
//   );
//      final blob = html.Blob(
//                                                 [uint8List], 'application/pdf');
//                                             final url = html.Url
//                                                 .createObjectUrlFromBlob(blob);

//                                             // Open the blob URL in a new tab
//                                             html.window.open(url, '_blank');

// }

//   //Draws the invoice header
//   PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,PdfBitmap image ) {
//   // Load the image

//     //Draw rectangle
//     page.graphics.drawRectangle(
//         brush: PdfSolidBrush(PdfColor(255,255,255)),
//         bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
//     //Draw string
//     page.graphics.drawImage(image, const Rect.fromLTWH(0, 0, 90, 90));
//     page.graphics.drawString(
      
//         'RAJIV GANDHI UNIVERSITY OF SCIENCE AND TECHNOLOGY', PdfStandardFont(PdfFontFamily.helvetica, 13,style: PdfFontStyle.bold),
//         brush: PdfBrushes.navy,
//         bounds: Rect.fromLTWH(100, 0, pageSize.width - 115, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

//  page.graphics.drawString(
      
//         'Finance Department', PdfStandardFont(PdfFontFamily.helvetica, 13,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: Rect.fromLTWH(pageSize.width /2.5, 20, 150, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));


//  page.graphics.drawString(
      
//         'Student Invoice', PdfStandardFont(PdfFontFamily.helvetica, 13,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: Rect.fromLTWH(pageSize.width /2.5, 60, 150, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

//          page.graphics.drawString(
      
//         'Student Name: Prabhakaran Thulasi', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(0, 80, 300, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
//   page.graphics.drawString(
      
//         'Invoice No: Rgust/23/11/001', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(0, 100, 300, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

//       page.graphics.drawString(
      
//         'Invoice Date: 1st Nov 2023', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(380, 80, 300, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
//          page.graphics.drawString(
      
//         'Program: MD', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold),
//         brush: PdfBrushes.black,
//         bounds: const Rect.fromLTWH(380, 100, 300, 90),
//         format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
          
//     return PdfTextElement().draw(
//         page: page,
//         bounds: Rect.fromLTWH(30, 120,
//             pageSize.width, pageSize.height - 120))!;
//   }

//   //Draws the grid
//   void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
//     Rect? totalPriceCellBounds;
//     Rect? quantityCellBounds;
//     //Invoke the beginCellLayout event.
//     grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
//       final PdfGrid grid = sender as PdfGrid;
//       if (args.cellIndex == grid.columns.count - 1) {
//         totalPriceCellBounds = args.bounds;
//       } else if (args.cellIndex == grid.columns.count - 2) {
//         quantityCellBounds = args.bounds;
//       }
//     };
//     //Draw the PDF grid and get the result.
//     result = grid.draw(
//         page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;

//     //Draw grand total.
//     page.graphics.drawString('Grand Total',
//         PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
//         bounds: Rect.fromLTWH(
//             quantityCellBounds!.left,
//             result.bounds.bottom + 10,
//             quantityCellBounds!.width,
//             quantityCellBounds!.height));
//     page.graphics.drawString(getTotalAmount(grid).toString(),
//         PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
//         bounds: Rect.fromLTWH(
//             totalPriceCellBounds!.left,
//             result.bounds.bottom + 10,
//             totalPriceCellBounds!.width,
//             totalPriceCellBounds!.height));
//   }

//   //Draw the invoice footer data.
//   void drawFooter(PdfPage page, Size pageSize) {
//     final PdfPen linePen =
//         PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
//     linePen.dashPattern = <double>[3, 3];
//     //Draw line
//     page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
//         Offset(pageSize.width, pageSize.height - 100));

//     const String footerContent =
//         // ignore: leading_newlines_in_multiline_strings
//         '''Third Street, Cummingslodge, Georgetown, Guyana South America.\r\nTelephone#: +(592) 222-6080\r\nemail: financedepartment@rgust.edu.gy\r\nWebsite: www.rgust.edu.gy''';

//     //Added 30 as a margin for the layout
//     page.graphics.drawString(
//       brush: PdfBrushes.blue,
//         footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9,style: PdfFontStyle.bold),
//         format: PdfStringFormat(alignment: PdfTextAlignment.center),
//         bounds: Rect.fromLTWH(pageSize.width/2, pageSize.height - 70, 0, 0));
//   }

//   //Create PDF grid and return
//   PdfGrid getGrid() {
//     //Create a PDF grid
//     final PdfGrid grid = PdfGrid();
//     //Secify the columns count to the grid.
//     grid.columns.add(count: 4);
//     //Create the header row of the grid.
//     final PdfGridRow headerRow = grid.headers.add(1)[0];
//     //Set style
//     headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
//     headerRow.style.textBrush = PdfBrushes.black;
//     headerRow.cells[0].value = 'Details';
//     headerRow.cells[1].value = 'Standard Tuition (USD)';
//     headerRow.cells[2].value = 'Scholarship Offered (USD)';
//     headerRow.cells[3].value = 'Payable Amount';
  
//     //Add rows
//     addProducts('Examination Fee', '50', 0, 50, grid);
//     // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, grid);
//     // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2,  grid);
//     // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, grid);
//     // addProducts('FK-5136', 'ML Fork', 175.49, 6, grid);
//     // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, grid);
//     //Apply the table built-in style
//     grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
//     //Set gird columns width
//     grid.columns[1].width = 200;
//     for (int i = 0; i < headerRow.cells.count; i++) {
//       headerRow.cells[i].style.cellPadding =
//           PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
//     }
//     for (int i = 0; i < grid.rows.count; i++) {
//       final PdfGridRow row = grid.rows[i];
//       for (int j = 0; j < row.cells.count; j++) {
//         final PdfGridCell cell = row.cells[j];
//         if (j == 0) {
//           cell.stringFormat.alignment = PdfTextAlignment.center;
//         }
//         cell.style.cellPadding =
//             PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
//       }
//     }
//     return grid;
//   }

//   //Create and row for the grid.
//   void addProducts(String productId, String productName, double price,
//       int quantity, PdfGrid grid) {
//     final PdfGridRow row = grid.rows.add();
//     row.cells[0].value = productId;
//     row.cells[1].value = productName;
//     row.cells[2].value = price.toString();
//     row.cells[3].value = quantity.toString();
   
//   }

//   //Get the total amount.
//   double getTotalAmount(PdfGrid grid) {
//     double total = 0;
//     for (int i = 0; i < grid.rows.count; i++) {
//       final String value =
//           grid.rows[i].cells[grid.columns.count - 1].value as String;
//       total += double.parse(value);
//     }
//     return total;
//   }
// }