<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_jms = $_POST['id_jms'];

	$sql = "DELETE FROM jms WHERE id_jms = $id_jms";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Jaksa Masuk Sekolah";
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Jaksa Masuk Sekolah";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>