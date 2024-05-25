<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_user = $_POST['id_user'];
$nama_pemohon = $_POST['nama_pemohon'];
$nama_sekolah = $_POST['nama_sekolah'];
$status_laporan = $_POST['status_laporan'];


            $insert = "INSERT INTO jms (id_user, nama_pemohon, nama_sekolah, status_laporan) VALUES ('$id_user', '$nama_pemohon', '$nama_sekolah', '$status_laporan')";
            
            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['message'] = "Berhasil tambah data Jaksa Masuk Sekolah";
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal tambah data Jaksa Masuk Sekolah";
            }
        

echo json_encode($response);

?>
