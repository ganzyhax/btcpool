import 'package:btcpool_app/app/components/custom_snackbar.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardUrlCard extends StatelessWidget {
  final data;
  final String workerName;

  const DashboardUrlCard(
      {super.key, required this.data, required this.workerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.map<Widget>((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(e['description'],
                      style: TextStyle(
                          color: AppColors().kPrimaryGrey, fontSize: 13)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            border:
                                Border.all(color: AppColors().kPrimaryGrey)),
                        child: Text(e['url']),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: e['url']));
                          CustomSnackbar()
                              .showCustomSnackbar(context, 'Скопирован!', true);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: AppColors().kPrimaryGreen)),
                          child: Center(
                            child: Icon(
                              Icons.copy,
                              color: AppColors().kPrimaryGreen,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text('Воркер',
                  style:
                      TextStyle(color: AppColors().kPrimaryGrey, fontSize: 13)),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        border: Border.all(color: AppColors().kPrimaryGrey)),
                    child: Text(workerName + '.001'),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: workerName));
                      CustomSnackbar()
                          .showCustomSnackbar(context, 'Copied!', true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors().kPrimaryGreen)),
                      child: Center(
                        child: Icon(
                          Icons.copy,
                          color: AppColors().kPrimaryGreen,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text('Пароль',
                  style:
                      TextStyle(color: AppColors().kPrimaryGrey, fontSize: 13)),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        border: Border.all(color: AppColors().kPrimaryGrey)),
                    child: Text('123'),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: '123'));
                      CustomSnackbar()
                          .showCustomSnackbar(context, 'Copied!', true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors().kPrimaryGreen)),
                      child: Center(
                        child: Icon(
                          Icons.copy,
                          color: AppColors().kPrimaryGreen,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
