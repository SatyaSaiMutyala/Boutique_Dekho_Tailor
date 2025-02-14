import 'package:demandium_provider/core/helper/core_export.dart';

class Provider{
  final String name;
  final String address;
  final Widget? logo;

   Provider({
    required this.name,
     required this.address,
     this.logo,
   });
}
