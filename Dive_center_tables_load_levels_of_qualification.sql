-- ПРОЕКТ Дайвинг-центр
-- 2.4
-- Данные для таблицы levels_of_qualification, 45

INSERT INTO levels_of_qualification 
	(type_of_qualification,
	name_of_qualification,
	level_of_qualification,
	count_of_dives)
	VALUES
	('beginner', 'Bubblemaker', 1, 5),
	('beginner', 'Scuba diver', 2, 5),
	('freediving', 'Freediver', 1, 5),
	('freediving', 'Advanced freediver', 2, 20),
	('freediving', 'Master freediver', 3, 100),
	('freediving', 'Freediving instructor', 3, 50),
	('freediving', 'Freediving instructor trainer', 4, 200),	
	('recreation diving', 'Open water diver', 1, 10),
	('recreation diving', 'Advanced open water diver', 2, 20),
	('recreation diving', 'Rescue diver', 3, 50),
	('recreation diving', 'Master scuba diver', 4, 100),
	('project AWARE', 'Specialist', 1, 5),
	('specialization', 'Enriched air diver', 1, 5),
	('specialization', 'Digital underwater photographer', 2, 5),
	('specialization', 'Dry suit diver', 3, 10),
	('specialization', 'Deep diver', 4, 10),
	('specialization', 'Underwater navigator', 5, 5),
	('specialization', 'Peak perfomance buoyancy', 6, 10),
	('specialization', 'Wreck diver', 7, 5),
	('specialization', 'Night diver', 8, 5),
	('specialization', 'Search and recovery diver', 9, 5),
	('specialization', 'Drift diver', 10, 5),
	('continue education', 'Equipment specialist', 1, 10),
	('continue education', 'Diver propulsion vehicle', 2, 5),
	('continue education', 'Boat diver', 3, 5),
	('continue education', 'Cavern diver', 4, 50),
	('continue education', 'Sidemount diver', 5, 50),
	('continue education', 'Ice diver', 5, 50),
	('professional', 'Specialty instructor', 1, 300),	
	('professional', 'IDC Staff Instructor', 2, 500),
	('professional', 'Open water scuba instructor', 3, 200),
	('professional', 'Master scuba instructor', 3, 300),
	('professional', 'TEC deep instructor', 3, 100),
	('technical diving', 'Discover technical diving', 1, 10),
	('technical diving', 'TEC sidemount', 2, 10),
	('technical diving', 'TEC 40 CCR', 4, 10),
	('technical diving', 'TEC 60 CCR', 5, 10),
	('technical diving', 'TEC 100 CCR', 6, 10),
	('technical diving', 'TEC instructor', 7, 200),
	('technical diving', 'TEC 40 CCR instructor', 8, 200),
	('technical diving', 'TEC 60 CCR instructor', 9, 200),
	('technical diving', 'TEC 100 CCR instructor', 10, 300),
	('technical diving', 'TEC TRIMIX instructor', 11, 500),
	('professional', 'divemaster', 4, 1000),
	('professional', 'courese director', 5, 1000);
