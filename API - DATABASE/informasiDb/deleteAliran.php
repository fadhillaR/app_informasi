<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_aliran = $_POST['id_aliran'];

	$sql = "DELETE FROM aliran WHERE id_aliran = $id_aliran";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Pengawasan Aliran dan Kepercayaan";
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Pengawasan Aliran dan Kepercayaan";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>