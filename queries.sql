/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

--List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01'  and '2019-12-31';

--List the name of all animals that are neutered and have less than 3 escape attemps
SELECT name FROM animals WHERE neutered = true AND escape_attemps < 3 ;

--List the date of birth  of all animals names either "Aguman" or "Pikachu"
SELECT date_of_birth from animals WHERE name IN('Agumon', 'Pikachu');

--List the name of all escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attemps  from animals WHERE weight_kg > 10.5 ;

--Find of all animals that are  neutered
SELECT * FROM animals WHERE neutered = true;

--find  of all animals not named Gabumon 
SELECT * FROM animals WHERE name != 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg(including the animals with that equals precisely 10.4kg or 17.3kg) 
SELECT * FROM  animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Vet clinic database: query and update animals table */
- Update the animals table within a transaction, setting the species column to 'unspecified'
BEGIN;
UPDATE animals SET species = 'unspecified';
-- Verify the change
SELECT * FROM animals;
-- Roll back the transaction
ROLLBACK;
-- Verify that the species columns went back to the state before the transaction
SELECT * FROM animals;

-- Update the animals table within a transaction
BEGIN;
-- Set the species column to 'digimon' for all animals that have a name ending in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
-- Set the species column to 'pokemon' for all animals that don't have a species already set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Commit the transaction
COMMIT;
-- Verify that the changes were made and persist after the commit
SELECT * FROM animals;

--delete all records in the animals table,then roll back the transaction.
BEGIN; 
DELETE FROM animals;
ROLLBACK;
--verify table still exists
SELECT * FROM animals;

--Inside a transaction:
BEGIN; 
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT savepoint;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Rollback to the savepoint
ROLLBACK TO savepoint;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = ABS( weight_kg);
-- Commit transaction
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) as average_escape FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as average_escape FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Vet clinic database: query multiple tables */
-- What animals belong to Melody Pond?
SELECT animals.* FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.*, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name, COUNT(*) as animal_count FROM species JOIN animals ON animals.species_id = species.id GROUP BY species.name;
SELECT species, AVG(escape_attempts) as average_escape FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Vet clinic database: add "join table" for visits */
-- Write queries to answer the following
-- Who was the last animal seen by William Tatcher?
SELECT a.* FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'William Tatcher' ORDER BY v.date DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id) FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name FROM vets v  LEFT JOIN specializations s ON v.id = s.vet_id LEFT JOIN species sp ON sp.id = s.species_id ORDER BY v.name; \gdesc
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.* FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Stephanie Mendez' AND v.date BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT a.*, COUNT(a.id) FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.id ORDER BY COUNT(a.id) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT a.* FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Maisy Smith' ORDER BY v.date LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.*, vt.*, v.date FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id ORDER BY v.date DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)  FROM vets as vt LEFT JOIN visits as vs ON vt.id=vs.vet_id LEFT JOIN animals as a ON a.id=vs.animal_id WHERE a.id!=(SELECT a.id  FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON vt.id = v.vet_id WHERE vt.name = 'Maisy Smith' ORDER BY v.date LIMIT 1);
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS specialse_on FROM visits JOIN vets ON visits.vet_id=vets.id JOIN animals ON visits.animal_id=animals.id JOIN species ON animals.species_id=species.id WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') GROUP BY species.name ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

-- EXPLAIN ANALYZE
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';