/// بيانات وهمية خاصة بتدفق تسجيل الدخول وإنشاء حساب المريض.
///
/// هذه القيم Presentation fixtures فقط لتطوير واجهات PAT-18 إلى PAT-21.
/// لا تمثل بيانات حقيقية، ولا يوجد خلفها Backend أو خدمة OTP.
abstract final class AuthMockData {
  const AuthMockData._();

  // Patient canonical fixture.
  static const String patientId = 'pat-001';
  static const String patientFullName = 'أحمد بلال';
  static const String patientRelation = 'أب';

  // Phone fixture shared by PAT-20 and PAT-21.
  static const String maskedPhone = '+967 777 994 899';

  // OTP presentation fixture.
  static const int otpLength = 6;

  /// قيمة بصرية فقط لمطابقة PAT-20 / waiting،
  /// حيث يعرض الـHigh Fidelity أول خليتين ممتلئتين.
  ///
  /// ليست رمز تحقق حقيقيًا ولا تتم مقارنتها بأي قيمة.
  static const String waitingOtpFixture = '12';
}