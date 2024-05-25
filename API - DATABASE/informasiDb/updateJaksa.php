<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_jms = $_POST['id_jms'];
$id_user = $_POST['id_user'];
$nama_pemohon = $_POST['nama_pemohon'];
$nama_sekolah = $_POST['nama_sekolah'];
$status_laporan = $_POST['status_laporan'];

    $update = "UPDATE jms SET id_user = '$id_user', nama_pemohon = '$nama_pemohon', nama_sekolah = '$nama_sekolah' WHERE id_jms = '$id_jms'";
    if (mysqli_query($koneksi, $update)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil update data Jaksa Masuk Sekolah";
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal update data Jaksa Masuk Sekolah";
    }

echo json_encode($response);

?>
