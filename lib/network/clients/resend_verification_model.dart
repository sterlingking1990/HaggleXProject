import 'package:hive/hive.dart';

part 'resend_verification_model.g.dart';

@HiveType(typeId: 1)
class ResendVerificationModel {
  @HiveField(0)
  String email;
}
