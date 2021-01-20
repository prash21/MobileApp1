-- FIT2094_FIT3171_A2_SCHEMA Start SQL FILE --
-- V2 20190513 MK - (C) 2019 FIT UNDERGRADUATE DATABASE TEACHING TEAM. ALL COPYRIGHT RESERVED. --
-- STUDENTS SHOULD NOT MODIFY THIS FILE --

---------- VENDOR -----------
CREATE TABLE vendor (
    vendor_id         NUMBER(4) NOT NULL,
    vendor_name       VARCHAR2(80) NOT NULL,
    vendor_category   CHAR(1) NOT NULL
);

ALTER TABLE vendor
    ADD CONSTRAINT vendor_category_chk CHECK ( vendor_category IN (
        'D',
        'M',
        'T'
    ) );

COMMENT ON COLUMN vendor.vendor_id IS
    'Vendor identifier';

COMMENT ON COLUMN vendor.vendor_name IS
    'Author first name';

COMMENT ON COLUMN vendor.vendor_category IS
    'Vendor category flag - D=Dealership who sold the vehicle, M=Mechanics who service/repair the vehicle, and T=Tuners who modify/tune the vehicle including any additions'
    ;

ALTER TABLE vendor ADD CONSTRAINT vendor_pk PRIMARY KEY ( vendor_id );




---------- VENDOR-VEHICLE ----------
CREATE TABLE vendor_vehicle (
    vehicle_insurance_id   VARCHAR2(20) NOT NULL,
    vendor_id              NUMBER(4) NOT NULL
);

COMMENT ON COLUMN vendor_vehicle.vehicle_insurance_id IS
    'Vehicle insurance identifier - identifies a vehicle type as determined by insurer';

COMMENT ON COLUMN vendor_vehicle.vendor_id IS
    'Vendor identifier';

ALTER TABLE vendor_vehicle ADD CONSTRAINT vendor_vehicle_pk PRIMARY KEY ( vendor_id,
                                                                          vehicle_insurance_id );



