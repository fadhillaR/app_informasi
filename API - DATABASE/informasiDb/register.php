<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if($_SERVER['REQUEST_METHOD'] == "POST") {

	$response = array();
	$nama = $_POST['nama'];
	$email = $_POST['email'];
	$nohp = $_POST['nohp'];
	$ktp = $_POST['ktp'];
	$alamat = $_POST['alamat'];
	$role = $_POST['role'];
	$password = md5($_POST['password']);

	$cek = "SELECT * FROM users WHERE ktp = '$ktp' || email = '$email'";
	$result = mysqli_fetch_array(mysqli_query($koneksi, $cek));

	if(isset($result)){
		$response['value'] = 2;
		$response['message'] = "ktp atau email telah digunakan";
		echo json_encode($response);
	} else {
		$insert = "INSERT INTO users VALUE(NULL, '$nama', '$email', '$nohp', '$ktp', '$password', '$alamat', '$role')";
		if(mysqli_query($koneksi, $insert)){
			$response['value'] = 1;
			$response['message'] = "Berhasil didaftarkan";
			echo json_encode($response);
		} else {
			$response['value'] = 0;
			$response['message'] = "Gagal didaftarkan";
			echo json_encode($response);
		}
	}
}

?>