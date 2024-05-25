<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$sql = "
    SELECT hukum.*, users.nama, users.nohp, users.ktp
    FROM hukum
    INNER JOIN users ON hukum.id_user = users.id_user
";
$result = $koneksi->query($sql);

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Informasi Penyuluhan Hukum";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal Menampilkan Informasi Penyuluhan Hukum";
    $response['data'] = null;
}
echo json_encode($response);

?>
