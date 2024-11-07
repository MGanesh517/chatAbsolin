import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonChatCard extends StatelessWidget {
  final String image;
  final String chatSeenStatus;
  final String title;
  final String subTitle;
  final String time;
  final String? msgCount; // msgCount is nullable
  final Color backGroundColor;

  final VoidCallback? btnLink;

  const CommonChatCard({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.time,
    this.btnLink,
    required this.chatSeenStatus,
    this.msgCount,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandTapWidget(
      tapPadding: EdgeInsets.all(16),
      onTap: btnLink!,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: backGroundColor.withOpacity(0.1),
              radius: 25,
              child: Text(
                title.characters.isNotEmpty ? title.characters.first.toUpperCase() : 'N/A',
                style: TextStyle(
                  color: backGroundColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      if (chatSeenStatus.isNotEmpty)
                        Row(
                          children: [
                            SvgPicture.asset(chatSeenStatus),
                            SizedBox(width: 5),
                          ],
                        ),
                      Expanded(
                        child: Text(
                          subTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.shadow,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 5),
                if (msgCount != null && msgCount != '0') // Null and '0' check
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Center(
                      child: Text(
                        msgCount!,
                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
