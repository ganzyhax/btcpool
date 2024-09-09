import 'package:btcpool_app/app/views/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/components/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/components/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/components/buttons/custom_button.dart';
import 'package:btcpool_app/app/components/custom_indicator.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          withArrow: true,
          title: LocaleKeys.api_keys.tr(),
        ),
      ),
      body: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          if (state is ApiLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.api_keys.tr(),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        Text(LocaleKeys.actions.tr(),
                            style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                        children: state.data.map<Widget>((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e,
                                  style: TextStyle(color: Colors.grey[500])),
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<ApiBloc>(context)
                                      .add(ApiDelete(apiKey: e));
                                },
                                child: const Icon(
                                  Icons.delete_outlined,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: LocaleKeys.add_api_key.tr(),
                      isLoading: state.isLoading,
                      function: () {
                        BlocProvider.of<ApiBloc>(context).add(ApiCreate());
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CustomIndicator(),
          );
        },
      ),
    );
  }
}
