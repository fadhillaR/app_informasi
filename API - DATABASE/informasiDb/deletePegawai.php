<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_pegawai = $_POST['id_pegawai'];

	$sql = "DELETE FROM pegawai WHERE id_pegawai = $id_pegawai";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Pengaduan Pegawai";
		// $response['data'] = array();
		// while ($row = $result->fetch_assoc()) {
		// 	$response['data'][] = $row;
		// }
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Pengaduan Pegawai";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>