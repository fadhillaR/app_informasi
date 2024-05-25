-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2024 at 06:11 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_informasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `aliran`
--

CREATE TABLE `aliran` (
  `id_aliran` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `file_ktp` text NOT NULL,
  `isi_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aliran`
--

INSERT INTO `aliran` (`id_aliran`, `id_user`, `file_ktp`, `isi_laporan`, `laporan`, `status_laporan`) VALUES
(1, 2, 'Tugas Membuat ARTIKEL.pdf', 'aliran1edit3', 'Soal UTS.pdf', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `hukum`
--

CREATE TABLE `hukum` (
  `id_hukum` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `file_ktp` text NOT NULL,
  `isi_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hukum`
--

INSERT INTO `hukum` (`id_hukum`, `id_user`, `file_ktp`, `isi_laporan`, `laporan`, `status_laporan`) VALUES
(1, 2, '1173-4009-1-PB.pdf', 'hukum1', 'Soal UTS.pdf', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `jms`
--

CREATE TABLE `jms` (
  `id_jms` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_pemohon` varchar(100) NOT NULL,
  `nama_sekolah` varchar(200) NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jms`
--

INSERT INTO `jms` (`id_jms`, `id_user`, `nama_pemohon`, `nama_sekolah`, `status_laporan`) VALUES
(1, 2, 'tes', 'pnp', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `korupsi`
--

CREATE TABLE `korupsi` (
  `id_korupsi` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `file_ktp` text NOT NULL,
  `isi_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korupsi`
--

INSERT INTO `korupsi` (`id_korupsi`, `id_user`, `file_ktp`, `isi_laporan`, `laporan`, `status_laporan`) VALUES
(2, 2, 'Chapter 4_1 sd 4_10.pdf', 'tes2edit', 'Soal UTS.pdf', 'Rejected'),
(3, 2, 'Modul praktikum 2.pdf', 'tes3edit', '86-178-1-SM.pdf', 'Rejected'),
(4, 2, 'Task 2 Edukasi.pdf', 'tes4e', 'Chapter 4_1 sd 4_10.pdf', 'Pending'),
(6, 2, '1173-4009-1-PB.pdf', 'korupsi1', '796-2513-1-PB.pdf', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `file_ktp` text NOT NULL,
  `isi_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `id_user`, `file_ktp`, `isi_laporan`, `laporan`, `status_laporan`) VALUES
(13, 2, '796-2513-1-PB.pdf', 'tes13', 'Tugas Membuat ARTIKEL.pdf', 'Approved'),
(14, 2, 'Soal UTS.pdf', 'tes14edit', 'jarudo-damanik,+1276-5324-1-LE.pdf', 'Rejected'),
(16, 2, '1173-4009-1-PB.pdf', 'tes2222', '796-2513-1-PB.pdf', 'Approved'),
(19, 2, 'Tugas Membuat ARTIKEL.pdf', 'teswfdsdfsdfsdfds', '796-2513-1-PB.pdf', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `pilkada`
--

CREATE TABLE `pilkada` (
  `id_pilkada` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `file_ktp` text NOT NULL,
  `isi_laporan` text NOT NULL,
  `laporan` text NOT NULL,
  `status_laporan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pilkada`
--

INSERT INTO `pilkada` (`id_pilkada`, `id_user`, `file_ktp`, `isi_laporan`, `laporan`, `status_laporan`) VALUES
(1, 2, 'Tugas Membuat ARTIKEL.pdf', 'pilkada1', '7 - MODUL PENGOLAHAN DAN ANALISIS DATA DENGAN SPSS.pdf', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `id_rating` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `komen` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`id_rating`, `id_user`, `rating`, `komen`) VALUES
(10, 4, 2, 'Cukup'),
(13, 10, 2, 'sad'),
(14, 2, 3, 'tesrating');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nohp` varchar(15) NOT NULL,
  `ktp` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `alamat` text NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nama`, `email`, `nohp`, `ktp`, `password`, `alamat`, `role`) VALUES
(1, 'admin', 'admin@mail.com', '0812518328', '13082392322', '0192023a7bbd73250516f069df18b500', 'bukittinggi', 'admin'),
(2, 'rani', 'rani@mail.com', '08953734832', '13028923822122', '8daed774c333aeac3b87b539f04966b2', 'bukittinggi', 'customer'),
(4, 'dila', 'dila@mail.com', '02321', '12321', '80481217df55271c79ea38840ced0a72', 'bkt', 'customer'),
(10, 'tes', 'tes@mail.com', 'tes', '123123123', 'b93939873fd4923043b9dec975811f66', 'tes', 'Customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aliran`
--
ALTER TABLE `aliran`
  ADD PRIMARY KEY (`id_aliran`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `hukum`
--
ALTER TABLE `hukum`
  ADD PRIMARY KEY (`id_hukum`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `jms`
--
ALTER TABLE `jms`
  ADD PRIMARY KEY (`id_jms`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `korupsi`
--
ALTER TABLE `korupsi`
  ADD PRIMARY KEY (`id_korupsi`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `pilkada`
--
ALTER TABLE `pilkada`
  ADD PRIMARY KEY (`id_pilkada`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aliran`
--
ALTER TABLE `aliran`
  MODIFY `id_aliran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `hukum`
--
ALTER TABLE `hukum`
  MODIFY `id_hukum` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jms`
--
ALTER TABLE `jms`
  MODIFY `id_jms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `korupsi`
--
ALTER TABLE `korupsi`
  MODIFY `id_korupsi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pilkada`
--
ALTER TABLE `pilkada`
  MODIFY `id_pilkada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aliran`
--
ALTER TABLE `aliran`
  ADD CONSTRAINT `aliran_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `hukum`
--
ALTER TABLE `hukum`
  ADD CONSTRAINT `hukum_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `jms`
--
ALTER TABLE `jms`
  ADD CONSTRAINT `jms_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `korupsi`
--
ALTER TABLE `korupsi`
  ADD CONSTRAINT `korupsi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pilkada`
--
ALTER TABLE `pilkada`
  ADD CONSTRAINT `pilkada_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
