# Aafiatak — High-Fidelity Screen & State Manifest v2.0

**Target:** Phone only (`390×844` reference viewport; responsive container capped at 430 CSS px).

**Logical screens:** 21  
**Implemented UI states:** 142

| Screen | Title | Default state | States |
|---|---|---|---:|
| PAT-01 | الرئيسية / اكتشف | `patient-populated` | 6 |
| PAT-02 | البحث والنتائج | `results` | 6 |
| PAT-03 | تفاصيل الطبيب | `active` | 5 |
| PAT-04 | تفاصيل الخدمة | `active` | 5 |
| PAT-05 | تفاصيل المنشأة والفرع | `loaded` | 4 |
| PAT-06 | التوفر / اختيار اليوم | `bookable` | 8 |
| PAT-07 | مراجعة الحجز والحجز المؤقت | `pre-hold-review` | 7 |
| PAT-08 | الدفع الكامل | `ready` | 6 |
| PAT-09 | نتيجة الدفع والمعالجة | `success-confirmed` | 9 |
| PAT-10 | تأكيد الحجز | `confirmed-paid` | 2 |
| PAT-11 | مواعيدي | `upcoming-populated` | 8 |
| PAT-12 | تفاصيل الموعد | `confirmed` | 8 |
| PAT-13 | الدفع قيد المعالجة | `succeeded` | 10 |
| PAT-14 | حالة الزيارة والطابور | `checked-in-waiting` | 10 |
| PAT-15 | مركز الإشعارات | `populated-unread` | 7 |
| PAT-16 | حسابي | `loaded` | 6 |
| PAT-17 | تعديل الملف الشخصي | `editing` | 7 |
| PAT-18 | الدخول إلى الحساب | `default` | 3 |
| PAT-19 | رقم الهاتف | `idle` | 9 |
| PAT-20 | التحقق برمز واتساب | `waiting` | 9 |
| PAT-21 | استكمال بيانات المريض | `editing` | 7 |

Every state is available through the coded prototype and has a rendered review PNG under `screenshots/preview/`. The final approved default screen for each PAT destination is exported at 4× viewport density and as a 3× full-scroll reference.
