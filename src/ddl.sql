DROP TABLE IF EXISTS  person, users, parent, staff, internal_staff,
    external_staff, staff_presence, building, room, activity, event,
    room_logs, building_logs, participate, subscribe, child;

DROP TYPE IF EXISTS gender, contract_type, staff_function, room_type, school_level;

CREATE TYPE gender AS ENUM (
    'HOMME',
    'FEMME'
    );

CREATE TABLE IF NOT EXISTS person(
    person_id SERIAL UNIQUE,
    person_fname VARCHAR NOT NULL,
    person_lname VARCHAR NOT NULL,
    person_gender gender NOT NULL,
    person_birth_date DATE NOT NULL CHECK ( person_birth_date < CURRENT_DATE ),
    PRIMARY KEY (person_id)
);

CREATE TABLE IF NOT EXISTS users(
    user_id SERIAL UNIQUE,
    user_login VARCHAR NOT NULL UNIQUE,
    user_passwd VARCHAR NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS parent(
    parent_id SERIAL UNIQUE,
    parent_email VARCHAR NOT NULL,
    parent_phone CHAR(10) NOT NULL,
    parent_job VARCHAR NULL,
    parent_address VARCHAR NOT NULL,
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES users(user_id)
);


CREATE TYPE school_level AS ENUM(
    'CP', 'CE1', 'CE2', 'CM1', 'CM2', '6M',
    '5M', '4M', '3M', 'SECONDE', 'PREMIERE', 'TERMINAL'
    );

CREATE TABLE IF NOT EXISTS child(
    child_id SERIAL UNIQUE,
    child_school_level school_level NULL,
    parent_id INT NOT NULL,
    PRIMARY KEY (child_id),
    FOREIGN KEY (child_id) REFERENCES person(person_id),
    FOREIGN KEY (parent_id) REFERENCES parent(parent_id)
);

CREATE TYPE contract_type AS ENUM(
    'CDI', 'CDD', 'Intérimaire'
    );

CREATE TABLE IF NOT EXISTS staff(
    staff_id SERIAL UNIQUE,
    staff_email VARCHAR NOT NULL UNIQUE,
    staff_phone CHAR(10) NOT NULL UNIQUE,
    staff_contract_type contract_type NOT NULL,
    PRIMARY KEY (staff_id),
    FOREIGN KEY (staff_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS external_staff(
    ex_staff_id SERIAL UNIQUE,
    ex_staff_origin VARCHAR NOT NULL,
    ex_staff_job VARCHAR NULL,
    PRIMARY KEY (ex_staff_id),
    FOREIGN KEY (ex_staff_id) REFERENCES staff(staff_id)
);

CREATE TYPE staff_function AS ENUM(
    'Directeur', 'Secrétaire', 'Employé'
    );

CREATE TABLE IF NOT EXISTS internal_staff(
    int_staff_id SERIAL UNIQUE,
    int_staff_hr_number INT NOT NULL UNIQUE,
    int_staff_function staff_function NOT NULL,
    int_address VARCHAR NOT NULL,
    PRIMARY KEY (int_staff_id),
    FOREIGN KEY (int_staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS activity(
    activity_id SERIAL UNIQUE,
    activity_name VARCHAR NOT NULL,
    activity_description TEXT NOT NULL,
    activity_min_age INT NOT NULL CHECK ( activity_min_age > 1 ),
    activity_price FLOAT NOT NULL CHECK ( activity_price >= 0 ),
    staff_id INT NOT NULL,
    PRIMARY KEY (activity_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS building(
    building_id SERIAL UNIQUE,
    building_name CHAR(1) NOT NULL,
    building_address VARCHAR(50) NOT NULL,
    building_nb_floors INT NOT NULL CHECK ( building_nb_floors >= 1 ),
    building_has_elevator BOOLEAN NULL,
    PRIMARY KEY (building_id)
);
CREATE TYPE room_type AS ENUM(
    'Amphi', 'Salle', 'Atelier'
);

CREATE TABLE IF NOT EXISTS room(
    room_id SERIAL UNIQUE,
    room_name CHAR(1) NOT NULL,
    room_floor INT NOT NULL CHECK ( room_floor >= 0 ),
    room_number INT NOT NULL CHECK ( room_number >=0 ),
    room_type room_type NOT NULL,
    room_capacity INT NOT NULL CHECK ( room_capacity > 1 ),
    building_id INT NOT NULL,
    PRIMARY KEY (room_id),
    FOREIGN KEY (building_id) REFERENCES building(building_id)
);

CREATE TABLE IF NOT EXISTS event(
    event_id SERIAL UNIQUE,
    event_date DATE NOT NULL CHECK ( event.event_date > '12-12-1999' ),
    event_start_time TIME NOT NULL,
    event_duration TIME NOT NULL,
    event_max_participant INT NOT NULL,
    room_id INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (event_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);

CREATE TABLE IF NOT EXISTS staff_presence(
    staff_pres_id SERIAL UNIQUE,
    staff_pres_date DATE NOT NULL,
    staff_pres_start_time TIME NOT NULL,
    staff_pres_end_time TIME NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY (staff_pres_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS building_logs(
    person_id INT NOT NULL,
    building_id INT NOT NULL,
    bl_date DATE NOT NULL,
    bl_status BOOL NOT NULL,
    PRIMARY KEY (person_id, building_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (building_id) REFERENCES building(building_id)
);

CREATE TABLE IF NOT EXISTS room_logs(
    room_id INT NOT NULL,
    person_id INT NOT NULL,
    rl_date DATE NOT NULL,
    rl_status BOOL NOT NULL,
    PRIMARY KEY (room_id, person_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS participate(
    person_id INT NOT NULL,
    event_id INT NOT NULL,
    PRIMARY KEY (person_id, event_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (event_id) REFERENCES  event(event_id)
);

CREATE TABLE IF NOT EXISTS subscribe(
    person_id INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (person_id, activity_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (activity_id) REFERENCES  activity(activity_id)
);


