-- FIT DATABASE UNDERGRADUATE UNITS ASSIGNMENT 2 / S1 / 2019
-- FILL IN THE FOLLOWING:
--Unit Code: FIT2094
--Student ID: 29625564
--Student Full Name: Prashant Murali
--Student email: pmur0005@student.monash.edu
--Tutor Name: Mr. Jiang Ou

/*  --- COMMENTS TO YOUR MARKER --------
 - RUN THE DROP COMMANDS AT 428 TO 430 BEFORE DROPPING THE OTHER TABLES.
 - FOR TASK 4.3, THE GARAGE AND MANAGER ENTITIES HAVE BECOME A MANY TO MANY
 --         RELATIONSHIP SO A NEW BRIDGING ENTITY IS CREATED.
*/

--Q1
/*
TASK 1.1 BELOW
*/

--ADDING VEHICLE_UNIT TABLE--
CREATE TABLE vehicle_unit (
    garage_code                NUMBER(2) NOT NULL,
    vunit_id                   NUMBER(6) NOT NULL,
    vunit_purchase_price       NUMBER(7,2) NOT NULL,
    vunit_exhibition_flag      CHAR(1) NOT NULL,
    vehicle_insurance_id       VARCHAR2(20) NOT NULL,
    vunit_rego                 VARCHAR2(8) NOT NULL
);

COMMENT ON COLUMN vehicle_unit.garage_code IS
    'unique code for garage';
COMMENT ON COLUMN vehicle_unit.vunit_id IS
    'garrage-assigned local id number (repeated at each garage)';
COMMENT ON COLUMN vehicle_unit.vunit_purchase_price IS
    'purchase price of the vehicle';
COMMENT ON COLUMN vehicle_unit.vunit_exhibition_flag IS
    'flag to indicate if a vehicle is for exhibition or not';
COMMENT ON COLUMN vehicle_unit.vehicle_insurance_id IS
    'insurance id for the vehicle';
COMMENT ON COLUMN vehicle_unit.vunit_rego IS
    'vehicles unique registration code issued by the government';
    
--'E' stands for Exhibition, 'R' stands for standard rental.
ALTER TABLE vehicle_unit
    ADD CONSTRAINT vunit_exhibition_flag_chk CHECK ( vunit_exhibition_flag IN (
        'E',
        'R'
    ) );
    
ALTER TABLE vehicle_unit ADD CONSTRAINT vehicle_unit_pk PRIMARY KEY (garage_code,vunit_id);

ALTER TABLE vehicle_unit ADD CONSTRAINT vunit_rego_uq UNIQUE ( vunit_rego );


--ADDING LOAN TABLE--
CREATE TABLE loan (
    garage_code             NUMBER(2) NOT NULL,
    vunit_id                NUMBER(6) NOT NULL,
    loan_date_time          DATE NOT NULL,
    loan_due_date           DATE NOT NULL,
    loan_actual_return_date DATE,
    renter_no               NUMBER(6) NOT NULL
);

COMMENT ON COLUMN loan.garage_code IS
    'unique garage code';
COMMENT ON COLUMN loan.vunit_id IS
    'garrage-assigned local id number (repeated at each garage)';
COMMENT ON COLUMN loan.loan_date_time IS
    'date and time when vehicle is being loaned';
COMMENT ON COLUMN loan.loan_due_date IS
    'date and time when vehicle needs to be returned';
COMMENT ON COLUMN loan.loan_actual_return_date IS
    'date and time when vehicle is returned';
COMMENT ON COLUMN loan.renter_no IS
    'renter is identified by a unique renter number';
    
ALTER TABLE loan ADD CONSTRAINT loan_pk PRIMARY KEY (garage_code,vunit_id,loan_date_time);


--ADDING RESERVE TABLE--
CREATE TABLE reserve (
    garage_code                 NUMBER(2) NOT NULL,
    vunit_id                    NUMBER(6) NOT NULL,
    reserve_date_time_placed    DATE NOT NULL,
    renter_no                   NUMBER(6) NOT NULL
    
);

COMMENT ON COLUMN reserve.garage_code IS
    'unique garage code';
COMMENT ON COLUMN reserve.vunit_id IS
    'garrage-assigned local id number (repeated at each garage)';
COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'date and time on which the reserve was placed';
COMMENT ON COLUMN reserve.renter_no IS
    'renter is identified by a unique renter number';
    
