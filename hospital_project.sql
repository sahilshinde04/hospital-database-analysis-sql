
CREATE DATABASE hospital_project;
USE hospital_project;

CREATE TABLE patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    experience INT,
    phone VARCHAR(15)
);

CREATE TABLE appointments (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    doctor_id VARCHAR(10),
    appointment_date DATE,
    status VARCHAR(50),
    
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE treatments (
    treatment_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10),
    treatment_type VARCHAR(100),
    description TEXT,
    cost DECIMAL(10,2),
    treatment_date DATE,
    
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE TABLE billing (
    bill_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    billing_date DATE,
    
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);


SELECT *
FROM appointments;

SELECT *
FROM doctors;

SELECT *
FROM patients;

SELECT *
FROM treatments;

SELECT *
FROM billing;

SELECT
TIME_FORMAT(appointment_time, '%H:%i:%s') AS appointment_time
FROM appointments;

UPDATE appointments
SET appointment_time = time_format(appointment_time,'%H:%i:%s');


SELECT SUM(cost) AS total_revenue
FROM treatments;

SELECT AVG(cost) AS avg_cost
FROM treatments;

SELECT MONTH(treatment_date) AS month,
SUM(cost) AS revenue
FROM treatments
GROUP BY month;


SELECT treatment_type, cost
FROM treatments
ORDER BY cost DESC
LIMIT 1;


SELECT d.first_name, COUNT(a.patient_id) AS total_patients
FROM doctors d
JOIN appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.first_name
ORDER BY total_patients DESC;

# TOP 5 Top 5 Highest Spending Patient

SELECT p.first_name,
SUM(t.cost) AS total_spent
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY p.first_name
ORDER BY total_spent DESC
LIMIT 5;

# MOST PUPOLAR'S TREATMENT IN THE HOSPITAL
SELECT treatment_type,
COUNT(*) AS total_times
FROM treatments
GROUP BY treatment_type
ORDER BY total_times DESC;

# count doctore total appointments
SELECT doctor_id,
COUNT(*) AS total_appointments
FROM appointments
GROUP BY doctor_id
HAVING COUNT(*) > 10;


CREATE VIEW patient_treatment_summary AS
SELECT p.first_name,
t.treatment_type,
t.cost
FROM patients p
JOIN appointments a ON p.patient_id=a.patient_id
JOIN treatments t ON a.appointment_id=t.appointment_id;

SELECT * FROM  patient_treatment_summary;

# make store procedure
DELIMITER $$
CREATE PROCEDURE total_patient_count()
BEGIN
SELECT COUNT(*) FROM patients;
END $$
DELIMITER ;

CALL total_patient_count();