---------- VEHICLE-FEATURE ----------
CREATE TABLE vehicle_feature (
    feature_code           NUMBER(4) NOT NULL,
    vehicle_insurance_id   VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN vehicle_feature.feature_code IS
    'Feature Identifier';

COMMENT ON COLUMN vehicle_feature.vehicle_insurance_id IS
    'Vehicle insurance identifier - identifies a vehicle type as determined by insurer';

ALTER TABLE vehicle_feature ADD CONSTRAINT vehicle_feature_pk PRIMARY KEY ( feature_code,
                                                                            vehicle_insurance_id );


---------- VEHICLE_DETAIL ----------
CREATE TABLE vehicle_detail (
    vehicle_insurance_id       VARCHAR2(20) NOT NULL,
    vehicle_title              VARCHAR2(100) NOT NULL,
    vehicle_classification     CHAR(1) NOT NULL,
    vehicle_weekly_rental      NUMBER(5, 2) NOT NULL,
    vehicle_manufacture_year   DATE NOT NULL,
    vehicle_engine_capacity    NUMBER(3, 1),
    manufacturer_id            NUMBER(4) NOT NULL
);

ALTER TABLE vehicle_detail
    ADD CONSTRAINT v_classif_chk CHECK ( vehicle_classification IN (
        'B',
        'M',
        'S'
    ) );

COMMENT ON COLUMN vehicle_detail.vehicle_insurance_id IS
    'Vehicle insurance identifier - identifies a vehicle type as determined by insurer';

COMMENT ON COLUMN vehicle_detail.vehicle_title IS
    'Title (e.g. ‘Mazda MX-5 Miata Convertible Roadster’ or ‘Santa Cruz V10 Carbon CC X01 Racing Bicycle’)';

COMMENT ON COLUMN vehicle_detail.vehicle_classification IS
    'Vehicle classification - (B)ike, regular (M)otorcar, or (S)portscar';

COMMENT ON COLUMN vehicle_detail.vehicle_weekly_rental IS
    'Fixed weekly rental price';

COMMENT ON COLUMN vehicle_detail.vehicle_manufacture_year IS
    'Manufacture year';

COMMENT ON COLUMN vehicle_detail.vehicle_engine_capacity IS
    'Vehicle engine capacity in Litre - e.g. 1.5 or 4.0';

COMMENT ON COLUMN vehicle_detail.manufacturer_id IS
    'RDBMS company assigned manufacturer identifier';

ALTER TABLE vehicle_detail ADD CONSTRAINT vehicle_detail_pk PRIMARY KEY ( vehicle_insurance_id );



---------- RENTER ----------
CREATE TABLE renter (
    renter_no         NUMBER(6) NOT NULL,
    renter_fname      VARCHAR2(59) NOT NULL,
    renter_lname      VARCHAR2(50) NOT NULL,
    renter_street     VARCHAR2(80) NOT NULL,
    renter_suburb     VARCHAR2(50) NOT NULL,
    renter_postcode   CHAR(4) NOT NULL,
    renter_email      VARCHAR2(50) NOT NULL,
    renter_mobile     CHAR(10) NOT NULL,
    garage_code       NUMBER(2) NOT NULL
);

COMMENT ON COLUMN renter.renter_no IS
    'Renter identifier';

COMMENT ON COLUMN renter.renter_fname IS
    'Renter first name';

COMMENT ON COLUMN renter.renter_lname IS
    'Renters last name';

COMMENT ON COLUMN renter.renter_street IS
    'Renter street address';

COMMENT ON COLUMN renter.renter_suburb IS
    'Renter suburb';

COMMENT ON COLUMN renter.renter_postcode IS
    'Renter postcode';

COMMENT ON COLUMN renter.renter_email IS
    'Renter email';

COMMENT ON COLUMN renter.renter_mobile IS
    'Renter mobile, 10 digits';

COMMENT ON COLUMN renter.garage_code IS
    'Garage number ';

ALTER TABLE renter ADD CONSTRAINT renter_pk PRIMARY KEY ( renter_no );




---------- GARAGE ----------
CREATE TABLE garage (
    garage_code             NUMBER(2) NOT NULL,
    garage_name             VARCHAR2(50) NOT NULL,
    garage_address          VARCHAR2(100) NOT NULL,
    garage_contact_no       CHAR(10) NOT NULL,
    garage_email            VARCHAR2(50) NOT NULL,
    garage_count_vehicles   NUMBER(5) NOT NULL,
    man_id                  NUMBER(2) NOT NULL
);

COMMENT ON COLUMN garage.garage_code IS
    'Garage number ';

COMMENT ON COLUMN garage.garage_name IS
    'Name of Garage';

COMMENT ON COLUMN garage.garage_address IS
    'Address of Garage';

COMMENT ON COLUMN garage.garage_contact_no IS
    'Garage Phone Number';

COMMENT ON COLUMN garage.garage_email IS
    'Garage Email';

COMMENT ON COLUMN garage.garage_count_vehicles IS
    'Count of vehicles held by the garage';

COMMENT ON COLUMN garage.man_id IS
    'Managers assigned identifier';

ALTER TABLE garage ADD CONSTRAINT garage_pk PRIMARY KEY ( garage_code );

ALTER TABLE garage ADD CONSTRAINT garage_email_uq UNIQUE ( garage_email );




---------- MANAGER ----------
CREATE TABLE manager (
    man_id           NUMBER(2) NOT NULL,
    man_fname        VARCHAR2(50) NOT NULL,
    man_lname        VARCHAR2(50) NOT NULL,
    man_contact_no   CHAR(10) NOT NULL
);

COMMENT ON COLUMN manager.man_id IS
    'Managers assigned identifier';

COMMENT ON COLUMN manager.man_fname IS
    'Managers first name';

COMMENT ON COLUMN manager.man_lname IS
    'Managers Last name';

COMMENT ON COLUMN manager.man_contact_no IS
    'Managers contact number';

ALTER TABLE manager ADD CONSTRAINT manager_pk PRIMARY KEY ( man_id );



---------- MANUFACTURER ----------
CREATE TABLE manufacturer (
    manufacturer_id        NUMBER(4) NOT NULL,
    manufacturer_name      VARCHAR2(50) NOT NULL,
    manufacturer_city      VARCHAR2(50) NOT NULL,
    manufacturer_state     VARCHAR2(50) NOT NULL,
    manufacturer_country   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN manufacturer.manufacturer_id IS
    'RDBMS company assigned manufacturer identifier';

COMMENT ON COLUMN manufacturer.manufacturer_name IS
    'Manufacturer name';

COMMENT ON COLUMN manufacturer.manufacturer_city IS
    'Manufacturer city';

COMMENT ON COLUMN manufacturer.manufacturer_state IS
    'Manufacturer state';

COMMENT ON COLUMN manufacturer.manufacturer_country IS
    'Manufacturer country';

ALTER TABLE manufacturer ADD CONSTRAINT manufacturer_pk PRIMARY KEY ( manufacturer_id );

ALTER TABLE manufacturer ADD CONSTRAINT manufacturer_name_uq UNIQUE ( manufacturer_name );



---------- FEATURE ----------
CREATE TABLE feature (
    feature_code      NUMBER(4) NOT NULL,
    feature_details   VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN feature.feature_code IS
    'Feature Identifier';

COMMENT ON COLUMN feature.feature_details IS
    'Feature description e.g. spoilers, paint etc';

ALTER TABLE feature ADD CONSTRAINT feature_pk PRIMARY KEY ( feature_code );

ALTER TABLE feature ADD CONSTRAINT feature_details_uq UNIQUE ( feature_details );





---------- TABLES ARE MISSING HERE ----------
------
-----
----
---
--
-- STUDENTS SHOULD NOT MODIFY THIS FILE --


---------- ALTER FKS ---------
ALTER TABLE vendor_vehicle
    ADD CONSTRAINT vehicledetail_vv FOREIGN KEY ( vehicle_insurance_id )
        REFERENCES vehicle_detail ( vehicle_insurance_id );
ALTER TABLE vendor_vehicle
    ADD CONSTRAINT vendor_vv FOREIGN KEY ( vendor_id )
        REFERENCES vendor ( vendor_id );

ALTER TABLE vehicle_feature
    ADD CONSTRAINT vehicledetail_vf FOREIGN KEY ( vehicle_insurance_id )
        REFERENCES vehicle_detail ( vehicle_insurance_id );
ALTER TABLE vehicle_feature
    ADD CONSTRAINT feature_vf FOREIGN KEY ( feature_code )
        REFERENCES feature ( feature_code );

ALTER TABLE renter
    ADD CONSTRAINT garage_renter FOREIGN KEY ( garage_code )
        REFERENCES garage ( garage_code );

ALTER TABLE garage
    ADD CONSTRAINT manager_garage FOREIGN KEY ( man_id )
        REFERENCES manager ( man_id );

ALTER TABLE vehicle_detail
    ADD CONSTRAINT manufacturer_vdetail FOREIGN KEY ( manufacturer_id )
        REFERENCES manufacturer ( manufacturer_id );



---------- ALTERS ARE MISSING HERE ----------
------
-----
----
---
--
-- STUDENTS SHOULD NOT MODIFY THIS FILE --