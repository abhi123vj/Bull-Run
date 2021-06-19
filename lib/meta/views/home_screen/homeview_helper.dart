import 'package:bull_run/app/shared/colors.dart';
import 'package:bull_run/meta/model/trades.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeHelper with ChangeNotifier {
  Box<Trades> dataBox = Hive.box<Trades>('data3');
  late List<int> keys;

  final TextEditingController stockNameController = TextEditingController();
  final TextEditingController stockPriceController = TextEditingController();
  final TextEditingController stockQtyController = TextEditingController();

  entryCard(BuildContext context) {
    stockNameController.clear();
    stockPriceController.clear();
    stockQtyController.clear();
    return showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Dialog(
                backgroundColor: Colors.blueGrey[100],
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Stock Name',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              FontAwesomeIcons.building,
                            ),
                          ),
                          controller: stockNameController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          decoration: InputDecoration(
                            labelText: 'Stock Price',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              FontAwesomeIcons.coins,
                            ),
                          ),
                          controller: stockPriceController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              try {
                                final text = newValue.text;
                                if (text.isNotEmpty) double.parse(text);
                                return newValue;
                              } catch (e) {}
                              return oldValue;
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          decoration: InputDecoration(
                            labelText: 'Stock Qty',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              EvaIcons.briefcaseOutline,
                            ),
                          ),
                          controller: stockQtyController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        traderbutton(dataBox, context, "Buy")
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  MaterialButton traderbutton(dataBox, BuildContext context, String text) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: text == "Buy" ? Colors.green : Colors.red,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (stockNameController.text.isNotEmpty &&
            stockPriceController.text.isNotEmpty &&
            stockQtyController.text.isNotEmpty) {
          final String stockNAme = stockNameController.text;
          final double stockPrice = double.parse(stockPriceController.text);
          final int stockQty = int.parse(stockQtyController.text);

          stockNameController.clear();
          stockPriceController.clear();
          stockQtyController.clear();
          addDataToDb(stockNAme, stockPrice, stockQty);
          Navigator.pop(context);
        } else {
          VxToast.show(context, msg: "Fill all Details");
        }
      },
    );
  }

  Future addDataToDb(String stockName, double stockPrice, int stockQty) async {
    var flag = -1;
    for (var i = 0; i < keys.length && flag == -1; i++) {
      if (dataBox.get(keys[i])!.stockName == stockName) {
        stockPrice =
            ((dataBox.get(keys[i])!.stockPrice * dataBox.get(keys[i])!.qty) +
                    (stockQty * stockPrice)) /
                (stockQty + dataBox.get(keys[i])!.qty);
        stockQty = stockQty + dataBox.get(keys[i])!.qty;
        Trades data = Trades(
            stockName: stockName,
            stockPrice: stockPrice,
            valueofstock: stockPrice * stockQty,
            profitandloss: dataBox.get(keys[i])!.profitandloss,
            qty: stockQty,
            day: DateTime.now());
        dataBox.add(data);
        flag = i;
        print("infor");

        break;
      }
    }

    if (flag == -1) {
      print("outloopp");
      Trades data = Trades(
          stockName: stockName,
          stockPrice: stockPrice,
          valueofstock: stockPrice * stockQty,
          profitandloss: 0,
          qty: stockQty,
          day: DateTime.now());
      dataBox.add(data);
    } else {
      dataBox.get(keys[flag])!.delete();
    }
  }

  displaytrades(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8, left: 8),
      child: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, Box<Trades> items, _) {
          keys = items.keys
              .cast<int>()
              .toList()
              .sortedBy((a, b) => b.compareTo(a));
          return ListView.builder(
            itemCount: keys.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final int key = keys[index];
              final Trades? data = items.get(key);

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: darkColor,
                // child: ListTile(
                //   title: Text(
                //     data!.stockName,
                //     style: TextStyle(fontSize: 22, color: Colors.black),
                //   ),
                //   subtitle: Text(data.stockPrice.toString(),
                //       style: TextStyle(fontSize: 20, color: Colors.black38)),
                //   leading: Text(
                //     "$key",
                //     style: TextStyle(fontSize: 18, color: Colors.black),
                //   ),
                // ),
                child: InkWell(
                  onTap: () {
                    modifyTrade(context, index);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: data!.profitandloss > 0
                              ? Colors.green
                              : data.profitandloss == 0
                                  ? textColor
                                  : Colors.red,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('kk:mm:ss').format(data.day),
                                style: TextStyle(color: textColor)),
                            Text(DateFormat('EEE d MMM').format(data.day),
                                style: TextStyle(color: textColor)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.stockName,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹${data.stockPrice}",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " x ",
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${data.qty}",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("₹${data.valueofstock}",
                                style: TextStyle(color: textColor)),
                            Text(
                                data.profitandloss != 0
                                    ? "${data.profitandloss < 0 ? "Losss " : "Profit "}₹${data.profitandloss.abs()}"
                                    : "",
                                style: TextStyle(
                                    color: data.profitandloss < 0
                                        ? Colors.red
                                        : Colors.green)),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  modifyTrade(BuildContext context, int index) {
    stockNameController.text = dataBox.get(keys[index])!.stockName;
    stockQtyController.text = dataBox.get(keys[index])!.qty.toString();
    stockPriceController.text = dataBox.get(keys[index])!.stockPrice.toString();
    return showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Dialog(
                backgroundColor: Colors.blueGrey[100],
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            traderbutton2(index, context, "Delete", textColor),
                            traderbutton2(
                                index, context, "Modify", Colors.blue),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Stock Name',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              FontAwesomeIcons.building,
                            ),
                          ),
                          controller: stockNameController,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          decoration: InputDecoration(
                            labelText: 'Stock Price',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              FontAwesomeIcons.coins,
                            ),
                          ),
                          controller: stockPriceController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              try {
                                final text = newValue.text;
                                if (text.isNotEmpty) double.parse(text);
                                return newValue;
                              } catch (e) {}
                              return oldValue;
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          decoration: InputDecoration(
                            labelText: 'Stock Qty',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              EvaIcons.briefcaseOutline,
                            ),
                          ),
                          controller: stockQtyController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            traderbutton2(index, context, "Buy", Colors.green),
                            traderbutton2(index, context, "Sell", Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  MaterialButton traderbutton2(
      int index, BuildContext context, String text, colors) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: colors,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (text == "Delete") {
            dataBox.deleteAt(index);
            Navigator.pop(context);
        } else if (text == "Modify") {
          if (stockNameController.text.isNotEmpty &&
              stockPriceController.text.isNotEmpty &&
              stockQtyController.text.isNotEmpty) {
            final String stockNAme = stockNameController.text;
            final double stockPrice = double.parse(stockPriceController.text);
            final int stockQty = int.parse(stockQtyController.text);
            Trades data = Trades(
                stockName: stockNAme,
                stockPrice: stockPrice,
                valueofstock: stockPrice * stockQty,
                profitandloss: dataBox.get(keys[index])!.profitandloss,
                qty: stockQty,
                day: DateTime.now());
            dataBox.add(data);
            dataBox.get(keys[index])!.delete();
            stockNameController.clear();
            stockPriceController.clear();
            stockQtyController.clear();
            Navigator.pop(context);
          } else {
            VxToast.show(context, msg: "Fill all Details");
          }
        } else if (text == "Sell") {
          if (stockNameController.text.isNotEmpty &&
              stockPriceController.text.isNotEmpty &&
              stockQtyController.text.isNotEmpty) {
            final String stockNAme = stockNameController.text;
            final double stockPrice = double.parse(stockPriceController.text);
            final int stockQty = int.parse(stockQtyController.text);
            if (stockQty <= dataBox.get(keys[index])!.qty && stockQty != 0) {
              Trades data = Trades(
                  stockName: stockNAme,
                  stockPrice: dataBox.get(keys[index])!.stockPrice,
                  valueofstock: dataBox.get(keys[index])!.stockPrice *
                      (dataBox.get(keys[index])!.qty - stockQty),
                  profitandloss: dataBox.get(keys[index])!.profitandloss +
                      ((stockPrice * stockQty) -
                          (dataBox.get(keys[index])!.stockPrice * stockQty)),
                  qty: dataBox.get(keys[index])!.qty - stockQty,
                  day: DateTime.now());
              dataBox.add(data);
              print("sell ${data.stockPrice} ${data.profitandloss} ");
              dataBox.get(keys[index])!.delete();
              Navigator.pop(context);
            } else {
              VxToast.show(context, msg: "Not enough stock");
            }
          } else {
            VxToast.show(context, msg: "Fill all Details");
          }
        } else if (text == "Buy") {
          if (stockNameController.text.isNotEmpty &&
              stockPriceController.text.isNotEmpty &&
              stockQtyController.text.isNotEmpty) {
            final String stockNAme = stockNameController.text;
            final double stockPrice = double.parse(stockPriceController.text);
            final int stockQty = int.parse(stockQtyController.text);
            if (stockQty > 0) {
              addDataToDb(stockNAme, stockPrice, stockQty);
              Navigator.pop(context);
            } else {
              VxToast.show(context, msg: "Not enough stock");
            }
          }
        }
      },
    );
  }

  // // top of card

  // topcards(BuildContext context) {
  //   return VxSwiper.builder(
  //     itemCount: details.length,
  //     aspectRatio: 16 / 9,
  //     viewportFraction: 0.8,
  //     initialPage: 0,
  //     enableInfiniteScroll: true,
  //     enlargeCenterPage: true,
  //     isFastScrollingEnabled: false,
  //     scrollDirection: Axis.horizontal,
  //     height: MediaQuery.of(context).size.height * .15,
  //     itemBuilder: (context, index) {
  //       // clacualtions();
  //       var _list1 = details.values.toList();
  //       var _list2 = details.keys.toList();

  //       return Material(
  //         borderRadius: BorderRadius.all(Radius.circular(5)),
  //         elevation: 30,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(5)),
  //             border: Border.all(color: Colors.green),
  //             color: yellowColor,
  //           ),
  //           width: double.infinity,
  //           padding: EdgeInsets.all(20),
  //           child: Column(
  //             children: [
  //               Text(_list2[index]),
  //               Text("${_list1[index]}"),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // double moneyInStock = 0;
  // var stockAndQty = {};
  // var stockAndPrice = {};
  // var stockAndProfit = {};
  // var details = {};
  // clacualtions() async {
  //   stockAndQty.clear();
  //   stockAndPrice.clear();
  //   stockAndProfit.clear();
  //   moneyInStock = 0;
  //   for (var i = 0; i < keys.length; i++) {
  //     if (dataBox.get(keys[i])!.type == "Buy")
  //       moneyInStock = moneyInStock +
  //           (dataBox.get(keys[i])!.stockPrice * dataBox.get(keys[i])!.qty);

  //     print("object, ${dataBox.get(keys[i])!.type}");
  //   }
  //   for (var i = 0; i < keys.length; i++) {
  //     var name = dataBox.get(keys[i])!.stockName;
  //     var qty = dataBox.get(keys[i])!.qty;
  //     var price = dataBox.get(keys[i])!.stockPrice;
  //     if (dataBox.get(keys[i])!.type == "Buy") {
  //       stockAndQty.update(name, (dynamic val) => val + qty,
  //           ifAbsent: () => qty);
  //       stockAndPrice.update(
  //           name,
  //           (dynamic value) => ((value * stockAndQty[name]) +
  //               (price * qty) / (stockAndQty[name]) +
  //               qty),
  //           ifAbsent: () => price);
  //     } else {}
  //   }
  //   details['Money in Stock'] = moneyInStock;
  //   print(details);
  // }
  var infos = {};
  Widget topContainers(BuildContext context) {
    readdata();
    return VxSwiper.builder(
      itemCount: infos.length,
      enlargeCenterPage: true,
      height: MediaQuery.of(context).size.height * .15,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 2, right: 2),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${infos.entries.elementAt(index).key}",
                style: TextStyle(color: textColor),
              ),
              Text(
                "${infos.entries.elementAt(index).value}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }

  readdata() {
    
    infos.clear();
    print(dataBox.length);
    double totalProfit = 0;
    int beststock = 0;
    int worststock = 0;

    for (int i = 0; i < dataBox.length; i++) {
      print("inside loop");
      print(dataBox.getAt(i)!.profitandloss);
      totalProfit = dataBox.getAt(i)!.profitandloss + totalProfit;
      if (dataBox.getAt(i)!.profitandloss >
          dataBox.getAt(beststock)!.profitandloss) beststock = i;
      if (dataBox.getAt(i)!.profitandloss <
          dataBox.getAt(worststock)!.profitandloss) worststock = i;
    }
    try {
      if (totalProfit >= 0)
        infos['Your Net Profit'] = "₹$totalProfit";
      else
        infos['Your Net Loss'] = "₹${totalProfit.abs()}";
      if (dataBox.getAt(beststock)!.profitandloss >= 0)
        infos['${dataBox.getAt(beststock)!.stockName} has given you Max Profit '] =
            "₹${dataBox.getAt(beststock)!.profitandloss}";
      else
        infos['${dataBox.getAt(beststock)!.stockName} has given you Min Loss '] =
            "₹${dataBox.getAt(beststock)!.profitandloss.abs()}";
      if (dataBox.getAt(worststock)!.profitandloss >= 0)
        infos['${dataBox.getAt(worststock)!.stockName} has given you Min Profit '] =
            "₹${dataBox.getAt(worststock)!.profitandloss}";
      else
        infos['${dataBox.getAt(worststock)!.stockName} has given you Max Loss '] =
            "₹${dataBox.getAt(worststock)!.profitandloss.abs()}";
    } catch (e) {
      if (infos.length == 0) {
        print("erre $e");
        infos['Start Buying Stocks'] = "";
      }
    }
    print(infos);
  }
}
