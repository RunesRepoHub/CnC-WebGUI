CREATE DATABASE IF NOT EXISTS `machines` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GO
USE `machines`;
GO
CREATE TABLE `info` (
  `machine_id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `ip_address` varchar(255) NOT NULL DEFAULT '',
  `mac_address` varchar(255) NOT NULL DEFAULT '',
  `disto` varchar(255) NOT NULL DEFAULT '',
  `packages` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
GO
ALTER TABLE `info`
  ADD PRIMARY KEY (`machine_id`);
GO
ALTER TABLE `info`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT;
GO
CREATE TABLE `hostnames` (
  `machine_id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
GO
ALTER TABLE `hostnames`
  ADD PRIMARY KEY (`machine_id`);
GO
ALTER TABLE `hostnames`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT;
GO
CREATE TABLE `packages` (
  `machine_id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `package` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
GO
ALTER TABLE `packages`
  ADD PRIMARY KEY (`machine_id`);
GO
ALTER TABLE `packages`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT;
GO
CREATE TABLE `cronjobs` (
  `machine_id` int(11) NOT NULL,
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `cron_jobs_scripts` varchar(255) NOT NULL DEFAULT '',
  `cron_run_time` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
GO
ALTER TABLE `cronjobs`
  ADD PRIMARY KEY (`machine_id`);
GO
ALTER TABLE `cronjobs`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT;
GO