DROP TABLE IF EXISTS person, "user", parent, staff, internal_staff,
    external_staff, staff_presence, building, room, activity, event,
    room_log, building_log, participate, subscribe, child, organize, propose CASCADE;

DROP TYPE IF EXISTS gender, contract_type, staff_function, room_type, school_level;

CREATE TYPE gender AS ENUM (
    'MALE', 'FEMALE'
);

CREATE TABLE IF NOT EXISTS person(
    person_id SERIAL,
    person_fname VARCHAR(50) NOT NULL CHECK ( person_fname ~ '^[[:upper:]][[:lower:]]+([[:space:]][[:upper:]])?([[:space:]]?[[:upper:]][[:lower:]]+)*$' ),
    person_lname VARCHAR(50) NOT NULL CHECK ( person_lname ~ '^([[:upper:]]+[[:space:]]?)+$' ),
    person_gender VARCHAR(6) NOT NULL CHECK ( person_gender IN ( 'MALE', 'FEMALE' ) ),
    person_birth_date DATE NOT NULL CHECK (person_birth_date < CURRENT_DATE AND person_birth_date > CURRENT_DATE - INTERVAL '150 years'),
    person_access_pin_hash CHAR(64) NOT NULL CHECK ( person_access_pin_hash ~ '^[a-f0-9]{64}$|^[A-F0-9]{64}$' ),
    PRIMARY KEY (person_id)
);

CREATE TABLE IF NOT EXISTS "user"(
    user_id INTEGER,
    user_login VARCHAR(20) NOT NULL UNIQUE CHECK ( user_login ~ '^[[:lower:]][a-z0-9]+$' ),
    user_password_hash CHAR(128) NOT NULL CHECK ( user_password_hash ~ '^[a-f0-9]{128}$|^[A-F0-9]{128}$' ),
    user_password_salt CHAR(10) NOT NULL CHECK ( user_password_salt ~ '^[[:alnum:]]{10}$' ),
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS parent(
    parent_id INTEGER,
    parent_email VARCHAR(320) NOT NULL CHECK ( parent_email ~ '^[\w!#$%&''/*+=?`{|}~^-]+(?:\.[\w!#$%&''/*+=?`{|}~^-]+)*@(?:[a-z0-9-]+\.)+[a-z]{2,6}$' ),
    parent_phone CHAR(10) NOT NULL CHECK ( parent_phone ~ '^0[[:digit:]]{9}$' ),
    parent_job VARCHAR(50) NULL CHECK ( parent_job ~ '^[a-zA-Z-'']+$' ),
    address_street_number INTEGER NOT NULL CHECK ( address_street_number > 0 AND address_street_number < 10000 ),
    address_street_name VARCHAR(50) NOT NULL,
    address_zip_code CHAR(5) NOT NULL CHECK ( address_zip_code ~ '^[0-9]{5}$' ),
    address_city VARCHAR(50) NOT NULL CHECK ( address_city ~ '^[[:upper:]]+$' ),
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES "user"(user_id)
);

CREATE TYPE school_level AS ENUM (
    'YEAR1', 'YEAR2', 'YEAR3', 'YEAR4', 'YEAR5', 'YEAR6',
    'YEAR7', 'YEAR8', 'YEAR9', 'YEAR10', 'YEAR11', 'YEAR12'
);

CREATE TABLE IF NOT EXISTS child(
    child_id INTEGER,
    child_school_level VARCHAR(6) NULL CHECK ( child_school_level IN ( 'YEAR1', 'YEAR2', 'YEAR3', 'YEAR4', 'YEAR5', 'YEAR6', 'YEAR7', 'YEAR8', 'YEAR9', 'YEAR10', 'YEAR11', 'YEAR12' ) ),
    parent_id INTEGER NOT NULL,
    PRIMARY KEY (child_id),
    FOREIGN KEY (child_id) REFERENCES person(person_id),
    FOREIGN KEY (parent_id) REFERENCES parent(parent_id)
);

CREATE TYPE contract_type AS ENUM (
    'PERMANENT', 'TEMPORARY', 'INTERIM', 'SERVICE'
);

CREATE TABLE IF NOT EXISTS staff(
    staff_id INTEGER,
    staff_email VARCHAR(320) NOT NULL UNIQUE CHECK ( staff_email ~ '^[\w!#$%&''/*+=?`{|}~^-]+(?:\.[\w!#$%&''/*+=?`{|}~^-]+)*@(?:[a-z0-9-]+\.)+[a-z]{2,6}$' ),
    staff_phone CHAR(10) NOT NULL UNIQUE CHECK ( staff_phone ~ '^0[[:digit:]]{9}$' ),
    staff_contract_type VARCHAR(9) NOT NULL CHECK ( staff_contract_type IN ( 'PERMANENT', 'TEMPORARY', 'INTERIM', 'SERVICE' ) ),
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id) REFERENCES "user"(user_id)
);

CREATE TABLE IF NOT EXISTS external_staff(
    ex_staff_id INTEGER,
    ex_staff_origin VARCHAR(50) NOT NULL CHECK ( ex_staff_origin ~ '^[a-zA-Z-'']+$' ),
    ex_staff_job VARCHAR(50) NULL CHECK ( ex_staff_job ~ '^[a-zA-Z-'']+$' ),
    PRIMARY KEY (ex_staff_id),
    FOREIGN KEY (ex_staff_id) REFERENCES staff(staff_id)
);

