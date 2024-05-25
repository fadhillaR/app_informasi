<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_korupsi = $_POST['id_korupsi'];

	$sql = "DELETE FROM korupsi WHERE id_korupsi = $id_korupsi";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Pengaduan Tindak Pidana Korupsi";
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Pengaduan Tindak Pidana Korupsi";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>