ALTER TABLE reserve ADD CONSTRAINT reserve_pk PRIMARY KEY (garage_code,vunit_id,reserve_date_time_placed);



---------- ALTER FKS ---------

--added--
ALTER TABLE vehicle_unit
    ADD CONSTRAINT garage_vu FOREIGN KEY ( garage_code )
    REFERENCES garage ( garage_code );

ALTER TABLE vehicle_unit
    ADD CONSTRAINT vehicledetail_vu FOREIGN KEY ( vehicle_insurance_id )
    REFERENCES vehicle_detail ( vehicle_insurance_id );

ALTER TABLE loan
    ADD CONSTRAINT vehicleunit_loan FOREIGN KEY ( garage_code, vunit_id )
    REFERENCES vehicle_unit ( garage_code, vunit_id );
    
ALTER TABLE loan
    ADD CONSTRAINT renter_loan FOREIGN KEY ( renter_no )
    REFERENCES renter ( renter_no );
    
ALTER TABLE reserve
    ADD CONSTRAINT vu_reserve FOREIGN KEY ( garage_code, vunit_id )
    REFERENCES vehicle_unit ( garage_code, vunit_id );
    
ALTER TABLE reserve
    ADD CONSTRAINT renter_reserve FOREIGN KEY ( renter_no )
    REFERENCES renter ( renter_no );
    
/*
TASK 1.2 BELOW
*/

DROP TABLE vendor PURGE;

DROP TABLE vendor_vehicle PURGE;

DROP TABLE vehicle_feature PURGE;

DROP TABLE vehicle_detail PURGE;

DROP TABLE renter PURGE;

DROP TABLE garage PURGE;

DROP TABLE manager PURGE;

DROP TABLE manufacturer PURGE;

DROP TABLE feature PURGE;

DROP TABLE vehicle_unit PURGE;

DROP TABLE loan PURGE;

DROP TABLE reserve PURGE;

--Q2
/*
TASK 2.1 BELOW
*/
    
INSERT INTO 
    vehicle_detail
VALUES (
    'sports-ute-449-12b' , 
    'Toyota Hilux SR Manual 4x2 MY14' ,
    'M' ,
    200.00 ,
    TO_DATE('2018','YYYY') ,
    '',
    (SELECT
        manufacturer_id
    FROM
        manufacturer
    WHERE
        manufacturer_name='Toyota'));

--UPON INSERTING THE NEW VEHICLES INTO THE VEHICLE_DETAIL, THE NECCESSARY VALUES ARE ALSO 
--ADDED RESPECITVELY FOR THE VENDOR_VEHICLE TABLE AND VEHICLE_FEATURE TABLE.
INSERT INTO vendor_vehicle VALUES ('sports-ute-449-12b', 1);

INSERT INTO vendor_vehicle VALUES ('sports-ute-449-12b', 2);

INSERT INTO vehicle_feature VALUES ((SELECT feature_code FROM feature WHERE feature_details='metallic silver'),'sports-ute-449-12b');

INSERT INTO vehicle_feature VALUES ((SELECT feature_code FROM feature WHERE feature_details='aluminium tray'),'sports-ute-449-12b');


--NOW INSERT TO VEHICLE_UNIT TABLE
INSERT INTO vehicle_unit VALUES (
    (SELECT
        garage_code
    FROM
        garage
    WHERE
        garage_email='caulfield@rdbms.example.com'),
    1,
    50000.00,
    'R',
    'sports-ute-449-12b',
    'RD3161');
--UPDATE THE VEHICLE COUNT
UPDATE garage
    SET garage_count_vehicles = ((SELECT garage_count_vehicles FROM garage WHERE garage_email='caulfield@rdbms.example.com')+1)
    WHERE garage_email='caulfield@rdbms.example.com';


INSERT INTO vehicle_unit VALUES (
    (SELECT
        garage_code
    FROM
        garage
    WHERE
        garage_email='southy@rdbms.example.com'),
    1,
    50000.00,
    'R',
    'sports-ute-449-12b',
    'RD3141');
--UPDATE THE VEHICLE COUNT
UPDATE garage
    SET garage_count_vehicles = ((SELECT garage_count_vehicles FROM garage WHERE garage_email='southy@rdbms.example.com')+1)
    WHERE garage_email='southy@rdbms.example.com';


