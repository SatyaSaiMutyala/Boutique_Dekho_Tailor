import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool? value;
  const CustomCheckBox({super.key, required this.title, this.onTap, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(children: [
        SizedBox(width: 20.0,
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              activeColor: Theme.of(context).colorScheme.primary,
              value: value,
              side: BorderSide(width: 0.7, color: Theme.of(context).textTheme.bodySmall!.color!),
              onChanged: (bool? isActive) => onTap!()
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall,),
        Text(title.tr,
          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: value == true ? Theme.of(context).primaryColor  : Theme.of(context).textTheme.bodySmall?.color),
        ),
      ]),
    );
  }
}
