import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/pdf_service.dart';

class DashboardPage extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final List<FlSpot> dataPoints;

  DashboardPage({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.dataPoints,
  });

  Future<void> _generateAndPrintPDF(BuildContext context) async {
    PDFService pdfService = PDFService();
    await pdfService.generatePDF(name, dataPoints);  // Pass patient name here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF saved successfully!')),
    );
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
            Text("Name: $name"),
            Text("Email: $email"),
            Text("Role: $role"),
            const SizedBox(height: 20),

            // Graph displaying data points
            Expanded(
              child: dataPoints.isNotEmpty
                  ? LineChart(LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: dataPoints,
                          isCurved: true,
                          colors: [Colors.blue],
                        ),
                      ],
                    ))
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
