/* Populate database with sample data. */
USE VET_CLINIC;
INSERT INTO animals (name, date_of_birth, escape_attempts,neutered,weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23),('Gabumon', '2018-11-15', 2, true, 8.00),('Pikachu', '2021-01-07', 1, false, 15.04),('Devimon', '2017-05-12', 5, true, 11.00);

/* Vet clinic database: query and update animals table */
-- Insert data
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, -11.0),('Plantmon', '2021-11-15', 2, true, -5.7),('Squirtle', '1993-04-02', 3, false, -12.13),('Angemon', '2005-06-12', 1, true, -45.0),('Boarmon', '2005-06-07', 7, true, 20.4),('Blossom', '1998-10-13', 3, true, 17.0),('Ditto', '2022-05-14', 4, true, 22.0);


-- Vet clinic database: query multiple tables
-- Insert the following data into the owners table:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),('Jennifer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),('Jodie Whittaker', 38);
-- Insert the following data into the species table:
INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

-- Modify your inserted animals so it includes the species_id value:
UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1) ELSE (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1) END), owner_id = (CASE WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith' LIMIT 1) WHEN name = 'Gabumon' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1) WHEN name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1) WHEN name = 'Devimon' THEN (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1) WHEN name = 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1) WHEN name = 'Charmander' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1) WHEN name = 'Squirtle' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1) WHEN name = 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1) WHEN name = 'Angemon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1) WHEN name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1) END);