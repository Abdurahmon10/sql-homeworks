-- 1. Create database and switch context
CREATE DATABASE hospital_db;
GO
USE hospital_db;
GO

-- 2. Create tables
CREATE TABLE patients (
    patient_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    date_of_birth DATE,
    gender CHAR(1),
    contact_info VARCHAR(255)
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    specialty VARCHAR(100),
    contact_info VARCHAR(255)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY IDENTITY(1,1),
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY IDENTITY(1,1),
    appointment_id INT,
    medication_name VARCHAR(100),
    dosage VARCHAR(50),
    duration VARCHAR(50),
    cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE TABLE lab_results (
    lab_result_id INT PRIMARY KEY IDENTITY(1,1),
    patient_id INT,
    test_type VARCHAR(100),
    test_date DATE,
    result_value VARCHAR(100),
    normal_range VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE alerts (
    alert_id INT PRIMARY KEY IDENTITY(1,1),
    lab_result_id INT,
    alert_date DATE,
    description TEXT,
    FOREIGN KEY (lab_result_id) REFERENCES lab_results(lab_result_id)
);
GO

-- 3. Insert 10 patients
INSERT INTO patients (name, date_of_birth, gender, contact_info) VALUES
('John Doe',       '1980-05-15', 'M', 'john@example.com'),
('Jane Smith',     '1990-07-20', 'F', 'jane@example.com'),
('Alice Johnson',  '1975-03-10', 'F', 'alice@example.com'),
('Mark Lee',       '1985-02-28', 'M', 'mark@example.com'),
('Rachel Adams',   '1992-09-15', 'F', 'rachel@example.com'),
('Tom Clark',      '1978-11-22', 'M', 'tom@example.com'),
('Susan Davis',    '1983-06-05', 'F', 'susan@example.com'),
('Peter Park',     '1995-12-01', 'M', 'peter@example.com'),
('Linda Nguyen',   '1988-04-17', 'F', 'linda@example.com'),
('David Miller',   '1970-08-30', 'M', 'david@example.com');
GO

-- 4. Insert 10 doctors
INSERT INTO doctors (name, specialty, contact_info) VALUES
('Dr. Emily Brown',    'Cardiology',   'emily@example.com'),
('Dr. Michael Green',  'Neurology',    'michael@example.com'),
('Dr. Sarah White',    'Pediatrics',   'sarah@example.com'),
('Dr. Kevin Hart',     'Dermatology',  'kevin@example.com'),
('Dr. Laura Stone',    'Orthopedics',  'laura@example.com'),
('Dr. Daniel Young',   'Oncology',     'daniel@example.com'),
('Dr. Patricia Harris','Endocrinology','patricia@example.com'),
('Dr. William Scott',  'Gastroenterology','william@example.com'),
('Dr. Barbara King',   'Psychiatry',   'barbara@example.com'),
('Dr. Charles Turner', 'Urology',      'charles@example.com');
GO

-- 5. Insert 10 appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1,  1, '2023-10-01', '10:00:00', 'completed'),
(2,  2, '2023-10-02', '11:00:00', 'no-show'),
(3,  3, '2023-10-03', '12:00:00', 'scheduled'),
(4,  4, '2023-10-04', '09:30:00', 'completed'),
(5,  5, '2023-10-05', '14:00:00', 'scheduled'),
(6,  6, '2023-10-06', '15:15:00', 'canceled'),
(7,  7, '2023-10-07', '08:45:00', 'completed'),
(8,  8, '2023-10-08', '13:20:00', 'scheduled'),
(9,  9, '2023-10-09', '10:50:00', 'no-show'),
(10, 10,'2023-10-10', '16:00:00', 'completed');
GO

-- 6. Insert 10 prescriptions
INSERT INTO prescriptions (appointment_id, medication_name, dosage, duration, cost) VALUES
(1,  'Aspirin',       '100mg',   '1 week',   10.50),
(1,  'Ibuprofen',     '200mg',   '2 weeks',  15.75),
(3,  'Paracetamol',   '500mg',   '3 days',    5.25),
(4,  'Hydrocortisone','50mg',    '1 week',   12.00),
(5,  'Amoxicillin',   '250mg',   '5 days',    8.75),
(7,  'Metformin',     '500mg',   '1 month',  25.00),
(8,  'Lisinopril',    '10mg',    '2 weeks',  20.00),
(9,  'Simvastatin',   '20mg',    '1 month',  30.00),
(10, 'Omeprazole',    '20mg',    '2 weeks',  18.50),
(6,  'Levothyroxine', '50mcg',   '1 month',  22.00);
GO

-- 7. Insert 10 lab results
INSERT INTO lab_results (patient_id, test_type, test_date, result_value, normal_range) VALUES
(1, 'Blood Sugar',    '2023-10-01', '120',     '70-100'),
(2, 'Cholesterol',    '2023-10-02', '200',    '100-200'),
(3, 'Blood Pressure', '2023-10-03', '130/80', '120/80'),
(4, 'Hemoglobin',     '2023-10-04', '13.5',   '13.0-17.0'),
(5, 'Vitamin D',      '2023-10-05', '20',      '30-100'),
(6, 'Thyroid Stim.',  '2023-10-06', '4.0',     '0.4-4.0'),
(7, 'Calcium',        '2023-10-07', '9.2',     '8.5-10.2'),
(8, 'Magnesium',      '2023-10-08', '1.8',     '1.7-2.2'),
(9, 'Platelet Count', '2023-10-09', '250',     '150-450'),
(10,'Creatinine',     '2023-10-10', '1.1',     '0.6-1.3');
GO

-- 8. Insert 10 alerts (one per lab_result)
INSERT INTO alerts (lab_result_id, alert_date, description) VALUES
(1,  '2023-10-01', 'Blood sugar level above normal range'),
(2,  '2023-10-02', 'Cholesterol level at upper normal limit'),
(3,  '2023-10-03', 'Blood pressure slightly elevated'),
(4,  '2023-10-04', 'Hemoglobin within normal range'), 
(5,  '2023-10-05', 'Vitamin D deficiency'), 
(6,  '2023-10-06', 'Thyroid-stimulating hormone at upper limit'),
(7,  '2023-10-07', 'Calcium normal'),
(8,  '2023-10-08', 'Magnesium normal'),
(9,  '2023-10-09', 'Platelet count normal'),
(10, '2023-10-10','Creatinine normal');
GO



---1st query

select 
d.doctor_id,
count(distinct a.patient_id) as patient_count,
cast(count(a.appointment_id) as decimal(10,2))/nullif(count(a.patient_id),0) as avg_appoinment_count
from doctors as d
left join appointments as a
on d.doctor_id=a.doctor_id
group by d.doctor_id
order by d.doctor_id


--2nd query

with last_lab as(
	select 
	lr.lab_result_id,
	lr.normal_range,
	lr.patient_id,
	lr.result_value,
	lr.test_date,
	lr.test_type,
	ROW_NUMBER() over (partition by lr.patient_id
	order by lr.test_date desc, lr.lab_result_id desc) as rn 
	from lab_results as lr
)
select 
p.patient_id,
p.name,
ll.test_type,
ll.lab_result_id,
ll.result_value,
ll.normal_range
from last_lab as ll
inner join patients as p
on p.patient_id=ll.patient_id
where ll.rn=1
order by ll.lab_result_id;


--3
select medication_name, cost as price, sum(cost) as total_cost from prescriptions
group by medication_name, cost; 


--4

INSERT INTO patients (name, date_of_birth, gender, contact_info) VALUES
  ('Elder One',    '1940-01-01', 'M', 'elder1@example.com'),   -- age 85
  ('Senior Two',   '1935-07-12', 'F', 'senior2@example.com'),  -- age 89
  ('Senior Three', '1950-04-10', 'M', 'senior3@example.com'),  -- age 75
  ('Senior Four',  '1954-05-05', 'F', 'senior4@example.com'),  -- age 71 (just turned 71 yesterday)
  ('Senior Five',  '1948-11-20', 'M', 'senior5@example.com');  -- age 76
GO

-- 2. (Optional) Give each a lab result so they show up in l65p:
INSERT INTO lab_results (patient_id, test_type, test_date, result_value, normal_range) VALUES
  ((SELECT patient_id FROM patients WHERE name='Elder One'),    'Blood Sugar',    GETDATE(), '115', '70-100'),
  ((SELECT patient_id FROM patients WHERE name='Senior Two'),   'Cholesterol',    GETDATE(), '210', '100-200'),
  ((SELECT patient_id FROM patients WHERE name='Senior Three'), 'Blood Pressure', GETDATE(), '140/90', '120/80'),
  ((SELECT patient_id FROM patients WHERE name='Senior Four'),  'Hemoglobin',     GETDATE(), '12.8', '13.0-17.0'),
  ((SELECT patient_id FROM patients WHERE name='Senior Five'),  'Vitamin D',      GETDATE(), '25', '30-100');
GO

INSERT INTO lab_results (patient_id, test_type, test_date, result_value, normal_range) VALUES
  ((SELECT patient_id FROM patients WHERE name='Elder One'),    'Blood Sugar',    GETDATE(), '115', '70-100'),
  ((SELECT patient_id FROM patients WHERE name='Senior Two'),   'Cholesterol',    GETDATE(), '210', '100-200'),
  ((SELECT patient_id FROM patients WHERE name='Senior Three'), 'Blood Pressure', GETDATE(), '140/90', '120/80'),
  ((SELECT patient_id FROM patients WHERE name='Senior Four'),  'Hemoglobin',     GETDATE(), '12.8', '13.0-17.0'),
  ((SELECT patient_id FROM patients WHERE name='Senior Five'),  'Vitamin D',      GETDATE(), '25', '30-100');
GO

with p65p as(
	select * from patients as p
	where DATEDIFF(year,p.date_of_birth,getdate())>=65
),
l65p as(
	select lr.* from lab_results as lr
	inner join p65p as p on lr.patient_id=p.patient_id
)

select test_type,count(l.patient_id) as frequency from l65p as l
group by test_type
order by frequency;

--5

WITH PrescDur AS (
  SELECT
    a.doctor_id,
    -- Normalize durations: days, weeks→×7, months→×30
    CASE
      WHEN pr.duration LIKE '%day%'   THEN TRY_CAST(LEFT(pr.duration, CHARINDEX(' ', pr.duration)-1) AS DECIMAL(10,2))
      WHEN pr.duration LIKE '%week%'  THEN TRY_CAST(LEFT(pr.duration, CHARINDEX(' ', pr.duration)-1) AS DECIMAL(10,2)) * 7
      WHEN pr.duration LIKE '%month%' THEN TRY_CAST(LEFT(pr.duration, CHARINDEX(' ', pr.duration)-1) AS DECIMAL(10,2)) * 30
      ELSE NULL
    END AS duration_days
  FROM prescriptions AS pr
  INNER JOIN appointments AS a
    ON pr.appointment_id = a.appointment_id
)
select d.specialty, round(avg(p.duration_days),2) as avg_duration, count(a.appointment_id) as appointment_num from doctors as d
left join appointments as a on a.doctor_id=d.doctor_id
left join PrescDur as p on p.doctor_id=d.doctor_id
group by d.specialty


--6
create trigger trg_labresultalert
on lab_results
after insert, update
as
begin
  set nocount on;

  insert into alerts (lab_result_id, alert_date, description)
  select
    i.lab_result_id,
    cast(getdate() as date),
    'test "' + i.test_type + '" result ' + i.result_value +
    ' is outside normal range [' + i.normal_range + ']'
  from inserted i
  cross apply (
    select
      try_cast(left(i.normal_range, charindex('-', i.normal_range) - 1) as decimal(10,2)) as low_val,
      try_cast(substring(i.normal_range, charindex('-', i.normal_range) + 1, len(i.normal_range)) as decimal(10,2)) as high_val
  ) nr
  where try_cast(i.result_value as decimal(10,2)) < nr.low_val
     or try_cast(i.result_value as decimal(10,2)) > nr.high_val;
end;
go
--7
if object_id('dbo.available_schedule','v') is not null
  drop view dbo.available_schedule;
go

create view available_schedule as
with daterange as (
  select cast(getdate() as date) as sch_date, 0 as day_offset
  union all
  select dateadd(day, day_offset+1, cast(getdate() as date)), day_offset+1
  from daterange
  where day_offset < 6
),
hourslots as (
  select number + 9 as start_hour
  from master.dbo.spt_values
  where type = 'p'
    and number between 0 and 7
),
allslots as (
  select
    d.doctor_id,
    dr.sch_date,
    timefromparts(hs.start_hour,   0,0,0,0) as slot_start,
    timefromparts(hs.start_hour+1, 0,0,0,0) as slot_end
  from doctors      as d
  cross join daterange  as dr
  cross join hourslots  as hs
),
booked as (
  select
    doctor_id,
    appointment_date as sch_date,
    appointment_time as slot_start
  from appointments
  where appointment_date between cast(getdate() as date)
                             and dateadd(day,6,cast(getdate() as date))
)
select
  aslt.doctor_id,
  aslt.sch_date,
  aslt.slot_start,
  aslt.slot_end
from allslots as aslt
left join booked as b
  on b.doctor_id = aslt.doctor_id
 and b.sch_date   = aslt.sch_date
 and b.slot_start = aslt.slot_start
where b.doctor_id is null;
go
--8
select
  count(*)                                    as no_show_count,
  (count(*) * 100.0 / cast((select count(*) from appointments) as decimal(10,2)))
                                              as no_show_percentage
from appointments
where status = 'no-show';