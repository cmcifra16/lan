import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';
import '../custom/clip_path_bg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formattedDate = formatter.format(now);

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomHomeContainer(height: double.infinity),
        Center(
          child: Container(
            height: 600,
            margin: const EdgeInsets.all(15),
            width:
                MediaQuery.of(context).size.width > 700 ? 600 : double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    'Announcement!'.toUpperCase(),
                    weight: FontWeight.w700,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Announcement')
                        .orderBy('Date', descending: true)
                        .limit(8)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data =
                              documents[index].data() as Map<String, dynamic>;
                          final title = data['Title'] as String?;
                          final timestamp = data['Date'] as String?;

                          final description = data['Description'] as String?;

                          return ListTile(
                            title: Text(title ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(timestamp ?? ''),
                                Text(description ?? ''),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
