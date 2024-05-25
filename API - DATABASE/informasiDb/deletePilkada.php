<?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");

    include 'koneksi.php';

    $id_pilkada = $_POST['id_pilkada'];

	$sql = "DELETE FROM pilkada WHERE id_pilkada = $id_pilkada";
	$result = $koneksi->query($sql);

	if($result) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menghapus Data Posko Pilkada";
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal Menghapus Data Posko Pilkada";
		// $response['data'] = null;
	}
	echo json_encode($response);


?>