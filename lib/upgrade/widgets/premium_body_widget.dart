import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';

class PremiumBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bias = MediaQuery.of(context).size.width / 4;
    return BlocBuilder<UpgradeCubit, UpgradeState>(
      builder: (context, state) {
        if (state.upgradeProgress == UpgradeProgress.upgradeInProgress) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Describe premium package
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Nâng cấp lên gói premium',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: bias),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Tải lên file lên đến 1GB',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: bias),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Tải xuống file tốc độ cao',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: bias),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Xem file chế độ offline',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: bias),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Lưu trữ file tiện lợi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),

                //
                PremiumOneMonth(),
                PremiumThreeMonths(),
                PremiumOneYear(),
                PremiumTitleWidget(),
                PremiumPaymentButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
