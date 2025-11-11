import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jihc_landf/src/core/enums/filter.dart';
import 'package:jihc_landf/src/core/enums/page_switch.dart';

class ThreePickerSandF extends StatefulWidget {
  const ThreePickerSandF({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  final PageSwitch selectedFilter;
  final ValueChanged<PageSwitch> onChanged;

  @override
  State<ThreePickerSandF> createState() => _ThreePickerSandFState();
}

class _ThreePickerSandFState extends State<ThreePickerSandF> {
  late PageSwitch selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter;
  }

  void _updateFilter(PageSwitch filter) {
    setState(() => selectedFilter = filter);
    widget.onChanged(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(236, 237, 238, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildOption('FAQ', PageSwitch.faq, 'assets/faq.svg'),
          const SizedBox(width: 3),
          _buildOption('Contact', PageSwitch.contact, 'assets/mail.svg'),
          const SizedBox(width: 3),
          _buildOption('Report', PageSwitch.report, 'assets/report.svg'),
        ],
      ),
    );
  }

  Widget _buildOption(String text, PageSwitch filter, String imageRoute) {
    final bool isSelected = selectedFilter == filter;
    return Expanded(
      child: InkWell(
        onTap: () => _updateFilter(filter),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Color(0xFFF4F4F5),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imageRoute,
                  width: 20,
                  height: 20,
                  color: isSelected ? Color(0xFF0077FF) : Color(0xFF8E8E8F),
                ),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Color(0xFF0077FF) : Color(0xFF8E8E8F),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
