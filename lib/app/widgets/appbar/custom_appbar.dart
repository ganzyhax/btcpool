import 'package:btcpool_app/app/bloc/theme_bloc.dart';
import 'package:btcpool_app/app/widgets/subaccount_card.dart';
import 'package:btcpool_app/controller/home_widget_controller.dart';
import 'package:btcpool_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? withSubAccount;
  final bool? withArrow;

  final Function()? onTapBack;
  const CustomAppBar(
      {super.key,
      this.title,
      this.onTapBack,
      this.withSubAccount = true,
      this.withArrow = false});

  @override
  Widget build(BuildContext context) {
    var isDark;
    final state = BlocProvider.of<ThemeBloc>(context).state;
    if (state is ThemeLoaded) {
      isDark = state.isDark;
    }
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: (onTapBack == null)
          ? (withArrow == true)
              ? true
              : false
          : false,
      leading: (onTapBack != null)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: onTapBack,
            )
          : null,
      title: (title == null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: (Theme.of(context).brightness == Brightness.dark)
                        ? Image.asset('assets/images/btcpool_logo.png')
                        : Image.asset('assets/images/btcpool_logo.png')),
                SubAccountCard()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ).tr(),
                (withSubAccount == true)
                    ? SubAccountCard()
                    : Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          (title!.tr() == LocaleKeys.settings.tr())
                              ? (isDark)
                                  ? SizedBox(
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<ThemeBloc>(context)
                                              ..add(ThemeChange(value: false));
                                            HomeWidgetController()
                                                .updateThemeMode(true);
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/sun.svg')),
                                    )
                                  : SizedBox(
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<ThemeBloc>(context)
                                              ..add(ThemeChange(value: true));
                                            HomeWidgetController()
                                                .updateThemeMode(false);
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/moon.svg')),
                                    )
                              : SizedBox()
                        ],
                      ),
              ],
            ),
    );
  }
}
