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