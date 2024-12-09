import 'dart:math';

import 'package:cek_khodam/models/data_khodam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';

class CekKhodam extends StatefulWidget {
  const CekKhodam({super.key});

  @override
  State<CekKhodam> createState() => _CekKhodamState();
}

class _CekKhodamState extends State<CekKhodam> with TickerProviderStateMixin {
  TextEditingController _textController = TextEditingController();
  late GifController _gifController;
  String _resultKhodam = '';
  final _random = Random();

  void _cekKhodam() {
    _resultKhodam = _textController.text;
    setState(() {
      _resultKhodam = khodam[_random.nextInt(khodam.length)];
    });
  }

  @override
  void initState() {
    _gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFA0A0A0),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                "Follow TikTok @ezdevs",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gif(
                      controller: _gifController,
                      duration: const Duration(seconds: 20),
                      autostart: Autostart.once,
                      placeholder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      image: const NetworkImage(
                          'https://pic.funnygifsbox.com/uploads/2020/01/funnygifsbox.com-2020-01-29-08-08-16-62.gif'),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Nama',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        fillColor: Color(0xFFFFFFFF).withOpacity(.70),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _textController,
                            builder: (context, value, child) {
                              return Container(
                                  margin: EdgeInsets.all(12),
                                  child: ElevatedButton(
                                      onPressed: _textController.text.isEmpty
                                          ? null
                                          : _cekKhodam,
                                      style: _textController.text.isEmpty
                                          ? ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  Color(0xFFEDEEF1),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            )
                                          : ButtonStyle(
                                              overlayColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return Color(0xFFE75527);
                                                  }
                                                  return null;
                                                },
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  return Color(0xFFF26322);
                                                },
                                              ),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)))),
                                      child: Text("Cek Hasil",
                                          style: TextStyle(
                                              letterSpacing: 1.5,
                                              fontSize: 16,
                                              color: Color(0xFFFFFFFF)))));
                            }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _resultKhodam.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
