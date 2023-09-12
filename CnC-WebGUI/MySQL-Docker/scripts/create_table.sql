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