INSERT INTO vehicle_unit VALUES (
    (SELECT
        garage_code
    FROM
        garage
    WHERE
        garage_email='melbournec@rdbms.example.com'),
    1,
    50000.00,
    'R',
    'sports-ute-449-12b',
    'RD3000');
--UPDATE VEHICLE COUNT
UPDATE garage
    SET garage_count_vehicles = ((SELECT garage_count_vehicles FROM garage WHERE garage_email='melbournec@rdbms.example.com')+1)
    WHERE garage_email='melbournec@rdbms.example.com';

COMMIT;

/*
TASK 2.2 BELOW
*/

CREATE SEQUENCE renter_renter_no_SEQ START WITH 10 INCREMENT BY 1;

/*
TASK 2.3 BELOW
*/
DROP SEQUENCE renter_renter_no_SEQ;


--Q3
/*
TASK 3.1 BELOW
*/
INSERT INTO renter VALUES (renter_renter_no_SEQ.NEXTVAL,
                        'Van',
                        'DIESEL',
                        'Alfred St',
                        'Caulfield',
                        3162,
                        'vandiesel@monashmail.example.com',
                        05356668222,
                        (SELECT
                            garage_code
                        FROM
                            garage
                        WHERE
                            garage_name='Caulfield VIC'));

COMMIT;


/*
TASK 3.2 BELOW
*/

