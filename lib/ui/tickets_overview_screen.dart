import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject_app/shared/ticket_detail.dart';
import 'package:myproject_app/shared/ticket_widget.dart';
import 'package:myproject_app/models/list_ticket.dart';

class TicketsOverviewScreen extends StatelessWidget {
  const TicketsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Vé xe hôm nay',
          style: TextStyle(fontSize: 25),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              'Vé đi Sài Gòn',
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(
            height: 174,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketDetailScreen(
                                  ticket: ListTicket.veDiHCM[0],
                                )));
                  },
                  child: TicketWidget(
                    ticket: ListTicket.veDiHCM[0],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketDetailScreen(
                                  ticket: ListTicket.veDiHCM[1],
                                )));
                  },
                  child: TicketWidget(ticket: ListTicket.veDiHCM[1]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketDetailScreen(
                                  ticket: ListTicket.veDiHCM[2],
                                )));
                  },
                  child: TicketWidget(
                    ticket: ListTicket.veDiHCM[2],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketDetailScreen(
                                  ticket: ListTicket.veDiHCM[3],
                                )));
                  },
                  child: TicketWidget(
                    ticket: ListTicket.veDiHCM[3],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              'Vé đi tỉnh khác',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailScreen(
                                ticket: ListTicket.veDiTinhKhac[0],
                              )));
                },
                child: TicketWidget(
                  ticket: ListTicket.veDiTinhKhac[0],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailScreen(
                                ticket: ListTicket.veDiTinhKhac[1],
                              )));
                },
                child: TicketWidget(
                  ticket: ListTicket.veDiTinhKhac[1],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailScreen(
                                ticket: ListTicket.veDiTinhKhac[2],
                              )));
                },
                child: TicketWidget(
                  ticket: ListTicket.veDiTinhKhac[2],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailScreen(
                                ticket: ListTicket.veDiTinhKhac[3],
                              )));
                },
                child: TicketWidget(
                  ticket: ListTicket.veDiTinhKhac[3],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
