import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:random_job/screens/accounting/components/components.dart';
import 'package:random_job/services/services.dart';

class AccountingCreateComponent extends StatelessWidget {
  const AccountingCreateComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = WidthProvider.setWidthAndHeight(context)["width"]!;
    final height = WidthProvider.setWidthAndHeight(context)["height"]!;
    return BlocBuilder<AccountingBloc, AccountingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              //header
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  left: 16.0,
                ),
                child: Center(
                  child: AccountingCreateHeaderComponent(
                    width: width,
                    height: height,
                    incoming: state.incoming,
                    expense: state.expense,
                  ),
                ),
              ),
              const Gap(20),

              // chart
              Stack(
                fit: StackFit.passthrough,
                children: [
                  const AccountingShowChart(),
                  Positioned(
                    bottom: 0,
                    left: 16,
                    child: CupertinoSwitch(
                      value: state.showBarChart,
                      onChanged: (_) {
                        context
                            .read<AccountingBloc>()
                            .add(ToggleBarOrPieEvent());
                      },
                    ),
                  ),
                ],
              ),
              const Gap(20),

              //catefory detail and sum
              SizedBox(
                // color: Colors.blueGrey,
                height: 160,
                // width: width,
                child: AccountingCreateCardComponent(
                  chartDataPie: state.chartDataPie,
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}
