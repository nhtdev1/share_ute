import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';

class PremiumPaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpgradeCubit, UpgradeState>(
      builder: (context, state) {
        return GestureDetector(
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 4 / 6,
              decoration: BoxDecoration(
                color: state.status == UpgradeStatus.unknown
                    ? Colors.white.withOpacity(0.3)
                    : Colors.yellow,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    width: 10.0,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Thanh toán ngay',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: state.status == UpgradeStatus.unknown
                        ? Colors.white
                        : null,
                  ),
                ),
              ),
            ),
          ),
          onTap: state.status == UpgradeStatus.unknown
              ? null
              : () async {
                  final sessionId =
                      await context.read<UpgradeCubit>().checkout();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StripeCheckoutPage(
                        sessionId: sessionId,
                        activePremium: () {
                          context.read<UpgradeCubit>().upgradePremium();
                        },
                      ),
                    ),
                  );
                },
        );
      },
    );
  }
}
