<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_jms = $_POST['id_jms'];
$status_laporan = $_POST['status_laporan'];

// Perbarui status laporan
$update = "UPDATE jms SET status_laporan = '$status_laporan' WHERE id_jms = '$id_jms'";
if (mysqli_query($koneksi, $update)) {
    $response['value'] = 1;
    $response['message'] = "Berhasil update status laporan";
} else {
    $response['value'] = 0;
    $response['message'] = "Gagal update status laporan";
}

if (!isset($_POST['id_jms']) || !isset($_POST['status_laporan'])) {
    $response['value'] = 0;
    $response['message'] = "Data tidak lengkap";
    echo json_encode($response);
    exit;
}

echo json_encode($response);

?>
