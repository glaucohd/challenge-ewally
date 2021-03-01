import 'package:ewally_app/services/home_service_api.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeServiceApi _homeServiceApi = HomeServiceApi();
  var costPrice;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _initFuture();
    });
    super.initState();
  }

  Future<void> _initFuture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var balance = prefs.getInt('balance');
    var brl = Currency.create('BRL', 2, symbol: 'R\$');
    costPrice = Money.fromInt(balance, brl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        initialData: true,
        future: _homeServiceApi.getBalance(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text('Tente Novamente'),
                  ),
                );
              } else
                return (snapshot.data ?? false)
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Saldo:',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '$costPrice',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Extrato:',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Text('Tente Novamente'),
                      );
          }
        },
      ),
    );
  }
}
