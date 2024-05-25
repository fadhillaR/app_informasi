<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_korupsi = $_POST['id_korupsi'];
$status_laporan = $_POST['status_laporan'];

// Perbarui status laporan
$update = "UPDATE korupsi SET status_laporan = '$status_laporan' WHERE id_korupsi = '$id_korupsi'";
if (mysqli_query($koneksi, $update)) {
    $response['value'] = 1;
    $response['message'] = "Berhasil update status laporan";
} else {
    $response['value'] = 0;
    $response['message'] = "Gagal update status laporan";
}

if (!isset($_POST['id_korupsi']) || !isset($_POST['status_laporan'])) {
    $response['value'] = 0;
    $response['message'] = "Data tidak lengkap";
    echo json_encode($response);
    exit;
}

echo json_encode($response);

?>
