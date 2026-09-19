import 'package:flutter/material.dart';

import '../features/appointments/mock_data.dart';
import '../features/appointments/screens/appointment_details_screen.dart';
import '../features/appointments/screens/appointments_screen.dart';
import '../features/auth/auth_intent.dart';
import '../features/auth/screens/auth_entry_screen.dart';
import '../features/auth/screens/complete_patient_profile_screen.dart';
import '../features/auth/screens/phone_screen.dart';
import '../features/auth/screens/whatsapp_otp_screen.dart';
import '../features/booking/mock_data.dart';
import '../features/booking/screens/availability_screen.dart';
import '../features/booking/screens/booking_review_screen.dart';
import '../features/discovery/mock_data.dart';
import '../features/discovery/screens/doctor_details_screen.dart';
import '../features/discovery/screens/facility_details_screen.dart';
import '../features/discovery/screens/home_screen.dart';
import '../features/discovery/screens/search_screen.dart';
import '../features/discovery/screens/service_details_screen.dart';
import '../features/notifications/screens/notifications_screen.dart';
import '../features/payment/screens/payment_result_screen.dart';
import '../features/payment/screens/payment_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import 'patient_shell.dart';

/// المنسق الوحيد لرحلات المريض. تبويبات الجذر تتبدل محليًا، وكل شاشة
/// تفصيلية تفتح فوقها باستخدام Navigator وMaterialPageRoute فقط.
class PatientFlow extends StatefulWidget {
  const PatientFlow({super.key});

  @override
  State<PatientFlow> createState() => _PatientFlowState();
}

class _PatientFlowState extends State<PatientFlow> {
  PatientTab _activeTab = PatientTab.home;
  bool _isAuthenticated = false;

  void _selectTab(PatientTab tab) {
    if (!_isAuthenticated && tab != PatientTab.home) {
      _openAuth();
      return;
    }

    setState(() => _activeTab = tab);
  }

  void _openAuth() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => AuthEntryScreen(
          onPhoneRequested: (intent) => _openPhone(intent),
          onBrowseTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openPhone(AuthIntent intent) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PhoneScreen(
          intent: intent,
          onOtpRequested: (phone) => _openOtp(intent, phone),
        ),
      ),
    );
  }

  void _openOtp(AuthIntent intent, String phone) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => WhatsAppOtpScreen(
          intent: intent,
          phone: phone,
          onChangePhone: () => Navigator.of(context).pop(),
          onResendRequested: () {},
          onVerifyRequested: (_) {
            if (intent == AuthIntent.login) {
              _finishAuthentication();
            } else {
              _openProfileCompletion(phone);
            }
          },
        ),
      ),
    );
  }

  void _openProfileCompletion(String phone) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) =>
            ProfileCompletion(phone: phone, onFinished: _finishAuthentication),
      ),
    );
  }

  void _finishAuthentication() {
    _isAuthenticated = true;
    setState(() => _activeTab = PatientTab.home);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _logout() {
    _isAuthenticated = false;
    setState(() => _activeTab = PatientTab.home);
  }

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SearchScreen(
          onDoctorSelected: _openDoctor,
          onServiceSelected: _openService,
          onFacilitySelected: _openFacility,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openDoctor(String doctorId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => DoctorDetailsScreen(
          doctorId: doctorId,
          onFacilityRequested: _openFacility,
          onServiceRequested: _openService,
          onAvailabilityRequested: _openAvailability,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openService(String serviceId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ServiceDetailsScreen(
          serviceId: serviceId,
          onFacilityRequested: _openFacility,
          onAvailabilityRequested: _openAvailability,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openFacility(String facilityId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => FacilityDetailsScreen(
          facilityId: facilityId,
          onDoctorRequested: _openDoctor,
          onServiceRequested: _openService,
          onShowLocationRequested: () {},
          onCallRequested: () {},
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openAvailability() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) =>
            AvailabilityScreen(onReviewTap: _openBookingReview),
      ),
    );
  }

  void _openBookingReview(AvailabilityDayMock selectedDay) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BookingReviewScreen(
          selectedDay: selectedDay,
          onPaymentTap: _openPayment,
        ),
      ),
    );
  }

  void _openPayment(AvailabilityDayMock selectedDay) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PaymentScreen(
          selectedDay: selectedDay,
          onPaymentTap: _openPaymentResult,
        ),
      ),
    );
  }

  void _openPaymentResult() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PaymentResultScreen(
          onAppointmentTap: () => _openAppointmentDetails(
            AppointmentsMockData.upcomingAppointments.first.id,
          ),
        ),
      ),
    );
  }

  void _openAppointmentDetails(String appointmentId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => AppointmentDetailsScreen(
          appointmentId: appointmentId,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openNotifications() {
    if (!_isAuthenticated) {
      _openAuth();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => NotificationsScreen(
          onAppointmentSelected: _openDefaultAppointmentDetails,
          onPaymentSelected: _openDefaultAppointmentDetails,
          onVisitSelected: _openDefaultAppointmentDetails,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _openDefaultAppointmentDetails() {
    _openAppointmentDetails(AppointmentsMockData.upcomingAppointments.first.id);
  }

  void _openEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EditProfileScreen(
          onSave: (_) => Navigator.of(context).pop(),
          onBackPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_activeTab) {
      case PatientTab.home:
        return HomeScreen(
          audience: _isAuthenticated
              ? HomeAudience.patient
              : HomeAudience.guest,
          onSearchRequested: _openSearch,
          onBookRequested: _openAvailability,
          onAvailabilityRequested: _openAvailability,
          onServiceRequested: () => _openService(serviceItem1.id),
          onFacilityRequested: () => _openFacility(facility1.id),
          onDoctorSelected: (_) => _openDoctor('doc-001'),
          onServiceSelected: (service) => _openService(service.id),
          onViewAppointmentDetails: _openDefaultAppointmentDetails,
          onNotificationPressed: _openNotifications,
          onTabSelected: _selectTab,
        );
      case PatientTab.appointments:
        return AppointmentsScreen(
          onAppointmentTap: _openAppointmentDetails,
          onNotificationsTap: _openNotifications,
          onTabSelected: _selectTab,
        );
      case PatientTab.profile:
        return ProfileScreen(
          onEditRequested: _openEditProfile,
          onLogoutRequested: _logout,
          onNotificationPressed: _openNotifications,
          onTabSelected: _selectTab,
        );
    }
  }
}
