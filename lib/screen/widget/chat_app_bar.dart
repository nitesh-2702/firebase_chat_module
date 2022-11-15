import 'package:firebase_chat_module/models/receiver_data.dart';
import 'package:firebase_chat_module/repositories/chat_repo.dart';
import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:firebase_chat_module/utils/sizeconfig.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  String name;
  ChatRepository chatRepository;
  String callerId;
  ReceiverData receiverData;
  String receiverId;
  String profileType;

  ChatAppBar(
      {Key? key,
      required this.name,
      required this.chatRepository,
      required this.callerId,
      required this.receiverId,
      required this.profileType,
      required this.receiverData})

      // })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5),
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(26.0),
            bottomRight: Radius.circular(26.0)),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24), // Image radius
                child: (receiverData.brandProfilePic != null)
                    ? SizedBox(
                        height: 48,
                        width: 48,
                        child: Image.network(receiverData.brandProfilePic!,
                            fit: BoxFit.cover),
                      )
                    : const Icon(
                        Icons.account_circle_sharp,
                        color: Colors.grey,
                        size: 48,
                      ),
              ),
            ),
            SizedBox(
              width: 12
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  receiverData.brandName ?? " ",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey26),
                ),
              ],
            ),
            const Spacer(),
            if (profileType != 'INFLUENCER')
              Row(
                children: [
                  SizedBox(
                    width:27,
                  ),
                  const SizedBox(child: Icon(Icons.more)),
                ],
              ),
            SizedBox(
              width: 22,
            ),
          ],
        ),
      ),
    );
    // return AppBar(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       bottom: Radius.circular(30),
    //     ),
    //   ),
    //   elevation: 2,
    //   titleSpacing: -8,
    //   backgroundColor: AppColors.whiteFF,
    //   leading: IconButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     icon: SvgPicture.asset(
    //       ImagePath.backIcon,
    //       height: 24 * SizeConfig.heightMultiplier,
    //       width: 24 * SizeConfig.widthMultiplier,
    //     ),
    //   ),
    //   title: Row(
    //     children: [
    //       ClipOval(
    //         child: SizedBox.fromSize(
    //           size: Size.fromRadius(24), // Image radius
    //           child: (receiverData.brandProfilePic != null)
    //               ? Image.network(receiverData.brandProfilePic!,
    //                   fit: BoxFit.cover)
    //               : Icon(
    //                   Icons.account_circle_sharp,
    //                   color: Colors.grey,
    //                   size: 48,
    //                 ),
    //         ),
    //       ),
    //       SizedBox(
    //         width: 12 * SizeConfig.widthMultiplier,
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             receiverData.brandName ?? " ",
    //             style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w600,
    //                 color: AppColors.grey26),
    //           ),
    //         ],
    //       ),
    //       const Spacer(),
    //       if (profileType != 'INFLUENCER')
    //         Row(
    //           children: [
    //             InkWell(
    //               onTap: () async {
    //                 _videoCallModel = await chatRepository.getVideoCallToken(
    //                     callerId, name, receiverId, "audio");
    //                 Navigator.of(context).pushNamed(RouteName.audioCallScreen,
    //                     arguments: _videoCallModel);
    //               },
    //               child: SizedBox(
    //                 child: SvgPicture.asset(
    //                   ImagePath.callIcon,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 27 * SizeConfig.widthMultiplier,
    //             ),
    //             InkWell(
    //               onTap: () async {
    //                 _videoCallModel = await chatRepository.getVideoCallToken(
    //                     callerId, name, receiverId, "video");
    //                 Navigator.of(context).pushNamed(RouteName.videoCallScreen,
    //                     arguments: _videoCallModel);
    //               },
    //               child: SizedBox(
    //                 child: SvgPicture.asset(
    //                   ImagePath.videoIcon,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 27 * SizeConfig.widthMultiplier,
    //             ),
    //             SizedBox(
    //                 child: SvgPicture.asset(
    //               ImagePath.moreHorizontalIcon,
    //             )),
    //           ],
    //         ),
    //       SizedBox(
    //         width: 22 * SizeConfig.widthMultiplier,
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
