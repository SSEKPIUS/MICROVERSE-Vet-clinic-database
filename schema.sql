/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
--USE vet_clinic;
\c vet_clinic;
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(5,2) NOT NULL);

/* Vet clinic database: query and update animals table */
ALTER TABLE animals ADD COLUMN species varchar(255);

/* Vet clinic database: query multiple tables */
-- Create a table named owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    full_name VARCHAR(255), 
    age INTEGER);
-- Create a table named species 
CREATE TABLE species ( 
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name VARCHAR(255));
-- Modify animals table:
ALTER TABLE animals ADD COLUMN species_id INTEGER, ADD COLUMN owner_id INTEGER, DROP COLUMN species;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);
ALTER TABLE animals ADD COLUMN species varchar(255);

/* Vet clinic database: add "join table" for visits */
-- Create a table named vets with the following column
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name VARCHAR(255), 
    age INT,
    date_of_graduation DATE);
-- Create a "join table" called specializations to handle this relationship btn species and vets
CREATE TABLE specializations (
    species_id INTEGER REFERENCES species(id), 
    vet_id INTEGER REFERENCES vets(id));
-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. animals and vets
CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals(id), 
    vet_id INTEGER REFERENCES vets(id), 
    date DATE);

\l+