CREATE TYPE staff_function AS ENUM (
    'EXECUTIVE', 'SECRETARY', 'EMPLOYEE'
);

CREATE TABLE IF NOT EXISTS internal_staff(
    int_staff_id INTEGER,
    int_staff_hr_number INTEGER NOT NULL UNIQUE CHECK ( int_staff_hr_number > 0 ),
    int_staff_function VARCHAR(9) NOT NULL CHECK ( int_staff_function IN ( 'EXECUTIVE', 'SECRETARY', 'EMPLOYEE' ) ),
    address_street_number INTEGER NOT NULL CHECK ( address_street_number > 0 AND address_street_number < 10000 ),
    address_street_name VARCHAR(50) NOT NULL,
    address_zip_code CHAR(5) NOT NULL CHECK ( address_zip_code ~ '^[0-9]{5}$'),
    address_city VARCHAR(50) NOT NULL CHECK ( address_city ~ '^[[:upper:]]+$' ),
    PRIMARY KEY (int_staff_id),
    FOREIGN KEY (int_staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS activity(
    activity_id SERIAL,
    activity_name VARCHAR(50) NOT NULL CHECK ( activity_name ~ '^[-''a-zA-Z0-9]+$' ),
    activity_description TEXT NOT NULL,
    activity_min_age INTEGER NOT NULL CHECK (activity_min_age > 1),
    activity_price FLOAT NOT NULL CHECK (activity_price >= 0),
    PRIMARY KEY (activity_id)
);

CREATE TABLE IF NOT EXISTS building(
    building_id SERIAL,
    building_name VARCHAR(20) NOT NULL CHECK ( building_name ~ '^[-''a-zA-Z]+$' ),
    address_street_number INTEGER NOT NULL CHECK ( address_street_number > 0 AND address_street_number < 10000 ),
    address_street_name VARCHAR(50) NOT NULL,
    address_zip_code CHAR(5) NOT NULL CHECK ( address_zip_code ~ '^[[:digit:]]{5}$' ),
    address_city VARCHAR(50) NOT NULL CHECK ( address_city ~ '^[[:upper:]]+$' ),
    building_nb_floors INTEGER NOT NULL CHECK (building_nb_floors >= 0),
    building_has_elevator BOOLEAN NOT NULL,
    PRIMARY KEY (building_id)
);

CREATE TYPE room_type AS ENUM (
    'AMPHITHEATER', 'ROOM', 'WORKSHOP'
);

CREATE TABLE IF NOT EXISTS room(
    room_id SERIAL,
    room_name VARCHAR(20) NOT NULL,
    room_floor INTEGER NOT NULL CHECK (room_floor >= 0 AND room_floor < 500),
    room_number INTEGER NOT NULL CHECK (room_number >= 0),
    room_type VARCHAR(12) NOT NULL CHECK ( room_type IN ( 'AMPHITHEATER', 'ROOM', 'WORKSHOP' ) ),
    room_capacity INTEGER NOT NULL CHECK (room_capacity >= 1 AND room_capacity < 50000),
    building_id INTEGER NOT NULL,
    PRIMARY KEY (room_id),
    FOREIGN KEY (building_id) REFERENCES building(building_id)
);

CREATE TABLE IF NOT EXISTS event(
    event_id SERIAL,
    event_date DATE NOT NULL CHECK (event_date >= CURRENT_DATE),
    event_start_time TIME NOT NULL,
    event_duration TIME NOT NULL,
    event_max_participants INT NOT NULL,
    room_id INTEGER NOT NULL,
    activity_id INTEGER NOT NULL,
    PRIMARY KEY (event_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);

CREATE TABLE IF NOT EXISTS staff_presence(
    staff_pres_id SERIAL,
    staff_pres_date DATE NOT NULL,
    staff_pres_start_time TIME NOT NULL,
    staff_pres_duration TIME NOT NULL,
    staff_id INTEGER NOT NULL,
    PRIMARY KEY (staff_pres_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS building_log(
    bl_id SERIAL,
    person_id INTEGER,
    building_id INTEGER,
    bl_timestamp TIMESTAMP NOT NULL,
    bl_status BOOL NOT NULL,
    PRIMARY KEY (bl_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (building_id) REFERENCES building(building_id)
);

CREATE TABLE IF NOT EXISTS room_log(
    rl_id SERIAL,
    room_id INTEGER,
    person_id INTEGER,
    rl_timestamp TIMESTAMP NOT NULL,
    rl_status BOOL NOT NULL,
    PRIMARY KEY (rl_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS participate(
    person_id INTEGER,
    event_id INTEGER,
    PRIMARY KEY (person_id, event_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (event_id) REFERENCES  event(event_id)
);

CREATE TABLE IF NOT EXISTS subscribe(
    person_id INTEGER,
    activity_id INTEGER,
    PRIMARY KEY (person_id, activity_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (activity_id) REFERENCES  activity(activity_id)
);

CREATE TABLE IF NOT EXISTS organize(
    staff_id INTEGER,
    event_id INTEGER,
    PRIMARY KEY (staff_id, event_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

CREATE TABLE IF NOT EXISTS propose(
    staff_id INTEGER,
    activity_id INTEGER,
    PRIMARY KEY (staff_id, activity_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
)