<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$sql = "
    SELECT aliran.*, users.nama, users.nohp, users.ktp
    FROM aliran
    INNER JOIN users ON aliran.id_user = users.id_user
";
$result = $koneksi->query($sql);

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Informasi Pengawasan Aliran dan Kepercayaan";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal Menampilkan Informasi Pengawasan Aliran dan Kepercayaan";
    $response['data'] = null;
}
echo json_encode($response);

?>
