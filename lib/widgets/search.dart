import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readai/common/colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'по названиям, авторам, содержимому книг',

                prefixIcon: Container(
                  padding: EdgeInsets.all(10),
                  width: 28,
                  height: 28,
                  // alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                    width: 28,
                    height: 28,
                  ),
                ),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/star.svg",
                    color: AppColors.white,
                  ),
                ),
                // isDense: true,
                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),

                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: AppColors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: AppColors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: AppColors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  // borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),

          // const SizedBox(width: 12),
        ],
      ),
    );
  }
}
