<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_hukum = $_POST['id_hukum'];

	$sql = "DELETE FROM hukum WHERE id_hukum = $id_hukum";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Penyuluhan Hukum";
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Penyuluhan Hukum";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>