import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/meta/model/trades.dart';
import 'package:bull_run/meta/views/home_screen/home_header_helper.dart';
import 'package:bull_run/meta/views/home_screen/homeview_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

const String dataBoxName = "data3";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum DataFilter { ALL, COMPLETED, PROGRESS }

class _MyHomePageState extends State<MyHomePage> {
  double proftandloss = 0.0;
  late Box<Trades> dataBox;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DataFilter filter = DataFilter.ALL;

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<Trades>(dataBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: bgColorFaint,
        label: const Text('Buy'),
        icon: const Icon(
          FontAwesomeIcons.paperPlane,
          color: Colors.green,
        ),
        onPressed: () {
          Provider.of<HomeHelper>(context, listen: false).entryCard(context);
        },
      ),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: double.infinity,
        decoration: BoxDecoration(color: bgColor),
        child: Column(
          children: [
            // Provider.of<HomeHelper>(context, listen: false)
            //          .topcards(context),
            Provider.of<HomeHelper>(context, listen: false)
                .topContainers(context),
            Expanded(
                child: Provider.of<HomeHelper>(context, listen: true)
                    .displaytrades(context))
          ],
        ),
      ),
    );
  }
}
