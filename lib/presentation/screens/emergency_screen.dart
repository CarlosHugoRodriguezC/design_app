import 'package:animate_do/animate_do.dart';
import 'package:design_app/presentation/widgets/icon_header.dart';
import 'package:design_app/presentation/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final items = <_CardOption>[
  const _CardOption(FontAwesomeIcons.carBurst, 'Motor Accident',
      Color(0xff6989F5), Color(0xff906EF5)),
  const _CardOption(FontAwesomeIcons.plus, 'Medical Emergency',
      Color(0xff66A9F2), Color(0xff536CF6)),
  const _CardOption(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      Color(0xffF2D572), Color(0xffE06AA3)),
  const _CardOption(FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183),
      Color(0xff46997D)),
  const _CardOption(FontAwesomeIcons.carBurst, 'Motor Accident',
      Color(0xff6989F5), Color(0xff906EF5)),
  const _CardOption(FontAwesomeIcons.plus, 'Medical Emergency',
      Color(0xff66A9F2), Color(0xff536CF6)),
  const _CardOption(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      Color(0xffF2D572), Color(0xffE06AA3)),
  const _CardOption(FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183),
      Color(0xff46997D)),
  const _CardOption(FontAwesomeIcons.carBurst, 'Motor Accident',
      Color(0xff6989F5), Color(0xff906EF5)),
  const _CardOption(FontAwesomeIcons.plus, 'Medical Emergency',
      Color(0xff66A9F2), Color(0xff536CF6)),
  const _CardOption(FontAwesomeIcons.masksTheater, 'Theft / Harrasement',
      Color(0xffF2D572), Color(0xffE06AA3)),
  const _CardOption(FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183),
      Color(0xff46997D)),
];

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 200),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 80,
              ),
              ...items,
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
        const _Header(),
      ]),
    );
  }
}

class _CardOption extends StatelessWidget {
  const _CardOption(this.icon, this.text, this.color1, this.color2);

  final IconData icon;
  final String text;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: OptionCard(
        icon: icon,
        text: text,
        color1: color1,
        color2: color2,
        onPressed: () {},
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IconHeader(
          icon: FontAwesomeIcons.plus,
          subtitle: 'You have requested',
          title: 'Medical Assistance',
        ),
        Positioned(
          right: 0,
          top: 40,
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.white,
            ),
            onPressed: () {},
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
