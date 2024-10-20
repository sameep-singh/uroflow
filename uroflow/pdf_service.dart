import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:fl_chart/fl_chart.dart';

class PDFService {
  Future<void> generatePDF(String patientName, List<FlSpot> dataPoints) async {
    final pdf = pw.Document();

    // Generate PDF content
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("UROFLOW Report", style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text("Patient Name: $patientName", style: pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 10),
            pw.Text("Date: ${DateTime.now().toLocal()}", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 20),
            pw.Text("Flow Rate Data Points:", style: pw.TextStyle(fontSize: 20)),
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
                      child: pw.Text("${dataPoint.x.toStringAsFixed(2)}"),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text("${dataPoint.y.toStringAsFixed(2)}"),
                    ),
                  ]);
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );

    // Get the Downloads directory path
    final downloadsDir = Directory('${Platform.environment['USERPROFILE']}\\Downloads');
    if (!downloadsDir.existsSync()) {
      downloadsDir.createSync(recursive: true);
    }

    // Save the PDF to the Downloads folder
    File file = File('${downloadsDir.path}/uroflow_report.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
