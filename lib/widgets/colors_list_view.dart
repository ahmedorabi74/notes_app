import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesss_app/cubits/add_note_cubit/add_note_cubit.dart';


import '../constans.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isChoose, required this.color});

  final bool isChoose;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return isChoose
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: 36,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: color,
            ),
          )
        : CircleAvatar(
            radius: 32,
            backgroundColor: color,
          );
  }
}

class ColorListView extends StatefulWidget {
  const ColorListView({super.key});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38 * 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kColors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  currentIndex = index;
                  BlocProvider.of<AddNoteCubit>(context).color = kColors[index];
                  setState(() {});
                },
                child: ColorItem(
                  color: kColors[index],
                  isChoose: currentIndex == index ? true : false,
                ),
              ),
            );
          }),
    );
  }
}
