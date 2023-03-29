// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OrderTicketButton extends StatefulWidget {
  final double giaVe;
  final int soGheConLai;
  const OrderTicketButton({
    Key? key,
    required this.giaVe,
    required this.soGheConLai,
  }) : super(key: key);

  @override
  State<OrderTicketButton> createState() => _OrderTicketButtonState();
}

class _OrderTicketButtonState extends State<OrderTicketButton> {
  int slVe = 0;
  double tong = 0.0;
  double t = 0.0;

  @override
  void initState() {
    super.initState();
    t = widget.giaVe;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: Colors.teal,
            width: 2,
          )),
      child: TextButton.icon(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                              width: 60,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 5,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Số ghế:',
                                  style: TextStyle(fontSize: 25),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  // child: ticketsQuantity(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (slVe > 0) {
                                                setState(() {
                                                  slVe--;
                                                  tong -= t;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.remove)),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              '$slVe vé',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (slVe < widget.soGheConLai) {
                                                setState(() {
                                                  slVe++;
                                                  tong += t;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.add)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tổng cộng:',
                                  style: TextStyle(fontSize: 25),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  '$tong VND',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(child: cancelButton()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: orderButton()),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          icon: const Icon(
            Icons.confirmation_num_outlined,
            size: 29,
            color: Colors.teal,
          ),
          label: const Text(
            'Đặt vé',
            style: TextStyle(color: Colors.teal, fontSize: 25),
          )),
    );
  }

  Widget ticketsQuantity() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.teal,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    if (slVe > 0) {
                      setState(() {
                        slVe--;
                        tong -= t;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove)),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    '$slVe vé',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              IconButton(
                  onPressed: () {
                    if (slVe < widget.soGheConLai) {
                      setState(() {
                        slVe++;
                        tong += t;
                      });
                    }
                  },
                  icon: const Icon(Icons.add)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget cancelButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Hủy',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget orderButton() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Đặt vé',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
