DROP TABLE pers
  CASCADE CONSTRAINTS;
DROP TABLE mem
  CASCADE CONSTRAINTS;
DROP TABLE addr
  CASCADE CONSTRAINTS;
DROP TABLE medications
  CASCADE CONSTRAINTS;
DROP TABLE medProf
  CASCADE CONSTRAINTS;
DROP TABLE facility
  CASCADE CONSTRAINTS;
DROP TABLE medicalInfo
  CASCADE CONSTRAINTS;

  
  
  
/* ******************************* **
   Here are some of the tables I 
   created for this group project.
** ******************************* */

--Person
CREATE TABLE pers(
  person_ID        NUMBER(5)    NOT NULL,
  addr_ID          NUMBER(5)    NOT NULL,
  email_ID         NUMBER(5)    NOT NULL,
  pers_fName       VARCHAR2(35) NOT NULL,
  pers_mName       VARCHAR2(35),
  pers_LName       VARCHAR2(35) NOT NULL,
    CONSTRAINT person_ID_pk  PRIMARY KEY(person_ID),
    CONSTRAINT pers_addr_fk  FOREIGN KEY(person_addr)
      REFERENCES addr(addr_ID),
    CONSTRAINT pers_email_fk FOREIGN KEY(person_email)
      REFERENCES email(email_ID)); 

  
  
  
  

--Member
CREATE TABLE mem(
  person_ID     NUMBER(5)    NOT NULL,
  school_ID     NUMBER(5)    NOT NULL,
  mem_teacher   NUMBER(5)    NOT NULL,
  mem_yrInSch   NUMBER(2)    NOT NULL,
  mem_avgGrades CHAR(1)      NOT NULL,
  mem_DOB       DATE         NOT NULL,
  mem_gender    CHAR(1)      NOT NULL,
  mem_ethnicity VARCHAR2(16) NOT NULL,
  mem_ssn       NUMBER(9)    NOT NULL,
  mem_parSatis  VARCHAR2(3)  NOT NULL,
    CONSTRAINT mem_ID_pk PRIMARY KEY(person_ID),
    CONSTRAINT mem_ID_fk FOREIGN KEY(person_ID)
      REFERENCES pers(person_ID),
    CONSTRAINT mem_sch_fk  FOREIGN KEY(school_ID)
      REFERENCES school(school_ID),
    CONSTRAINT mem_te_fk   FOREIGN KEY(mem_teacher)
      REFERENCES teacher(teacher_ID),
    CONSTRAINT person_Gender_cc
      CHECK (person_gender IN ('M', 'F')),
    CONSTRAINT person_ethnicity_cc
      CHECK (person_ethnicity IN
              ('African American', 'Caucasian',
               'Asian', 'American Indian', 'Hispanic'))
    CONSTRAINT mem_parSat_cc
      CHECK(mem_parSatis IN('YES', 'NO')));
      
      
      
      
--Address
CREATE TABLE addr(
  addr_ID     NUMBER(5)    NOT NULL,
  addr_addr   VARCHAR2(35) NOT NULL,
  addr_addr2  VARCHAR2(35) DEFAULT '',
  addr_city   VARCHAR2(35) NOT NULL,
  addr_state  CHAR(2)      NOT NULL,
  addr_zip    NUMBER(9)    NOT NULL,
    CONSTRAINT addr_ID_pk PRIMARY KEY(addr_ID));
      
      
      
      
--Medications
CREATE TABLE medications(
  person_ID   NUMBER(5)     NOT NULL,
  med_name    VARCHAR2(50)  NOT NULL,
  med_prs_doc VARCHAR2(35) NOT NULL,
  med_amt     VARCHAR2(35)  NOT NULL,
  med_times   VARCHAR2(35)  NOT NULL,
  med_taken   VARCHAR2(35)  NOT NULL,
  med_instruc VARCHAR2(50),
    CONSTRAINT med_mem_pk PRIMARY KEY(person_ID),
    CONSTRAINT med_mem_fk FOREIGN KEY(person_ID) REFERENCES mem(person_ID));


  
  
  
--Insurance
CREATE TABLE medicalInfo(
  person_ID    NUMBER(5)    NOT NULL,
  medi_allerg  VARCHAR2(50) NOT NULL,
  medi_check   DATE         NOT NULL,
  medi_immune  VARCHAR2(3)  NOT NULL,
  medi_counsl  VARCHAR2(3)  NOT NULL,
  medi_dentIns VARCHAR2(3)  NOT NULL,
  medi_dentSea VARCHAR2(3)  NOT NULL,
    CONSTRAINT medi_id_pk   PRIMARY KEY (person_ID),
    CONSTRAINT medi_mem_fk  FOREIGN KEY (medi_member) REFERENCES mem(person_ID)
    CONSTRAINT medi_imm_cc  CHECK(medi_immune  IN('YES', 'NO'))
    CONSTRAINT medi_cou_cc  CHECK(medi_counsl  IN('YES','NO'))
    CONSTRAINT medi_dIns_cc CHECK(medi_dentIns IN('YES', 'NO'))
    CONSTRAINT medi_dSea_cc CHECK(medi_dentSea IN('YES','NO')));


  
  
