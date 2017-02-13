DROP TABLE hospitals;
CREATE EXTERNAL TABLE hospitals (ProviderID String,HospitalName String,Address String,City String,State String,ZipCode String,CountyName String,PhoneNumber String,HospitalType String,HospitalOwnership String,EmergencyServices String,MeetsCriteriaForMeaningfulEHRs String,HospitalOverallRating String,HospitalOverallRatingComments String,MortalityNationalComparison String,MortalityNationalComparisonComments String,SafetyOfCareNationalComparison String,SafetyOfCareNationalComparisonComments String,ReadmissionNationalComparison String,ReadmissionNationalComparisonComment String,PatientExperienceNationalComparison String,PatientExperienceNationalComparisonComments String,EffectivenessOfCareNationalComparison String,EffectivenessOfCareNationalComparisonComments String,TimelinessOfCareNationalComparison String,TimelinessOfCareNationalComparisonComments String,EfficientUseOfMedicalImagingNationalComparison String,EfficientUseOfMedicalImagingNationalComparisonComments String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",", "quoteChar" = '"', "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals/';


DROP TABLE effective_care;
CREATE EXTERNAL TABLE effective_care (ProviderID String, HospitalName String, Address String, City String, State String, ZipCode String, CountyName String, PhoneNumber String, Condition String, MeasureID String, MeasureName String, Score String, Sample String, Footnote String, MeasureStartDate String, MeasureEndDate String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",", "quoteChar" = '"', "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

DROP TABLE readmissions;
CREATE EXTERNAL TABLE readmissions (ProviderID String, HospitalName String, Address String, City String, State String, ZipCode String, CountyName String, PhoneNumber String, MeasureName String, MeasureID String, ComparedtoNational String, Denominator String, Score String, LowerEstimate String, HigherEstimate String, Footnote String, MeasureStartDate String, MeasureEndDate String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",", "quoteChar" = '"', "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

DROP TABLE measures;
CREATE EXTERNAL TABLE measures (MeasureName String, MeasureID String, MeasureStartQuarter String, MeasureStartDate String, MeasureEndQuarter String, MeasureEndDate String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",", "quoteChar" = '"', "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';

DROP TABLE survey_responses;
CREATE EXTERNAL TABLE survey_responses (ProviderNumber String, HospitalName String, Address String, City String, State String, ZipCode String, CountyName String, CommunicationWithNursesFloor String, CommunicationWithNursesAchievementThreshold String, CommunicationWithNursesBenchmark String, CommunicationWithNursesBaselineRate String, CommunicationWithNursesPerformanceRate String, CommunicationWithNursesAchievementPoints String, CommunicationWithNursesImprovementPoints String, CommunicationWithNursesDimensionScore String, CommunicationWithDoctorsFloor String, CommunicationWithDoctorsAchievementThreshold String, CommunicationWithDoctorsBenchmark String, CommunicationWithDoctorsBaselineRate String, CommunicationWithDoctorsPerformanceRate String, CommunicationWithDoctorsAchievementPoints String, CommunicationWithDoctorsImprovementPoints String, CommunicationWithDoctorsDimensionScore String, ResponsivenessOfHospitalStaffFloor String, ResponsivenessOfHospitalStaffAchievementThreshold String, ResponsivenessOfHospitalStaffBenchmark String, ResponsivenessOfHospitalStaffBaselineRate String, ResponsivenessOfHospitalStaffPerformanceRate String, ResponsivenessOfHospitalStaffAchievementPoints String, ResponsivenessOfHospitalStaffImprovementPoints String, ResponsivenessOfHospitalStaffDimensionScore String, PainManagementFloor String, PainManagementAchievementThreshold String, PainManagementBenchmark String, PainManagementBaselineRate String, PainManagementPerformanceRate String, PainManagementAchievementPoints String, PainManagementImprovementPoints String, PainManagementDimensionScore String, CommunicationAboutMedicinesFloor String, CommunicationAboutMedicinesAchievementThreshold String, CommunicationAboutMedicinesBenchmark String, CommunicationAboutMedicinesBaselineRate String, CommunicationAboutMedicinesPerformanceRate String, CommunicationAboutMedicinesAchievementPoints String, CommunicationAboutMedicinesImprovementPoints String, CommunicationAboutMedicinesDimensionScore String, CleanlinessandQuietnessofHospitalEnvironmentFloor String, CleanlinessandQuietnessofHospitalEnvironmentAchievementThreshold String, CleanlinessandQuietnessofHospitalEnvironmentBenchmark String, CleanlinessandQuietnessofHospitalEnvironmentBaselineRate String, CleanlinessandQuietnessofHospitalEnvironmentPerformanceRate String, CleanlinessandQuietnessOfHospitalEnvironmentAchievementPoints String, CleanlinessandQuietnessOfHospitalEnvironmentImprovementPoints String, CleanlinessandQuietnessOfHospitalEnvironmentDimensionScore String, DischargeInformationFloor String, DischargeInformationAchievementThreshold String, DischargeInformationBenchmark String, DischargeInformationBaselineRate String, DischargeInformationPerformanceRate String, DischargeInformationAchievementPoints String, DischargeInformationImprovementPoints String, DischargeInformationDimensionScore String, OverallRatingofHospitalFloor String, OverallRatingofHospitalAchievementThreshold String, OverallRatingofHospitalBenchmark String, OverallRatingofHospitalBaselineRate String, OverallRatingofHospitalPerformanceRate String, OverallRatingofHospitalAchievementPoints String, OverallRatingofHospitalImprovementPoints String, OverallRatingofHospitalDimensionScore String, HCAHPSBaseScore String, HCAHPSConsistencyScore String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",", "quoteChar" = '"', "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';