INSERT INTO reserve VALUES ((SELECT  vehicle_unit.garage_code FROM vehicle_unit JOIN garage ON vehicle_unit.garage_code=garage.garage_code WHERE garage.garage_name='Melbourne Central VIC' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                            (SELECT  vehicle_unit.vunit_id FROM vehicle_unit JOIN garage ON vehicle_unit.garage_code=garage.garage_code WHERE garage.garage_name='Melbourne Central VIC' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                            (TO_DATE('2019/05/04 4:00:00','YYYY/MM/DD HH:MI:SS')),
                            (SELECT renter_no FROM renter WHERE renter_fname='Van' AND renter_lname='DIESEL'));
                               
COMMIT;                  
                            
/*
TASK 3.3 BELOW
*/

INSERT INTO loan VALUES ((SELECT DISTINCT reserve.garage_code FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                        (SELECT DISTINCT reserve.vunit_id FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                        (TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24), 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS')),
                        (TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24)+7, 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS')),
                        (TO_DATE(null)),
                        (SELECT renter_no FROM renter WHERE renter_fname='Van' AND renter_lname='DIESEL'));
                            
COMMIT;

/*
TASK 3.4 BELOW
*/

--UPDATE SINCE VEHICLE IS RETURNED. WHEN RENEWING THE RENTAL, A NEW RENTAL IS CREATED (as per the business rules).
UPDATE loan
    SET loan_actual_return_date = (TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24)+7, 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS'))
    WHERE garage_code=(SELECT DISTINCT reserve.garage_code FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b')
    AND
    vunit_id=(SELECT DISTINCT reserve.vunit_id FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b')
    AND
    loan_date_time=(TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24), 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS'));

--ADD THE RENEWAL OF THE RENTAL AS NEW RENTAL.
INSERT INTO loan VALUES ((SELECT DISTINCT reserve.garage_code FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                        (SELECT DISTINCT reserve.vunit_id FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),
                        (SELECT loan_due_date FROM loan WHERE loan_date_time=(TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24), 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS'))),
                        (SELECT loan_due_date+7 FROM loan WHERE loan_date_time=(TO_DATE((SELECT TO_CHAR(reserve_date_time_placed+7-(2/24), 'YYYY/MM/DD hh:mi:ss') FROM renter JOIN reserve on renter.renter_no=reserve.renter_no JOIN vehicle_unit on vehicle_unit.garage_code=reserve.garage_code WHERE renter.renter_fname='Van' AND renter.renter_lname='DIESEL' AND vehicle_unit.vehicle_insurance_id='sports-ute-449-12b'),'YYYY/MM/DD HH:MI:SS'))),
                        (TO_DATE(null)),
                        (SELECT renter_no FROM renter WHERE renter_fname='Van' AND renter_lname='DIESEL'));
        
COMMIT;      

--Q4
/*
TASK 4.1 BELOW
*/

--SET THE DEFAULT VALUE AS 'G' SINCE 'all existing vehicle units will be
--recorded as being good'.
ALTER TABLE vehicle_unit
ADD maintenance_status CHAR(1) DEFAULT ('G') NOT NULL;

--ADD A CHECK CONSTRAINT TO MAKE SURE THE VALUES ARE EITHER 'M','W','G'.
ALTER TABLE vehicle_unit
    ADD CONSTRAINT maintenance_status_chk CHECK ( maintenance_status IN (
        'M',
        'W',
        'G'
    ) );

/*
TASK 4.2 BELOW
*/

--ADD NEW COLUMN TO SHOW THE RETURNED_GARAGE_CODE.
ALTER TABLE loan ADD returned_garage_code NUMBER(2) NULL;





--UPDATE THIS SO THAT FOR ALL COMPLETED RENTALS TO THIS TIME, VEHICLE UNITS WERE
--RETURNED AT THE SAME GARAGE FROM WHERE THOSE WERE LOANED.
UPDATE loan
SET returned_garage_code=(SELECT
                            garage_code
                          FROM
                            loan
                          WHERE
                            loan_actual_return_date IS NOT NULL)
WHERE loan_actual_return_date IS NOT NULL;

/*
TASK 4.3 BELOW
*/

--CREATE A NEW TABLE. (ESENTIALLY CREATING A BRIDGING ENTITY).
CREATE TABLE manager_allocation (
    garage_code         NUMBER(2) NOT NULL,
    man_id              NUMBER(2) NOT NULL,
    collections         CHAR(1) NOT NULL
);

--CHECK CONSTRAINT FOR COLLECTIONS, IT CAN EITHER BE 'B', 'M', 'S' - (bike, motorcar, sportscar).
ALTER TABLE manager_allocation
    ADD CONSTRAINT collections_chk CHECK ( collections IN (
        'B',
        'M',
        'S'
    ) );


COMMENT ON COLUMN manager_allocation.garage_code IS
    'unique garage code identifier';

COMMENT ON COLUMN manager_allocation.man_id IS
    'unique manager identifier';
    
COMMENT ON COLUMN manager_allocation.collections IS
    'the collections in that garage that the manager is responsible for';

--SET THE PRIMARY KEYS FOR THIS NEW TABLE.
ALTER TABLE manager_allocation ADD CONSTRAINT mngr_allocation_pk PRIMARY KEY ( garage_code, man_id, collections );



--NOW, DROP THE EXISTING RELATIONSHIP BETWEEN THE 'manager' AND ' 'garage' tables.
ALTER TABLE garage DROP CONSTRAINT manager_garage;

--CREATE THE NEW RELATIONSHIP BETWEEN THE NEW TABLE ('manager_allocation') and 'garage' table.
ALTER TABLE manager_allocation
    ADD CONSTRAINT garage_manager_allocation FOREIGN KEY ( garage_code )
        REFERENCES garage ( garage_code );

--CREATE ANOTHER NEW RELATIONSHIP BETWEEN THE NEW TABLE ('manager_allocation') and 'manager' table.
ALTER TABLE manager_allocation
    ADD CONSTRAINT manager_manager_allocation FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id );

--NOW ADD THE NEW VALUES TO THE NEW TABLE FOR THE NEW YEAR.

--Robert (manager id: 1) asked to manage Sportscar collection of Melbrourne Garage.                                         
INSERT INTO manager_allocation VALUES ((SELECT garage_code FROM garage WHERE garage_email='melbournec@rdbms.example.com'),
                                        1,
                                        'S');

--Robert (manager id: 2) asked to manage Bike and Motorcar collection of Melbrourne Garage.                                         
INSERT INTO manager_allocation VALUES ((SELECT garage_code FROM garage WHERE garage_email='melbournec@rdbms.example.com'),
                                        2,
                                        'B');
                                        
INSERT INTO manager_allocation VALUES ((SELECT garage_code FROM garage WHERE garage_email='melbournec@rdbms.example.com'),
                                        2,
                                        'M');
COMMIT;


--IMPORTANT!!! RUN CODE BELOW FIRST TO DROP NEW CONSTRANT AND TABLES BEFORE DROPPING
--             OTHER TABLES.
ALTER TABLE manager_allocation DROP CONSTRAINT garage_manager_allocation;
ALTER TABLE manager_allocation DROP CONSTRAINT manager_manager_allocation;
DROP TABLE manager_allocation PURGE;


--END OF SOLUTION