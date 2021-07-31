import 'package:bull_run/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _loginCotroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var _nameVisble = false.obs;
    return Material(
      child: SafeArea(
          child: Obx(
        () => _loginCotroller.googleAccount.value == null
            ? Container(
                child: Center(
                  child: ElevatedButton(
                      child: Text("Google"),
                      onPressed: () => _loginCotroller.login()),
                ),
              )
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            GestureDetector(
                              onTap: (){
                                _nameVisble.value=!_nameVisble.value;
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(_loginCotroller
                                    .googleAccount.value!.photoUrl
                                    .toString()),
                              ),
                            ),
                            Obx(()=>Visibility(
                              visible: _nameVisble.value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(_loginCotroller.googleAccount.value!.displayName.toString()),
                              ),
                            ))
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text("logout"),
                        onPressed: () => _loginCotroller.logout(),
                      )
                    ],
                  ),
                ),
              ),
      )),
    );
  }
}
