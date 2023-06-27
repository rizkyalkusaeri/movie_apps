import 'package:flutter/material.dart';
import 'package:movie_apps/components/custom_text.dart';
import 'package:movie_apps/utils/app_colors.dart';
import 'package:movie_apps/utils/size_config.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: SizeConfig.screenHeight! / 2.2,
              floating: false,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://assets-global.website-files.com/6009ec8cda7f305645c9d91b/6408f6e7b5811271dc883aa8_batman-min.png',
                      ),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: const CustomText(
                    text: 'Batman vs Superman',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                _listOfInformationWidget(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: 'Synopsis',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      CustomText(
                        text:
                            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et mauris sagittis, ultricies nunc sed, feugiat urna. Phasellus in luctus nibh. Praesent mattis tellus sit amet est sollicitudin vehicula. Etiam ut arcu tristique, convallis nibh et, gravida sapien. Etiam porta lectus sit amet semper congue. Morbi sit amet rhoncus orci. Proin quam felis, suscipit vitae efficitur viverra, iaculis congue est. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Cras mi turpis, scelerisque ac maximus vel, viverra a libero. Morbi ornare convallis odio non rutrum. Vivamus vulputate molestie quam et sagittis.''',
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _listOfInformationWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _itemOfInformationWidget(
              'Genre', const CustomText(text: 'Drama,Sport')),
          _itemOfInformationWidget(
              'Run Time', const CustomText(text: '1hr 56min')),
          _itemOfInformationWidget(
            'Rating',
            Row(
              children: [
                const CustomText(
                  text: '7.3',
                  fontSize: 14,
                ),
                Icon(
                  Icons.star,
                  color: AppColors.secondary,
                  size: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _itemOfInformationWidget(String title, Widget subtitle) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xff212021),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w700,
            ),
            subtitle
          ],
        ),
      ),
    );
  }
}