--Facility
CREATE TABLE facility(
  facility_ID      NUMBER (5)   NOT NULL,
  facility_phone   NUMBER(5)    NOT NULL,
  facility_address NUMBER(5)    NOT NULL,
  facility_name    VARCHAR2(35) NOT NULL,
    CONSTRAINT fac_id_pk PRIMARY KEY(facility_id),,
    CONSTRAINT fac_pho_fk FOREIGN KEY(facility_phone) REFERENCES phone(phone_ID)
    CONSTRAINT fac_med_fk FOREIGN KEY(facility_addr)  REFERENCES addr(addr_ID));

    
    
  
  
--Medical Professional
CREATE TABLE medProf(
  person_ID        NUMBER(5) NOT NULL,
  member_ID        NUMBER(5) NOT NULL,
  medProf_facility NUMBER(5) NOT NULL,
  medProf_DocDen   VARCHAR2(7) NOT NULL,
    CONSTRAINT medProf_id_pk       PRIMARY KEY(person_ID),
    CONSTRAINT medProf_name_fk     FOREIGN KEY(person_ID)        REFERENCES pers(person_ID),
    CONSTRAINT medProf_member      FOREIGN KEY(member_ID)         REFERENCES mem(person_ID),
    CONSTRAINT medProf_facility_fk FOREIGN KEY(medProf_facility) REFERENCES facility(facility_ID));

INSERT INTO pers
  VALUES( 10004, 30004, 17004, 'Benjamin', 'Andrew', 'Moore');
/* Other INSERT INTO's removed to keep example short */


/* ***************************************************************
   Here are some of the queries I came up with for the project,
   using the above tables.
   We were supposed to perform queries for tasks the 
   business user might actually need.
*************************************************************** */


--What are all the names of our members
SELECT pers.pers_Lname AS "Last Name", pers.pers_Fname AS "First Name"
FROM pers, mem
WHERE pers.person_ID = mem.person_ID;

--How many girls attend the BGC?
SELECT COUNT(mem_gender) AS "Number of Females" FROM mem
  WHERE mem_gender = 'F';
--How many boys attend the BGC?
SELECT COUNT(mem_gender) AS "Number of Males" FROM mem
  WHERE mem_gender = 'M';

--Find all addresses outside Eau Claire
SELECT addr_addr AS "Address", addr_addr2 AS "Apt/Room", addr_city AS "City", addr_state AS "State", addr_zip AS "Zip"
  FROM addr WHERE addr_city NOT IN 'Eau Claire';
--Find all addresses, ordered by zip to help determine bus routes
SELECT addr_addr AS "Address", addr_addr2 AS "Apt/Room", addr_city AS "City", addr_state AS "State", addr_zip AS "Zip"
  FROM addr ORDER BY addr_zip;
--Find all addresses within the same zip as the BGC building
SELECT addr_addr AS "Address", addr_addr2 AS "Apt/Room" FROM addr
  WHERE addr_city = 'Eau Claire'
    AND addr_zip = 54701
      ORDER BY addr_zip;

--Find the members that live in a certain zip code(e.g. 54701)
SELECT pers.pers_fName AS "First Name", pers.pers_fName AS "Last Name" FROM pers, addr, mem
  WHERE mem.person_ID = pers.person_ID
    AND pers.addr_ID = addr.addr_ID
      AND addr.addr_zip = 54701;

--What is Bruce Willis' birthday?
SELECT TO_CHAR(mem_DOB, 'Mon DD, YYYY') AS "Birthday" FROM mem INNER JOIN pers USING (person_ID)
WHERE UPPER(pers.pers_fName) = UPPER('Bruce')
AND UPPER(pers_LName) = UPPER('Willis');

--Report distinct cities for general report
Select DISTINCT addr_zip AS "Zip", addr_city AS "City" FROM addr
  ORDER BY addr_city;

--What are the distinct hospitals and (dental) clinics
SELECT DISTINCT facility.facility_name AS "Facility Name" FROM facility;

--How many diverse racial groups are the members?
SELECT DISTINCT COUNT(DISTINCT mem.mem_ethnicity)
                  AS "Number of Diverse Groups" FROM mem;

--How many parents are not satisfied with their childs(member) grades?
SELECT COUNT(mem.mem_parSatis) AS "# Dissatisfied w/ Grades" FROM mem
  WHERE mem.mem_parSatis = 'NO';

--What are the different times members have to take medications?
SELECT DISTINCT medications.med_times
         AS "Different Med Times" FROM medications;

--How many members have peanut allergies?
SELECT COUNT(medicalInfo.medi_allerg)
         AS "# Who Have Peanut Allergies" FROM medicalInfo
  WHERE UPPER(medicalInfo.medi_allerg) LIKE '%PEANUT%';

--Join tables member and person
SELECT * FROM mem INNER JOIN pers USING (person_ID);

--What are the names and birthdays of our members
SELECT pers_fName AS "First Name", pers_mName AS "Middle Name", pers_LName AS "Last Name", mem_DOB AS "Birthdate" FROM pers, mem
WHERE pers.person_ID = mem.person_ID
ORDER BY pers.pers_LName;

--Where do the members doctors work?
SELECT facility.facility_name AS "Facility Name" FROM facility, medProf
  WHERE facility.facility_ID = medProf.medProf_facility
    AND medProf.medProf_DocDen = 'Doctor';