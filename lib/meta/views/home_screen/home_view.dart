import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                  color: Vx.randomColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: ['User Name'.text.make().p12()],
                  ),
                  Row(                  
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Vx.randomColor),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              'Total Fund'.text.sm.make().pOnly(right: 10),
                              'Rs 2 00 000'.text.xl.bold.make().pOnly(right: 10),
                            ],
                          ),
                        ),
                      ),
                        Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Vx.randomColor),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              'Monthly P/L'.text.sm.make().pOnly(right: 10),
                              '+2000'.text.xl.bold.make().pOnly(right: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                    Row(                  
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Vx.randomColor),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              'Weekly P/L'.text.sm.make().pOnly(right: 10),
                              '+2000'.text.xl.bold.make().pOnly(right: 10),
                            ],
                          ),
                        ),
                      ),
                        Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Vx.randomColor),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              "Today's P/L".text.sm.make().pOnly(right: 10),
                              '+2000'.text.xl.bold.make().pOnly(right: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
