import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../presentation/screens_main/mainscreen.dart';
import '../presentation/custom/clip_path_bg.dart';

class hotline extends StatefulWidget {
  const hotline({Key? key});

  @override
  State<hotline> createState() => _hotline();
}

class _hotline extends State<hotline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ),
        body: Stack(
          children: [
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomHomeContainer(height: 600),
            ),
            const ClipPathBackground(height: 600),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 600,
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width > 500
                      ? 400
                      : double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Emergency Hotline'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('hotline')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return const Text('Loading...');
                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!.docs.map((document) {
                                  return Row(
                                    children: [
                                      Image.network(
                                        document['photoUrl'],
                                        height: 150,
                                        width: 150,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        document['title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Text(
                                        document['number'],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
