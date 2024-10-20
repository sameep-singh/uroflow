import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data'; 
import 'package:uroflow/services/pdf_service.dart';
import 'dart:ui' as ui;

class DashboardPage extends StatefulWidget {
  final String name;
  final String email;
  final String role;
  final List<FlSpot> dataPoints;

  const DashboardPage({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.dataPoints,
  });

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey _repaintKey = GlobalKey();

  Future<void> _generateAndPrintPDF(BuildContext context) async {
    // Capture the graph as an image
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    
    // Convert the image to byte data
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    // Check if byteData is not null before accessing its buffer
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Generate PDF with the chart image
      PDFService pdfService = PDFService();
      await pdfService.generatePDF(widget.name, widget.dataPoints, pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to capture the image for the PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User profile information
            Text("Name: ${widget.name}"),
            Text("Email: ${widget.email}"),
            Text("Role: ${widget.role}"),
            const SizedBox(height: 20),

            // Graph displaying data points
            Expanded(
              child: widget.dataPoints.isNotEmpty
                  ? RepaintBoundary(
                      key: _repaintKey,
                      child: LineChart(LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: widget.dataPoints,
                            isCurved: true,
                            colors: [Colors.blue],
                          ),
                        ],
                      )),
                    )
                  : const Center(child: Text("No data points to display")),
            ),

            // Button to generate PDF
            ElevatedButton(
              onPressed: () => _generateAndPrintPDF(context),
              child: const Text("Save Graph as PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
