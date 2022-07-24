-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2020 at 01:04 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dro`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `ADMIN_ID` int(8) NOT NULL,
  `PATIENT_ID` int(8) NOT NULL,
  `CLINIC_ID` int(8) NOT NULL,
  `CENTER_ID` int(8) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `alarm`
--

CREATE TABLE `alarm` (
  `ALARM_ID` int(2) NOT NULL,
  `PATIENT_ID` int(8) NOT NULL,
  `TITLE` varchar(200) NOT NULL,
  `BODY` tinytext NOT NULL,
  `DATE_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(1) DEFAULT 'W'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alarm`
--

INSERT INTO `alarm` (`ALARM_ID`, `PATIENT_ID`, `TITLE`, `BODY`, `DATE_TIME`, `STATUS`) VALUES
(1, 23, 'Question', 'answer', '2020-07-23 18:32:08', 'D'),
(2, 23, 'Medical Prescription', 'You just receive a medical prescription, please check it', '2020-07-23 18:53:14', 'D');

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `ANSWER_NUM` int(2) NOT NULL,
  `QUESTION_NUM` int(5) NOT NULL,
  `DOCTOR_ID` int(8) NOT NULL,
  `ANSWER` text NOT NULL,
  `DATE` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`ANSWER_NUM`, `QUESTION_NUM`, `DOCTOR_ID`, `ANSWER`, `DATE`) VALUES
(19, 49, 38, 'Depending on the severity and underlying condition causing the tinnitus, there are several treatments available to improve the perception of unwanted noise. The most common treatments for tinnitus include:\n- Hearing aids with tinnitus-masking features.\n- Tinnitus retraining therapy.\n- Sound therapy.\n- Avoidance measures.\n- Avoidance of certain medications.\n- Behavioral therapy', '2020-07-23 18:32:08');

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_list`
--

CREATE TABLE `bookmark_list` (
  `PATIENT_ID` int(8) NOT NULL,
  `CLINIC_ID` int(8) NOT NULL DEFAULT -1,
  `CENTER_ID` int(8) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bookmark_list`
--

INSERT INTO `bookmark_list` (`PATIENT_ID`, `CLINIC_ID`, `CENTER_ID`) VALUES
(23, -1, 39),
(23, 62, -1);

-- --------------------------------------------------------

--
-- Table structure for table `center`
--

CREATE TABLE `center` (
  `CENTER_ID` int(8) NOT NULL,
  `NAME` varchar(60) NOT NULL,
  `ADDRESS` tinytext NOT NULL,
  `CENTER_PHONE` varchar(11) NOT NULL,
  `SPECIALITY` varchar(100) NOT NULL,
  `FEE` decimal(6,2) NOT NULL,
  `DOC_ADMIN` int(8) DEFAULT -1,
  `CENTER_KEY` varchar(100) DEFAULT NULL,
  `CENTER_PHOTO` varchar(100) NOT NULL DEFAULT '--',
  `ABOUT_CENTER` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `center`
--

INSERT INTO `center` (`CENTER_ID`, `NAME`, `ADDRESS`, `CENTER_PHONE`, `SPECIALITY`, `FEE`, `DOC_ADMIN`, `CENTER_KEY`, `CENTER_PHOTO`, `ABOUT_CENTER`) VALUES
(-1, '-1', '-1', '1000000000', '-1', '0.00', -1, '-1', '--', '--'),
(39, 'Cure Center', 'Cairo', '01078945612', 'Audiology', '80.00', 38, '381194851', '963840326_Image_272959493.jpg', 'Integrated audio unit of all kinds');

-- --------------------------------------------------------

--
-- Table structure for table `clinic`
--

CREATE TABLE `clinic` (
  `CLINIC_ID` int(8) NOT NULL,
  `CLINIC_NAME` varchar(100) DEFAULT NULL,
  `DOCTOR_ID` int(8) NOT NULL,
  `ADDRESS` tinytext NOT NULL,
  `CLINIC_PHONE` varchar(11) NOT NULL,
  `FEE` decimal(6,2) NOT NULL,
  `CLINIC_KEY` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clinic`
--

INSERT INTO `clinic` (`CLINIC_ID`, `CLINIC_NAME`, `DOCTOR_ID`, `ADDRESS`, `CLINIC_PHONE`, `FEE`, `CLINIC_KEY`) VALUES
(-1, '-1', -1, '-1', '-1', '-1.00', '-1'),
(62, 'Abdullah ‎Montaser', 38, 'cairo', '01023456789', '80.00', '38287785264');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `DOCTOR_ID` int(8) NOT NULL,
  `FIRST_NAME` varchar(25) NOT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `SPECIALITY` varchar(100) NOT NULL,
  `TITLE` varchar(25) NOT NULL,
  `PHONE` varchar(11) NOT NULL,
  `GENDER` varchar(6) NOT NULL,
  `BIRTH_DATE` date NOT NULL,
  `BIO` text NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(30) NOT NULL,
  `PROFILE_PICTURE` varchar(50) DEFAULT '--'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`DOCTOR_ID`, `FIRST_NAME`, `LAST_NAME`, `SPECIALITY`, `TITLE`, `PHONE`, `GENDER`, `BIRTH_DATE`, `BIO`, `EMAIL`, `PASSWORD`, `PROFILE_PICTURE`) VALUES
