import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/bloc/theme_bloc.dart';
import 'package:interview_junior_flutter/core/utils/get_greeting_by_time_util.dart';
import 'package:interview_junior_flutter/features/dashboard/domain/models/user_info_model.dart';

class UserProfileHeader extends StatelessWidget {
  final UserInfoModel model;

  const UserProfileHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (__, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://ui-avatars.com/api/?name=${model.name ?? 'Duc Vu'}&background=random",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? 'Not found',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18.00,
                    ),
                  ),
                  Text(
                    '${getGreetingByTimeUtil()}, ${model.name ?? 'Not found'}!',
                    style: context.textStyle14.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(500),
              onTap: () async {
                context.read<ThemeBloc>().add(
                  ChangeThemeEvent(isDarkMode: !state.isDarkMode),
                );
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: state.isDarkMode ? Colors.white70 : Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    state.isDarkMode
                        ? 'assets/icons/ic_light_mode.png'
                        : 'assets/icons/ic_dark_mode.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
