/*
Use box.get() to read data is passed
box.put() to save  data is passed/ saved key-value in Box
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:new_fresher_training/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController tax = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  String? taxError;
  String? nameError;
  String? passWordError;
  static bool isObsured = true;
  void handleClick() async {
    final Box box = Hive.box('loginBox');
    await box.put('tax', tax.text);
    await box.put('userName', userName.text);
    await box.put('passWord', passWord.text);
    await box.put('isLogin', true);
    setState(() {
      // can't use async

      taxError = null;
      nameError = null;
      passWordError = null;

      if (tax.text.trim().length != 10) {
        taxError = "Cần đủ 10 ký tự";
      }
      if (userName.text.isEmpty) {
        nameError = "Tên đăng nhập không được để trống";
      }
      if (passWord.text.length < 8 ||
          passWord.text.length > 50 ||
          passWord.text.isEmpty) {
        passWordError = "Mật khẩu phải từ 8 đến 50 ký tự";
      }
      if (taxError != null && nameError != null && passWordError != null) {}
      if (tax.text == "1111111111" &&
          userName.text == "demo" &&
          passWord.text == "12345678") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Thong bao"),
              content: Text("Khong hop le"),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final box = Hive.box('loginBox');
    tax.text = box.get('tax', defaultValue: '');
    userName.text = box.get('userName', defaultValue: '');
    passWord.text = box.get('passWord', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        body: LayoutBuilder(
          builder: (context,c) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: c.maxHeight),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Container(
                        height: 100,
                        width: 200,
                        child: SvgPicture.asset("assets/iconLogin.svg"),
                      ),
                      Text("Mã số Thuế", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: tax,
                        decoration: InputDecoration(
                          label: Text("Mã số thuế"),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      if (taxError != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            taxError!,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      SizedBox(height: 30),
                      Text("Tài khoản",style: TextStyle(fontWeight: FontWeight.bold),),
                      TextFormField(
                        controller: userName,
                        decoration: InputDecoration(
                          label: Text(
                            "Tài khoản",
                            
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      if (nameError != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            nameError!,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      SizedBox(height: 30),
                      Text("Mật khẩu",style: TextStyle(fontWeight: FontWeight.bold),),
                      TextFormField(
                        obscureText: isObsured,
                        obscuringCharacter: "*",
                        
                        controller: passWord,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isObsured = !isObsured;
                              });
                            },
                            icon: Icon(isObsured ? Icons.visibility_off : Icons.visibility)),
                          label: Text(
                            "Mật khẩu",
                            
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFF24E1E), width: 1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      if (passWordError != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            passWordError!,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      SizedBox(height: 50),
                      
                      Container(
                        height: 50,
                        color: Color(0xFFF24E1E),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF24E1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          onPressed: handleClick,
                          child: Center(
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 150,),
                      
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset("assets/headphone.svg"),
                                  ),
                      
                                  Text("Tro giup"),
                                ],
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset("assets/Social link.svg"),
                                  ),
                      
                                  Text("Group"),
                                ],
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              height: 50,
                              width: 100,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset("assets/search-normal.svg"),
                                  ),
                      
                                  Text("Tra cuu"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      
    );
  }
}
