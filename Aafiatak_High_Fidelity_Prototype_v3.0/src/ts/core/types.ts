
namespace AAF {
  export type ScreenId =
    | 'PAT-01'|'PAT-02'|'PAT-03'|'PAT-04'|'PAT-05'|'PAT-06'|'PAT-07'
    | 'PAT-08'|'PAT-09'|'PAT-10'|'PAT-11'|'PAT-12'|'PAT-13'|'PAT-14'
    | 'PAT-15'|'PAT-16'|'PAT-17'|'PAT-18'|'PAT-19'|'PAT-20'|'PAT-21';

  export interface ScreenRenderer {
    id: ScreenId;
    title: string;
    defaultState: string;
    states: string[];
    render: (state: string) => string;
  }

  export interface DoctorFixture {
    id: string; initials: string; name: string; specialty: string; department: string;
    qualification: string; biography: string; facility: string; branch: string;
    services: {name:string; amount:string; policy:string}[];
    workingDays: string; workingHours: string;
  }

  export interface AppointmentFixture {
    doctor: string; service: string; facility: string; branch: string;
    date: string; arrivalWindow: string; amount: string; currency: string;
    bookingNumber: string; paymentReference: string;
  }

  export const registry: Record<string, ScreenRenderer> = {};
  export function register(screen: ScreenRenderer) { registry[screen.id] = screen; }
}
