<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$sql = "
    SELECT pilkada.*, users.nama, users.nohp, users.ktp
    FROM pilkada
    INNER JOIN users ON pilkada.id_user = users.id_user
";
$result = $koneksi->query($sql);

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Informasi Posko Pilkada";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal Menampilkan Informasi Posko Pilkada";
    $response['data'] = null;
}
echo json_encode($response);

?>
