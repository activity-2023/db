
INSERT INTO person VALUES (1, 'DANIA', 'OULKADI', 'FEMME', '2002-07-16'),
                          (2, 'THOMAS', 'REMY', 'HOMME', '1998-10-17'),
                          (3, 'AMAYAS', 'TAHAR', 'HOMME', '2010-06-30'),
                          (4, 'JANA', 'SABI', 'FEMME', '2012-03-07'),
                          (5, 'ALICIA', 'DJANI', 'FEMME', '2015-06-30'),
                          (6, 'PIERRE', 'RABHI', 'HOMME', '1989-12-12'),
                          (7, 'FATI', 'HACHEMI', 'FEMME', '1985-5-28'),
                          (8, 'MOHAMED', 'DUMAS', 'HOMME', '1968-8-12');

INSERT INTO users VALUES (1, 'doulkadi', 'h0h0h0h0'),
                         (2, 'tremy', 'a0a0a0a0'),
                         (6, 'prabhi', 'r0r0r0r0'),
                         (7, 'fhachemi', 'f0f0f0f0'),
                         (8, 'mdumas', 'm0m0m0m0');


INSERT INTO parent VALUES (1, 'daniaoulkadi@gmail.com', '0856894523', NULL, '6, Rue de la République, 95000 Cergy'),
                          (2, 'thomasremy@gmail.com', '0523568910', NULL, '6, Rue de la République, 95000 Cergy'),
                          (8, 'mohamdedumas@gmail.com', '0892562565', NULL, '6, Rue de la République, 95000 Cergy');

INSERT INTO child VALUES (3, 'PREMIERE', 1),(4, NULL, 2), (5, 'CM1',1);

INSERT INTO staff VALUES (6,'prahbi@activity.com', '0156859586', 'CDD'), (7, 'fhachemi@activity.com', '0156857586', 'CDI');


INSERT INTO external_staff VALUES (6, 'Entreprise1', NULL );

INSERT INTO internal_staff VALUES (7, 12, 'Employé', '6, Rue de la République, 95000 Cergy');

INSERT INTO activity VALUES (1, 'ATELIER 1', 'Ceci est la description de atelier 1', 8, 0, 6),
                            (2, 'CONFERENCE 1', 'Ceci est la description de la conférence 1', 16, 10, 6),
                            (3, 'REUNION 1', 'Ceci est la description de la reunion 1', 18, 0, 7),
                            (4, 'COURS 1', 'Ceci est la description du cours 1', 4, 20, 7),
                            (5, 'STAGE 1', 'Ceci est la description du stage 1', 18, 50, 6);

INSERT INTO building VALUES (1, 'A', '26, Rue de la République, 75000 Paris', 4, TRUE),
                            (2, 'B', '24, Rue de la République, 75000 Paris', 2, FALSE);


INSERT INTO room VALUES (1, 'a', 1, 25, 'Atelier', 12, 1), (2,'a', 0, 10, 'Amphi', 300, 1 ),
                        (3, 'b', 1, 56, 'Salle', 45, 2), (4, 'a', 2, 20, 'Atelier', 13, 2);

INSERT INTO event VALUES (1, '2023-10-15', '12:45:00', '02:00:00', 10, 1, 1),
                         (2, '2023-10-15', '10:00:00', '03:00:00', 250, 2, 2),
                         (3, '2023-10-15', '14:00:00', '03:00:00', 250, 2, 4),
                         (4, '2023-11-02', '10:00:00', '03:00:00', 30, 3, 4),
                         (5, '2023-12-10', '10:00:00', '03:00:00', 200, 2, 4);
