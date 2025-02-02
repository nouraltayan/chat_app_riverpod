import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subabasefirstlctsher/model/modelchat.dart';
import 'package:subabasefirstlctsher/provider/servis.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Consumer(
          builder: (context, ref, _) {
            return ref.watch(chatStreamProviderget).when(
              data: (chatModels) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: chatModels.length,
                            itemBuilder: (context, index) {
                              return chatModels[index].is_me
                                  ? SizedBox(
                                      width: 100,
                                      height: 60,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            width: 300,
                                            height: 100,
                                            child: Center(
                                              child: Text(
                                                  chatModels[index].message),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 100,
                                      height: 60,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            width: 300,
                                            height: 100,
                                            child: Center(
                                              child: Text(
                                                  chatModels[index].message),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextField(
                                  controller: message,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final masseg = ref.watch(mssgServiceProvider);
                                await masseg.insertmasseg(chatmodel(
                                    id: 0,
                                    created_at: '',
                                    message: message.text,
                                    is_me: false));
                                message.clear();
                              },
                              icon: Icon(Icons.send),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text("Error: $error"));
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
