import 'package:btcpool_app/app/screens/settings/pages/api/bloc/api_bloc.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_appbar.dart';
import 'package:btcpool_app/app/widgets/appbar/custom_title_appbar.dart';
import 'package:btcpool_app/app/widgets/buttons/custom_button.dart';
import 'package:btcpool_app/data/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().kPrimaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          withArrow: true,
          title: 'API Keys',
        ),
      ),
      body: BlocProvider(
        create: (context) => ApiBloc()..add(ApiLoad()),
        child: BlocBuilder<ApiBloc, ApiState>(
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
                            'API Key',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          Text('Actions',
                              style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: state.data.map<Widget>((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(
                                left: 20, top: 10, bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e,
                                    style: TextStyle(color: Colors.grey[500])),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<ApiBloc>(context)
                                      ..add(ApiDelete(apiKey: e));
                                  },
                                  child: Icon(
                                    Icons.delete_outlined,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Add API Key',
                        function: () {
                          BlocProvider.of<ApiBloc>(context)..add(ApiCreate());
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
