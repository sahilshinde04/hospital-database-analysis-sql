Hospital Database Management (SQL Project).

Project Description
This project creates and analyzes a hospital management database using SQL. The system stores information about patients, doctors, and appointments.

Tools Used
- MySQL
- SQL

 Dataset Information
The dataset contains information about hospital patients, doctors, and appointments.

Key SQL Operations
- SELECT
- WHERE
- JOIN
- GROUP BY
- Aggregate Functions

 Sample SQL Query
SELECT doctor_id, COUNT(patient_id) AS total_patients
FROM appointments
GROUP BY doctor_id;

 Insights Generated
- Patient records management
- Doctor workload analysis
- Appointment tracking

Conclusion
This project demonstrates how SQL can be used to manage and analyze healthcare data.
