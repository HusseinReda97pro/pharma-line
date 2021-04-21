import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/history_card.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  static String route = '/wallet';
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (BuildContext context, MainModel model, Widget child) {
        return Scaffold(
          appBar: MainAppBar(
            context: context,
          ),
          drawer: AppDrawer(),
          body: ListView.builder(
              itemCount: model.history.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        child: Row(
                          children: [
                            Text(
                              'Wallet',
                              style: TextStyle(
                                  color: Palette.lightBlue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Text(
                              'Balance: 25\$',
                              style: TextStyle(
                                  color: Palette.lightBlue, fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical: 10.0),
                        child: Text(
                          'history:',
                          style: TextStyle(
                              color: Palette.lightBlue, fontSize: 14.0),
                        ),
                      )
                    ],
                  );
                }
                return HistoryCard(
                  history: model.history[index - 1],
                );
              }),
        );
      },
    );
  }
}
