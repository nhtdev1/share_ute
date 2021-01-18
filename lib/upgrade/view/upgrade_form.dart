import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';
import 'package:share_ute/utilities/utilities.dart';

class UpgradeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF021B3A),
      appBar: AppBar(
        backgroundColor: Color(0XFF021B3A),
        elevation: 0.0,
      ),
      body: BlocConsumer<UpgradeCubit, UpgradeState>(
        listener: (context, state) {
          if (state.upgradeProgress == UpgradeProgress.upgradeSuccess) {
            AppUtilities.showSnackBar(
              context: context,
              title: 'Nâng cấp thành công',
            );
          }

          if (state.upgradeProgress == UpgradeProgress.upgradeFailure) {
            AppUtilities.showSnackBar(
              context: context,
              title: 'Thanh toán thất bại vui lòng thử lại',
            );
          }
        },
        builder: (context, state) {
          return state.user.premium != 'false'
              ? PremiumActiveWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PremiumCoverWidget(),
                    PremiumBodyWidget(),
                  ],
                );
        },
      ),
    );
  }
}
