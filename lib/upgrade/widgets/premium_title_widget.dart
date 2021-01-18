import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';

class PremiumTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpgradeCubit, UpgradeState>(
      builder: (context, state) {
        if (state.status == UpgradeStatus.pickedOneMonth) {
          return Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: Text(
              '69.105 đồng mỗi tháng',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }
        if (state.status == UpgradeStatus.pickedThreeMonths) {
          return Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: Text(
              'Tiết kiệm 23.000 đồng/tháng',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }
        if (state.status == UpgradeStatus.pickedOneYear) {
          return Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: Text(
              'Hết năm đầu tính 460.000 đồng/năm',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
          child: Text(
            'Siêu tiết kiệm với gói 1 năm',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
