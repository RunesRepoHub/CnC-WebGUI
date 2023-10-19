-- Create the 'info' table
CREATE TABLE info (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  ipaddress varchar(255),
  macaddress varchar(255),
  distro varchar(255),
  packages varchar(255)
);

-- Create the 'hostnames' table
CREATE TABLE hostnames (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL
);

-- Create the 'packages' table
CREATE TABLE packages (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  packagename text,
  installed text
);

-- Create the 'cronjobs' table
CREATE TABLE cronjobs (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  cronjobsscripts text
);


ALTER TABLE cronjobs
ADD CONSTRAINT unique_hostname_script UNIQUE (hostname, cronjobsscripts);
