import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject_app/shared/ticket_detail.dart';
import 'package:myproject_app/shared/ticket_widget.dart';
import 'package:myproject_app/models/list_ticket.dart';

class TicketsOverviewScreen extends StatelessWidget {
  const TicketsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Trang chủ',
          style: TextStyle(fontSize: s * 0.05),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Text(
              'Vé đi Sài Gòn',
              style: TextStyle(
                  fontSize: s * 0.06,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: s * 0.45,
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
                  child: Center(
                    child: TicketWidget(
                      ticket: ListTicket.veDiHCM[0],
                    ),
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
                  child: Center(
                      child: TicketWidget(ticket: ListTicket.veDiHCM[1])),
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
                  child: Center(
                    child: TicketWidget(
                      ticket: ListTicket.veDiHCM[2],
                    ),
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
                  child: Center(
                    child: TicketWidget(
                      ticket: ListTicket.veDiHCM[3],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              'Vé đi tỉnh khác',
              style: TextStyle(
                  fontSize: s * 0.06,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
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
                child: Center(
                  child: TicketWidget(
                    ticket: ListTicket.veDiTinhKhac[0],
                  ),
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
                child: Center(
                  child: TicketWidget(
                    ticket: ListTicket.veDiTinhKhac[1],
                  ),
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
                child: Center(
                  child: TicketWidget(
                    ticket: ListTicket.veDiTinhKhac[2],
                  ),
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
                child: Center(
                  child: TicketWidget(
                    ticket: ListTicket.veDiTinhKhac[3],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
