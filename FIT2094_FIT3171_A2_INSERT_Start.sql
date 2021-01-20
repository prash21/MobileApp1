-- FIT2094_FIT3171_A2_INSERT_Start SQL FILE --
-- V2 20190513 MK - (C) 2019 FIT UNDERGRADUATE DATABASE TEACHING TEAM. ALL COPYRIGHT RESERVED. --
-- STUDENTS SHOULD NOT MODIFY THIS FILE --

-- Sample data for MANAGER table.
INSERT INTO manager VALUES (
    1,
    'Robert',
    'Jones',
    '9999999991'
);

INSERT INTO manager VALUES (
    2,
    'Cat',
    'Mansfield',
    '9999999992'
);



-- Sample data for GARAGE table.
INSERT INTO garage VALUES (
    10,
    'Caulfield VIC',
    '123 Jackson Street, Caulfield, Victoria, 3161',
    '039998881',
    'caulfield@rdbms.example.com',
    50,
    1
);

INSERT INTO garage VALUES (
    11,
    'South Yarra VIC',
    '321 Hume Street, South Yarra, Victoria, 3141',
    '0388888882',
    'southy@rdbms.example.com',
    40,
    2
);

INSERT INTO garage VALUES (
    12,
    'Melbourne Central VIC',
    '45 Swanston Street, Melbourne, Victoria, 3000',
    '0388888883',
    'melbournec@rdbms.example.com',
    450,
    2
);




-- Sample data for MANUFACTURER table.
INSERT INTO manufacturer VALUES (
    1,
    'Toyota',
    'Altona',
    'VIC',
    'Australia'
);

INSERT INTO manufacturer VALUES (
    2,
    'Automobili Lamborghini S.p.A.',
    'Bologna',
    'Emilia-Romagna',
    'Italy'
);

INSERT INTO manufacturer VALUES (
    3,
    'Malvern Star Bicycles',
    'Melbourne',
    'VIC',
    'Australia'
);



-- Sample data for VEHICLE_DETAIL table.
INSERT INTO vehicle_detail VALUES (
    'sports-ute-001-1b',
    'Toyota Hilux Revo',
    'M',
    166.88,
    TO_DATE('2015','YYYY'),
    2.4,
    1
);

INSERT INTO vehicle_detail VALUES (
    'racing-luxury-88888',
    'LP 570-4 Squadra Corse',
    'S',
    999.99,
    TO_DATE('2013','YYYY'),
    5.2,
    2
);



-- Sample data for FEATURE table.
INSERT INTO feature VALUES (
    1,
    'metallic silver'
);

INSERT INTO feature VALUES (
    2,
    'sporty design'
);

INSERT INTO feature VALUES (
    3,
    'sport brakes'
);

INSERT INTO feature VALUES (
    4,
    '3D surround sound'
);

INSERT INTO feature VALUES (
    5,
    'carbon fibre'
);

INSERT INTO feature VALUES (
    6,
    'metallic yellow'
);

INSERT INTO feature VALUES (
    7,
    'basic sound system'
);

INSERT INTO feature VALUES (
    8,
    'sport rims'
);

INSERT INTO feature VALUES (
    9,
    'sunroof'
);

INSERT INTO feature VALUES (
    10,
    'aluminium tray'
);

INSERT INTO feature VALUES (
    11,
    'high spoilers'
);




-- Sample data for VENDOR table.
INSERT INTO vendor VALUES (
    1,
    'Toyota Chadstone',
    'D'
);

INSERT INTO vendor VALUES (
    2,
    '4x4 Mechanical Experts',
    'M'
);

INSERT INTO vendor VALUES (
    3,
    'Doncaster European Luxury Cars',
    'D'
);

INSERT INTO vendor VALUES (
    4,
    'Fancy Car Polishers',
    'M'
);



-- Sample data for VEHICLE_FEATURE table.
INSERT INTO vehicle_feature VALUES (
    4,
    'sports-ute-001-1b'
);

INSERT INTO vehicle_feature VALUES (
    10,
    'sports-ute-001-1b'
);

INSERT INTO vehicle_feature VALUES (
    1,
    'racing-luxury-88888'
);

INSERT INTO vehicle_feature VALUES (
    2,
    'racing-luxury-88888'
);
INSERT INTO vehicle_feature VALUES (
    5,
    'racing-luxury-88888'
);



-- Sample data for VENDOR_VEHICLE table.
INSERT INTO vendor_vehicle VALUES (
    'sports-ute-001-1b',
    1
);

INSERT INTO vendor_vehicle VALUES (
    'sports-ute-001-1b',
    2
);

INSERT INTO vendor_vehicle VALUES (
    'racing-luxury-88888',
    3
);

INSERT INTO vendor_vehicle VALUES (
    'racing-luxury-88888',
    4
);



-- Sample data for RENTER table.
INSERT INTO renter VALUES (
    1,
    'Mark',
    'Zuckerberg',
    '1 Facebook Way',
    'Faceville',
    '10',
    'markz@facebook.example',
    '0400000000',
    10
);

INSERT INTO renter VALUES (
    2,
    'Sergey',
    'Brin',
    '2 Alphabet Way',
    'Alphaville',
    '2000',
    'google@google.example',
    '0422220000',
    11
);

INSERT INTO renter VALUES (
    3,
    'Larry',
    'Page',
    '1 Alphabet Way',
    'Alphaville',
    '2000',
    'googlelarry@google.example',
    '0422221111',
    11
);

INSERT INTO renter VALUES (
    4,
    'Bill',
    'Gates',
    '1 Microsoft Way',
    'Microville',
    '3000',
    'microsoft.melbourne@example.microsoft',
    '0488889999',
    11
);

COMMIT;