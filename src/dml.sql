
INSERT INTO person VALUES (1, 'Dania', 'OULKADI', 'FEMALE', '2002-07-16', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (2, 'Thomas', 'REMY', 'MALE', '1998-10-17', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (3, 'Amayas', 'TAHAR', 'MALE', '2010-06-30', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (4, 'Jana', 'SABI', 'FEMALE', '2012-03-07', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (5, 'Alicia', 'DJANI', 'FEMALE', '2015-06-30', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (6, 'Pierre', 'RABHI', 'MALE', '1989-12-12', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (7, 'Fati', 'HACHEMI', 'FEMALE', '1985-5-28', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb'),
                          (8, 'Mohammed', 'DUMAS', 'MALE', '1968-8-12', 'cad6ddf10c7f185baa569652306063313da25e747d9c7c2ce29f5b1d3bd216cb');

INSERT INTO user_account VALUES (1, 'doulkadi', 'd1516002982f64fafc28209615d23c2e617499dc942c61a41c1e7e32e80444c4439f9b546e4eda052aad10dd37a4f4cc956ccf62c712a181cde902706366a0e4', 'gcszduouws'),
                         (2, 'tremy', 'd1516002982f64fafc28209615d23c2e617499dc942c61a41c1e7e32e80444c4439f9b546e4eda052aad10dd37a4f4cc956ccf62c712a181cde902706366a0e4', 'gcszduouws'),
                         (6, 'prabhi', 'd1516002982f64fafc28209615d23c2e617499dc942c61a41c1e7e32e80444c4439f9b546e4eda052aad10dd37a4f4cc956ccf62c712a181cde902706366a0e4', 'gcszduouws'),
                         (7, 'fhachemi', 'd1516002982f64fafc28209615d23c2e617499dc942c61a41c1e7e32e80444c4439f9b546e4eda052aad10dd37a4f4cc956ccf62c712a181cde902706366a0e4', 'gcszduouws'),
                         (8, 'mdumas', 'd1516002982f64fafc28209615d23c2e617499dc942c61a41c1e7e32e80444c4439f9b546e4eda052aad10dd37a4f4cc956ccf62c712a181cde902706366a0e4', 'gcszduouws');


INSERT INTO parent VALUES (1, 'daniaoulkadi@gmail.com', '0856894523', NULL, 6,'Rue de la République', 95000 ,'CERGY'),
                          (2, 'thomasremy@gmail.com', '0523568910', NULL, 6, 'Rue de la monarchi', 95000, 'PARIS'),
                          (8, 'mohamdedumas@gmail.com', '0892562565', NULL, 6, 'Boulvard de la République', 95000,'SAINT DENIS');

INSERT INTO child VALUES (3, 'YEAR2', 1),(4, NULL, 2), (5, 'YEAR4',1);

INSERT INTO staff VALUES (6,'prahbi@activity.com', '0156859586', 'PERMANENT'), (7, 'fhachemi@activity.com', '0156857586', 'INTERIM');

INSERT INTO external_staff VALUES (6, 'Entreprise externe', NULL );

INSERT INTO internal_staff VALUES (7, 12, 'EXECUTIVE',  6, 'Boulvard de la République', 95000,'SAINT DENIS');

INSERT INTO activity VALUES (1, 'ATELIER COUTURE', 'Ceci est la description de couture avec une professionnel', 10, 6),
                            (2, 'CONFERENCE DE PRESS', 'Ceci est la description de la conférence', 16, 10),
                            (3, 'REUNION Administation', 'Ceci est la description de la reunion administration', 18, 0);

INSERT INTO building VALUES (1, 'A', '26','Rue de la République',75000,'PARIS', 4, TRUE),
                            (2, 'B', 24, 'Rue de la République', 75000, 'PARIS', 2, FALSE);


INSERT INTO room VALUES (1, 'a', 1, 25, 'WORKSHOP', 12, 1), (2,'a', 0, 10, 'AMPHITHEATER', 300, 1 ),
                        (3, 'b', 1, 56, 'ROOM', 45, 2), (4, 'a', 2, 20, 'WORKSHOP', 13, 2);

INSERT INTO event VALUES (1, '2023-12-15', '12:45:00', '02:00:00', 10, 1, 1),
                         (2, '2023-12-15', '10:00:00', '03:00:00', 250, 2, 2),
                         (3, '2024-02-02', '14:00:00', '03:00:00', 250, 2, 3),
                         (4, '2023-11-28', '10:00:00', '03:00:00', 30, 3, 3),
                         (5, '2024-12-10', '10:00:00', '03:00:00', 200, 2, 2);


INSERT INTO participate VALUES (2,2),(8,2),(8,4),(3,4);

INSERT INTO subscribe VALUES (1,1),(3,2),(2,2),(1,2);

INSERT INTO organize VALUES (6,1),(6,2),(7,2),(7,5);

INSERT INTO propose VALUES (6,2),(6,3),(7,2);



--- Requêtes select depuis le serveur web

-- Récupération des données de un utilisateur (parent)
SELECT * FROM user_account
    JOIN person
    JOIN parent
        ON person.person_id = parent.parent_id
        ON user_account.user_id = parent.parent_id;

-- Dans le cas d'un compte d'un employee (staff)
SELECT * FROM user_account
    JOIN person
    JOIN staff
        ON person.person_id = staff.staff_id
        ON user_account.user_id = person.person_id;

-- Récupération des informations des enfants sachat l'id du parent (parent_id = 1)
SELECT *
FROM  child c
    JOIN person p ON c.child_id = p.person_id
WHERE (c.parent_id = 1);

-- Personnes liés à un compte pour un compte user_id = 1
SELECT *
FROM person
WHERE (person.person_id IN
       ( SELECT person_id
         FROM person JOIN parent ON person.person_id  = parent.parent_id
         WHERE (parent.parent_id = 1)) OR  person.person_id IN
               (SELECT person_id
                FROM person JOIN child ON person.person_id  = child.child_id
                WHERE (child.parent_id = 1)));

-- Récuperer les activités liées à un compte en sachat l'id de (parent = 1)
SELECT *
FROM activity JOIN subscribe ON activity.activity_id = subscribe.activity_id
WHERE (subscribe.person_id IN
       ( SELECT person_id
         FROM person JOIN parent ON person.person_id  = parent.parent_id
         WHERE (parent.parent_id = 1))  OR  subscribe.person_id IN
                                            (SELECT person_id
                                             FROM person JOIN child ON person.person_id  = child.child_id
                                             WHERE (child.parent_id = 1)));


-- Récuperer les evenements liées à un compte en sachat l'id de (parent = 1)
SELECT *
FROM event JOIN participate ON event.event_id = participate.event_id
WHERE (participate.person_id IN
       ( SELECT person_id
         FROM person JOIN parent ON person.person_id  = parent.parent_id
         WHERE (parent.parent_id = 1)) OR  participate.person_id IN
                                           (SELECT person_id
                                            FROM person JOIN child ON person.person_id  = child.child_id
                                            WHERE (child.parent_id = 1)));

-- Toutes les evenement disponibles pour une activité precise (activity_id = 2)
SELECT *
FROM event JOIN activity ON event.activity_id = activity.activity_id
WHERE (event.event_date >= CURRENT_DATE && event.activity_id = 2);

-- Toutes les événements qu'un staff organise (staff_id = 7) de même pour une activité qu'il rpopose avec 'propose'
SELECT event
FROM staff JOIN organize JOIN event
    ON organize.event_id = event.event_id ON staff.staff_id = organize.staff_id
WHERE staff.staff_id = 7;

-- Nombre de places disponibles pour un événement event_id = 3
SELECT DISTINCT event.event_max_participants - count(person_id) AS nombre_places_dispo, event.event_id FROM participate JOIN event
    ON participate.event_id = event.event_id GROUP BY event.event_id;


SELECT *
FROM event e JOIN room r JOIN participate p
    ON p.event_id = e.event_id ON e.room_id = r.room_id;

-- salle disponibles pour un événement event_id = 2

-- salle avec capacité suffisante pour un événement donné
SELECT *
FROM room JOIN event ON room.room_id = event.room_id
WHERE ( event.event_id = 1 and room_capacity>event_max_participants );

-- voir les salles disponibles pour une journée (2023-12-15) à une heure (15h) et d'une duré de 2h
SELECT DISTINCT room FROM room JOIN event ON room.room_id = event.room_id
         WHERE (event.event_date != '2023-12-15' or event.event_start_time not between '15:00:00' and '17:00:00');

-- Récuperer un internal_staff à traver son numéro RH
SELECT * FROM internal_staff WHERE (int_staff_hr_number = 12);