(-1, '-1', '-1', '-1', '-1', '-1', '-1', '0000-00-00', '-1', '-1', '-1', '--'),
(1, 'Ahmed', 'Ali', 'Dentistry (Teeth)', 'Professor', '01090945714', 'Male', '1990-01-08', 'hi', 'ahmedali@gmail.com', '123456789', '220406608_Image_462180763.jpg'),
(2, 'Ahmed', 'kkkk', 'Dentistry (Teeth)', 'Professor', '01090945724', 'Male', '1990-01-14', 'edited bio', 'ahmed1@gmail.com', '123456789', '426544505_Image_948262577.jpg'),
(3, 'Mohamed', 'Ahmed', 'Dentistry (Teeth)', 'Professor', '1090945714', 'Male', '1990-01-14', 'A letter i to another person through a medium. Letters can be formal and informal. Besides a means of communication and a store of information, letter writing has played a rA letter is a written message conveyed from one person to another person through a medium. Letters can be formal and informal. Besides a means of communication and a store of information, letter writing has played a r', 'ahmed2@gmail.com', '123456789', 'Image_923983492.jpg'),
(4, 'ali', 'ali', 'Dermatology (Skin)', 'Lecturer', '1090945714', 'Male', '1930-10-09', '', 'aliahmed@gmail.com', 'asdfghjkl', 'Image_923983492.jpg'),
(29, 'ahmed', 'mohamed', 'Ear, Nose, and Throat', 'Professor', '01096325874', 'Male', '1970-10-23', 'A letter i to another peer person through a medium. Letters can be formal and informal. Besides a means of communication and a store of information, letter writing has played a r', 'ahmed_mohamed@gmail.com', '123456789', 'Image_923983492.jpg'),
(30, 'ahmed', 'mohamed', 'Dentistry (Teeth)', 'Professor', '01085236985', 'Male', '1974-11-11', 'A letter i to another person through a medium. Letters can be formal and informal. Besides a means of communication and a store of information, letter writing has played a rA letter is a written message conveyed from one person to another person through a medium. Letters can be formal and informal. Besides a means of communication and a store of information, letter writing has played a r', 'ahmed@gmail.com', '123456789', 'Image_923983492.jpg'),
(32, 'ahmed', 'ali', 'Ear, Nose, and Throat', 'Professor', '01085236985', 'Male', '1973-11-13', '', 'ahmed116@gmail.com', '123456789', 'Image_923983492.jpg'),
(34, 'ahmed', 'mohamed', 'Audiology', 'Professor', '01085236986', 'Male', '1978-10-12', '', 'ahmed117@gmail.com', '123456789', 'Image_923983492.jpg'),
(35, 'Hassan', 'Mohamed', 'Andrology and Male Infertility', 'Specialist', '01096325874', 'Male', '1931-10-11', '', 'aahmed@gmail.com', 'bsbshshsjsj', '2Image_470285846.jpg'),
(36, 'Ali', 'Abdullah', 'Psychiatry (Mental, Emotional or Behavioral Disorders)', 'Professor', '01085236985', 'Male', '1980-11-21', 'A doctor’s ‘special interest’ can also be useful to someone with a more ‘specific health problem’. For example, if you have a new mole you are concerned about, finding a doctor with a special interest in ‘Skin Cancer’ can be useful and save your time and the doctors’ time.', 'ali_abdullah@yahoo.com', '123456789', '420854555_Image_533672541.jpg'),
(37, 'Mahmoud', 'Talaat', 'Dentistry (Teeth)', 'Professor', '01015660250', 'Male', '1996-08-07', '', 'mahmoudtalaat777@gmail.com', '12345', '--'),
(38, 'abdullah', 'Montaser', 'Audiology', 'Specialist', '01085236985', 'Male', '1969-10-12', 'Doctor of Hearing Diseases and Doctor Audio Specialist in Hearing and Balancing Disorder, Adults and Baby Audio', 'abdullah.mo@gmail.com', '123456789', '665989963_Image_959917628.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_center`
--

CREATE TABLE `doctor_center` (
  `DOCTOR_ID` int(8) NOT NULL,
  `CENTER_ID` int(8) NOT NULL,
  `ADMIN` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor_center`
--

INSERT INTO `doctor_center` (`DOCTOR_ID`, `CENTER_ID`, `ADMIN`) VALUES
(38, 39, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `CLINIC_ID` int(8) DEFAULT -1,
  `CENTER_ID` int(8) DEFAULT -1,
  `INSUR_NAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `insurance`
--

INSERT INTO `insurance` (`CLINIC_ID`, `CENTER_ID`, `INSUR_NAME`) VALUES
(-1, 39, 'Grey Leaf Coverage'),
(-1, 39, 'LongSage Insurance'),
(-1, 39, 'Solid Life Insurance'),
(62, -1, 'Aristocrat Insurance'),
(62, -1, 'Caprock InsuranceI-nsumed'),
(62, -1, 'Medical ValuSurance');

-- --------------------------------------------------------

--
-- Table structure for table `medical_record`
--

CREATE TABLE `medical_record` (
  `PATIENT_ID` int(8) DEFAULT NULL,
  `DOCTOR_ID` int(8) DEFAULT NULL,
  `DESCRIPTION` mediumtext DEFAULT NULL,
  `DATE_TIME` datetime DEFAULT NULL,
  `IMAGE` varchar(100) DEFAULT '--'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medical_record`
--

INSERT INTO `medical_record` (`PATIENT_ID`, `DOCTOR_ID`, `DESCRIPTION`, `DATE_TIME`, `IMAGE`) VALUES
(23, 38, 'this is the medical prescription.', '2020-07-23 18:53:14', '381942571_Image_882869135.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `CLINIC_ID` int(8) DEFAULT -1,
  `CENTER_ID` int(8) DEFAULT -1,
  `CONTENT` text DEFAULT NULL,
  `FIGURE_NAME` varchar(100) DEFAULT NULL,
  `DATE_TIME` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`CLINIC_ID`, `CENTER_ID`, `CONTENT`, `FIGURE_NAME`, `DATE_TIME`) VALUES
(62, -1, 'Abdullah Montaser', '155100036_Image_562929931.jpg', '2020-07-22 16:05:09'),
(-1, 39, 'This is an offer from cure center', '768512982_Image_889273233.jpg', '2020-07-22 16:08:19');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PATIENT_ID` int(8) NOT NULL,
  `FIRST_NAME` varchar(25) NOT NULL,
  `LAST_NAME` varchar(25) NOT NULL,
  `PHONE` varchar(11) NOT NULL,
  `GENDER` varchar(6) NOT NULL,
  `BIRTH_DATE` date NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `PASSWORD` varchar(30) NOT NULL,
  `PROFILE_PICTURE` varchar(50) DEFAULT '--'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PATIENT_ID`, `FIRST_NAME`, `LAST_NAME`, `PHONE`, `GENDER`, `BIRTH_DATE`, `EMAIL`, `PASSWORD`, `PROFILE_PICTURE`) VALUES
(23, 'Ahmed', 'Mohamed', '01090945714', 'Male', '1998-09-23', 'ahmed@gmail.com', '123456789', '23Image_994560989.jpg'),
(25, 'Hassan', 'Mohamed', '01090945716', 'Male', '1926-10-07', 'ahmed98@gmail.com', '123456789', '23Image_267677239.jpg'),
(26, 'Ahmed', 'ali', '01096325874', 'Male', '1967-09-23', 'ahmedhassan@gmail.com', '123456789', '23Image_267677239.jpg'),
(32, 'Ahmed', 'El Sewedy', '01125736673', 'male', '1998-07-23', 'ahmedelsewedy@gmail.com', '123456789', '23Image_267677239.jpg'),
(44, 'ahmed', 'mohamed', '01085236985', 'Male', '1930-10-10', 'ahmed112@gmail.com', '123456789', '23Image_267677239.jpg'),
(45, 'ahmed', 'bassam', '01085236985', 'Male', '1983-12-11', 'ahmedqqq@gmail.com', '123456789', '23Image_267677239.jpg'),
(46, 'hassan', 'aed', '01285236985', 'Male', '1997-05-13', 'hassanahmed@gmail.com', 'asdfghjkl', '--'),
(47, 'ali', 'ali', '01098765432', 'Male', '1997-05-14', 'aliali@gmail.com', '123456789', '47Image_143178537.jpg'),
(48, 'محمد ‏', 'شكرى', '01091777967', 'Male', '1966-07-03', 'mohamedshoukry66@gmail.com', '01005289900', '48Image_63815569.jpg'),
(49, 'Mahmoud', 'Talaat', '01015660250', 'Male', '1996-08-07', 'mahmoudtalaat777@gmail.com', '12345', '--');

-- --------------------------------------------------------

--
-- Table structure for table `patient_feedback`
--

CREATE TABLE `patient_feedback` (
  `PATIENT_ID` int(8) NOT NULL,
  `CLINIC_ID` int(8) NOT NULL,
  `CENTER_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `photos`
--

CREATE TABLE `photos` (
  `CLINIC_ID` int(8) DEFAULT NULL,
  `CENTER_ID` int(8) DEFAULT NULL,
  `PHOTO_NAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `photos`
--

INSERT INTO `photos` (`CLINIC_ID`, `CENTER_ID`, `PHOTO_NAME`) VALUES
(62, -1, '810464595_Image_159512645.jpg'),
(-1, 39, '309392775_Image_379638540.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `QUESTION_NUM` int(5) NOT NULL,
  `PATIENT_ID` int(8) NOT NULL,
  `SPECIALITY` varchar(100) NOT NULL,
  `QUESTION` text NOT NULL,
  `DATE` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`QUESTION_NUM`, `PATIENT_ID`, `SPECIALITY`, `QUESTION`, `DATE`) VALUES
(49, 23, 'Audiology', 'I have tinnitus, How can I get rid of it ?', '2020-06-05 13:02:05');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `patient_id` int(8) DEFAULT NULL,
  `clinic_id` int(8) DEFAULT -1,
  `center_id` int(8) DEFAULT -1,
  `rate` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `PATIENT_ID` int(8) NOT NULL,
  `CLINIC_ID` int(8) DEFAULT -1,
  `CENTER_ID` int(8) DEFAULT -1,
  `DATE` date NOT NULL,
  `TIME` time NOT NULL,
  `CHANNEL_ID` varchar(100) DEFAULT '--'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`PATIENT_ID`, `CLINIC_ID`, `CENTER_ID`, `DATE`, `TIME`, `CHANNEL_ID`) VALUES
(23, 62, -1, '2020-07-23', '05:40:00', '--'),
(23, 62, -1, '2020-07-25', '08:00:00', '--'),
(23, -1, 39, '2020-08-01', '17:00:00', '--'),
(23, -1, 39, '2020-07-25', '17:00:00', '--'),
(23, -1, 39, '2020-07-25', '17:10:00', '--'),
(23, -1, 39, '2020-07-25', '16:00:00', '--'),
(23, -1, 39, '2020-07-25', '16:50:00', '--'),
(23, -1, 39, '2020-07-25', '17:20:00', '--'),
(23, -1, 39, '2020-07-25', '15:00:00', '--'),
(23, 62, -1, '2020-07-25', '08:10:00', '--');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `patient_id` int(8) DEFAULT NULL,
  `clinic_id` int(8) DEFAULT -1,
  `center_id` int(8) DEFAULT -1,
  `review` varchar(2000) DEFAULT NULL,
  `STATUS` int(11) NOT NULL DEFAULT 0,
  `date_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`patient_id`, `clinic_id`, `center_id`, `review`, `STATUS`, `date_time`) VALUES
(23, -1, 39, 'One of the best centers that I visited.', 1, '2020-07-23 20:06:51'),
(23, 62, -1, 'One of the best doctors that I visited.', 1, '2020-07-24 18:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `week_days`
--

CREATE TABLE `week_days` (
  `CLINIC_ID` int(8) DEFAULT -1,
  `SAT_START` varchar(10) DEFAULT '--',
  `SAT_END` varchar(10) DEFAULT '--',
  `SUN_START` varchar(10) DEFAULT '--',
  `SUN_END` varchar(10) DEFAULT '--',
  `MON_START` varchar(10) DEFAULT '--',
  `MON_END` varchar(10) DEFAULT '--',
  `TUES_START` varchar(10) DEFAULT '--',
  `TUES_END` varchar(10) DEFAULT '--',
  `WED_START` varchar(10) DEFAULT '--',
  `WED_END` varchar(10) DEFAULT '--',
  `THU_START` varchar(10) DEFAULT '--',
  `THU_END` varchar(10) DEFAULT '--',
  `FRI_START` varchar(10) DEFAULT '--',
  `FRI_END` varchar(10) DEFAULT '--',
  `CENTER_ID` int(8) DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `week_days`
--

INSERT INTO `week_days` (`CLINIC_ID`, `SAT_START`, `SAT_END`, `SUN_START`, `SUN_END`, `MON_START`, `MON_END`, `TUES_START`, `TUES_END`, `WED_START`, `WED_END`, `THU_START`, `THU_END`, `FRI_START`, `FRI_END`, `CENTER_ID`) VALUES
(62, '12:00 AM', '12:00 PM', '12:00 AM', '12:00 PM', '12:00 AM', '12:00 PM', '--', '--', '--', '--', '--', '--', '--', '--', -1),
(-1, '3:00 PM', '6:00 PM', '3:00 PM', '6:00 PM', '--', '--', '--', '--', '--', '--', '--', '--', '--', '--', 39);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`ADMIN_ID`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`),
  ADD KEY `PATIENT_ID` (`PATIENT_ID`),
  ADD KEY `CLINIC_ID` (`CLINIC_ID`),
  ADD KEY `CENTER_ID` (`CENTER_ID`);

--
-- Indexes for table `alarm`
--
ALTER TABLE `alarm`
  ADD PRIMARY KEY (`ALARM_ID`),
  ADD KEY `PATIENT_ID` (`PATIENT_ID`);

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`ANSWER_NUM`),
  ADD KEY `QUESTION_NUM` (`QUESTION_NUM`),
  ADD KEY `DOCTOR_ID` (`DOCTOR_ID`);

--
-- Indexes for table `bookmark_list`
--
ALTER TABLE `bookmark_list`
  ADD PRIMARY KEY (`PATIENT_ID`,`CLINIC_ID`,`CENTER_ID`),
  ADD UNIQUE KEY `cen_cli_un` (`PATIENT_ID`,`CLINIC_ID`,`CENTER_ID`),
  ADD UNIQUE KEY `cen_cli_pk` (`CENTER_ID`,`CLINIC_ID`,`PATIENT_ID`),
  ADD KEY `PATIENT_ID` (`PATIENT_ID`),
  ADD KEY `CLINIC_ID` (`CLINIC_ID`),
  ADD KEY `CENTER_ID` (`CENTER_ID`);

--
-- Indexes for table `center`
--
ALTER TABLE `center`
  ADD PRIMARY KEY (`CENTER_ID`),
  ADD UNIQUE KEY `center_key` (`CENTER_KEY`),
  ADD KEY `doc_ad_fk` (`DOC_ADMIN`);

--
-- Indexes for table `clinic`
--
ALTER TABLE `clinic`
  ADD PRIMARY KEY (`CLINIC_ID`),
  ADD UNIQUE KEY `clinic_key` (`CLINIC_KEY`),
  ADD KEY `DOCTOR_ID` (`DOCTOR_ID`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`DOCTOR_ID`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`);

--
-- Indexes for table `doctor_center`
--
ALTER TABLE `doctor_center`
  ADD UNIQUE KEY `all_unique` (`DOCTOR_ID`,`CENTER_ID`),
  ADD KEY `DOCTOR_ID` (`DOCTOR_ID`),
  ADD KEY `CENTER_ID` (`CENTER_ID`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD UNIQUE KEY `all_unique` (`CLINIC_ID`,`CENTER_ID`,`INSUR_NAME`),
  ADD KEY `CEN_FK1` (`CENTER_ID`);

--
-- Indexes for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD KEY `fr_pat` (`PATIENT_ID`),
  ADD KEY `fr_doc` (`DOCTOR_ID`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD KEY `CEN1_FK` (`CENTER_ID`),
  ADD KEY `CLI1_FK` (`CLINIC_ID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PATIENT_ID`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`);

--
-- Indexes for table `patient_feedback`
--
ALTER TABLE `patient_feedback`
  ADD KEY `PATIENT_ID` (`PATIENT_ID`),
  ADD KEY `CLINIC_ID` (`CLINIC_ID`),
  ADD KEY `CENTER_ID` (`CENTER_ID`);

--
-- Indexes for table `photos`
--
ALTER TABLE `photos`
  ADD UNIQUE KEY `PHOTO_NAME` (`PHOTO_NAME`),
  ADD KEY `CLI_FO` (`CLINIC_ID`),
  ADD KEY `CEN_FO` (`CENTER_ID`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`QUESTION_NUM`),
  ADD KEY `PATIENT_ID` (`PATIENT_ID`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD KEY `pid_fk1` (`patient_id`),
  ADD KEY `clid_fk1` (`clinic_id`),
  ADD KEY `ceid_fk1` (`center_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD UNIQUE KEY `all_unique` (`CLINIC_ID`,`CENTER_ID`,`DATE`,`TIME`),
  ADD KEY `PATIENT_ID` (`PATIENT_ID`),
  ADD KEY `CLINIC_ID` (`CLINIC_ID`),
  ADD KEY `CENTER_ID` (`CENTER_ID`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD KEY `pid_fk2` (`patient_id`),
  ADD KEY `clid_fk2` (`clinic_id`),
  ADD KEY `ceid_fk2` (`center_id`);

--
-- Indexes for table `week_days`
--
ALTER TABLE `week_days`
  ADD KEY `CLINIC_ID` (`CLINIC_ID`),
  ADD KEY `cen_fk` (`CENTER_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `ADMIN_ID` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alarm`
--
ALTER TABLE `alarm`
  MODIFY `ALARM_ID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `ANSWER_NUM` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `center`
--
ALTER TABLE `center`
  MODIFY `CENTER_ID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `clinic`
--
ALTER TABLE `clinic`
  MODIFY `CLINIC_ID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `DOCTOR_ID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `PATIENT_ID` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `QUESTION_NUM` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrator`
--
ALTER TABLE `administrator`
  ADD CONSTRAINT `administrator_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`),
  ADD CONSTRAINT `administrator_ibfk_2` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `administrator_ibfk_3` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`);

--
-- Constraints for table `alarm`
--
ALTER TABLE `alarm`
  ADD CONSTRAINT `alarm_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`);

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`QUESTION_NUM`) REFERENCES `questions` (`QUESTION_NUM`),
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`);

--
-- Constraints for table `bookmark_list`
--
ALTER TABLE `bookmark_list`
  ADD CONSTRAINT `bookmark_list_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`),
  ADD CONSTRAINT `bookmark_list_ibfk_2` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `bookmark_list_ibfk_3` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`);

--
-- Constraints for table `center`
--
ALTER TABLE `center`
  ADD CONSTRAINT `doc_ad_fk` FOREIGN KEY (`DOC_ADMIN`) REFERENCES `doctor` (`DOCTOR_ID`);

--
-- Constraints for table `clinic`
--
ALTER TABLE `clinic`
  ADD CONSTRAINT `clinic_ibfk_1` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`);

--
-- Constraints for table `doctor_center`
--
ALTER TABLE `doctor_center`
  ADD CONSTRAINT `doctor_center_ibfk_1` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`),
  ADD CONSTRAINT `doctor_center_ibfk_2` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`);

--
-- Constraints for table `insurance`
--
ALTER TABLE `insurance`
  ADD CONSTRAINT `CEN_FK1` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `CLI_FK1` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`);

--
-- Constraints for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD CONSTRAINT `fr_doc` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `doctor` (`DOCTOR_ID`),
  ADD CONSTRAINT `fr_pat` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`);

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `CEN1_FK` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `CLI1_FK` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`);

--
-- Constraints for table `patient_feedback`
--
ALTER TABLE `patient_feedback`
  ADD CONSTRAINT `patient_feedback_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`),
  ADD CONSTRAINT `patient_feedback_ibfk_2` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `patient_feedback_ibfk_3` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`);

--
-- Constraints for table `photos`
--
ALTER TABLE `photos`
  ADD CONSTRAINT `CEN_FO` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `CLI_FO` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ceid_fk1` FOREIGN KEY (`center_id`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `clid_fk1` FOREIGN KEY (`clinic_id`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `pid_fk1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`PATIENT_ID`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`PATIENT_ID`) REFERENCES `patient` (`PATIENT_ID`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `ceid_fk2` FOREIGN KEY (`center_id`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `clid_fk2` FOREIGN KEY (`clinic_id`) REFERENCES `clinic` (`CLINIC_ID`),
  ADD CONSTRAINT `pid_fk2` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`PATIENT_ID`);

--
-- Constraints for table `week_days`
--
ALTER TABLE `week_days`
  ADD CONSTRAINT `cen_fk` FOREIGN KEY (`CENTER_ID`) REFERENCES `center` (`CENTER_ID`),
  ADD CONSTRAINT `week_days_ibfk_1` FOREIGN KEY (`CLINIC_ID`) REFERENCES `clinic` (`CLINIC_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
