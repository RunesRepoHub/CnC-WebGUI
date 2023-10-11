-- Create the 'info' table
CREATE TABLE info (
  machineid serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  ipaddress varchar(255) NOT NULL,
  macaddress varchar(255) NOT NULL,
  distro varchar(255) NOT NULL,
  packages varchar(255) NOT NULL
);

-- Create the 'hostnames' table
CREATE TABLE hostnames (
  machineid serial PRIMARY KEY,
  hostname varchar(255) NOT NULL
);

-- Create the 'packages' table
CREATE TABLE packages (
  machine_id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  git varchar(255) NOT NULL,
  wget varchar(255) NOT NULL,
  sudo varchar(255) NOT NULL,
  python varchar(255) NOT NULL,
  python3 varchar(255) NOT NULL,
  nettools varchar(255) NOT NULL,
  mysql varchar(255) NOT NULL,
  libpython varchar(255) NOT NULL,
  dockercecli varchar(255) NOT NULL,
  dockercomposeplugin varchar(255) NOT NULL,
  curl varchar(255) NOT NULL,
  containerd varchar(255) NOT NULL
);

-- Create the 'cronjobs' table
CREATE TABLE cronjobs (
  machineid serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  cronjobsscripts text
);
