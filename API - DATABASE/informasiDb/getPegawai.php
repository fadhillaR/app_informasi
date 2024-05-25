<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$sql = "
    SELECT pegawai.*, users.nama, users.nohp, users.ktp
    FROM pegawai
    INNER JOIN users ON pegawai.id_user = users.id_user
";
// $sql = "
//     SELECT pegawai.*, users.nama, users.nohp, users.ktp
//     FROM pegawai
//     INNER JOIN users ON pegawai.id_user = users.id_user
//     WHERE pegawai.id_user = '$idUser'
// ";

$result = $koneksi->query($sql);

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Informasi Pengaduan Pegawai";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal Menampilkan Informasi Pengaduan Pegawai";
    $response['data'] = null;
}
echo json_encode($response);

?>
