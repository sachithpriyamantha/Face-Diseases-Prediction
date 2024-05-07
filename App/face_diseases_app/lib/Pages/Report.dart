import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReportPage extends StatefulWidget {
  const DailyReportPage({Key? key}) : super(key: key);

  @override
  _DailyReportPageState createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  late Future<List<DocumentSnapshot>> _futureReports;

  @override
  void initState() {
    super.initState();
    _futureReports = getTodaysReports();
  }

  Future<List<DocumentSnapshot>> getTodaysReports() async {
    var today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var start = DateTime.parse("$today 00:00:00Z");
    var end = DateTime.parse("$today 23:59:59Z");

    var querySnapshot = await FirebaseFirestore.instance
        .collection('disease_reports')
        .where('date', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('date', isLessThanOrEqualTo: end.toIso8601String())
        .get();

    for (var doc in querySnapshot.docs) {
      print(doc.data()); // Debugging print
    }

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Daily Report', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 99, 172, 143),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports found for today.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index].data() as Map<String, dynamic>;
                var dateStr = data['date'] ?? 'Unknown date';
                // Adjust the format if needed to match the format of your date strings
                var formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                    .format(DateTime.parse(dateStr));
                var results = List.from(data['results']).map((result) {
                  String label = result['label'];

                  double confidence = result['confidence'] as double;
                  String confidencePercent =
                      (confidence * 100).toStringAsFixed(2) + '%';
                  // Combine label and confidence score
                  return '$label\nConfidence: $confidencePercent';
                }).join('\n\n'); // Separate different results

                return Card(
                  elevation: 4.0, // Adjust elevation to your preference
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Adjust the corner radius
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6), // Adjust the margin
                  child: ListTile(
                    title: Text(formattedDate,
                        style: TextStyle(color: Colors.blue)),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Add padding inside the card
                      child: Text(results,
                          style:
                              TextStyle(fontSize: 16)), // Style subtitle text
                    ),
                    isThreeLine: true,
                    contentPadding:
                        const EdgeInsets.all(10), // Padding inside ListTile
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
