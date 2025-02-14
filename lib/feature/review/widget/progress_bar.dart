import 'package:demandium_provider/core/helper/core_export.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double percent;
  final Color color;
  const ProgressBar({
    super.key,
    required this.title,
    required this.percent,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style:  ubuntuMedium.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          SizedBox(
            width: 245,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: LinearProgressIndicator(
                minHeight: 5,
                value: percent,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                backgroundColor: const Color(0xFFEAEAEA),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
