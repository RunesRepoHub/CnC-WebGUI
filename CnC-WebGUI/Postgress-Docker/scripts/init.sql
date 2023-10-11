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
  git text,
  wget text,
  sudo text,
  python text,
  python3 text,
  nettools text,
  mysql text,
  libpython text,
  dockercecli text,
  dockercomposeplugin text,
  curl text,
  containerd text
);

-- Create the 'cronjobs' table
CREATE TABLE cronjobs (
  id serial PRIMARY KEY,
  hostname varchar(255) NOT NULL,
  cronjobsscripts text
);
