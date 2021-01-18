import 'package:flutter/material.dart';

class PremiumLabelWidget extends StatelessWidget {
  PremiumLabelWidget(this.expiredDate);

  final String expiredDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Bạn đã là thành viên Premium',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'Thông tin chi tiết gói',
          style: TextStyle(fontSize: 18.0),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gói:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                '1 tháng',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ngày hết hạn:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                '$expiredDate',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
