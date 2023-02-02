/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
USE vet_clinic;
CREATE TABLE animals (id BIGSERIAL NOT NULL PRIMARY KEY,name VARCHAR(255) NOT NULL,date_of_birth DATE NOT NULL,escape_attemps INT NOT NULL,neutered BOOLEAN NOT NULL,weight_kg DECIMAL(5,2) NOT NULL);

/* Vet clinic database: query and update animals table */
ALTER TABLE animals ADD COLUMN species varchar(255);


-- Vet clinic database: query multiple tables
-- Create a table named owners
CREATE TABLE owners (id BIGSERIAL NOT NULL PRIMARY KEY, full_name VARCHAR(255), age INTEGER);
-- Create a table named species 
CREATE TABLE species ( id BIGSERIAL NOT NULL PRIMARY KEY, name VARCHAR(255));
-- Modify animals table:
ALTER TABLE animals ADD COLUMN species_id INTEGER, ADD COLUMN owner_id INTEGER, DROP COLUMN species;
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);