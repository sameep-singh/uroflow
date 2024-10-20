import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';

class PDFService {
  Future<void> generatePDF(String patientName, List<FlSpot> dataPoints, Uint8List chartImage) async {
    final pdf = pw.Document();

    // Add a page with content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("UROFLOW Report", style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text("Patient Name: $patientName", style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Text("Date: ${DateTime.now().toLocal()}", style: const pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 20),
            pw.Text("Flow Rate Data Points:", style: const pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text("Point", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text("Flow Rate", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                ]),
                ...dataPoints.map((dataPoint) {
                  return pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(dataPoint.x.toStringAsFixed(2)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(dataPoint.y.toStringAsFixed(2)),
                    ),
                  ]);
                }),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text("Graph:", style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            // Embed the graph image
            pw.Image(pw.MemoryImage(chartImage)),
          ],
        ),
      ),
    );

    // Get the application directory path
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/uroflow_report.pdf';

    // Save the PDF file to the app directory
    File file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    print('PDF saved at $filePath');
  }
}
