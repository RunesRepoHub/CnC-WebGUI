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
  git varchar(255),
  wget varchar(255),
  sudo varchar(255),
  python varchar(255),
  python3 varchar(255),
  nettools varchar(255),
  mysql varchar(255),
  libpython varchar(255),
  dockercecli varchar(255),
  dockercomposeplugin varchar(255),
  curl varchar(255),
  containerd varchar(255)
);

-- Create the 'cronjobs' table
CREATE TABLE cronjobs (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  cronjobsscripts text
);
