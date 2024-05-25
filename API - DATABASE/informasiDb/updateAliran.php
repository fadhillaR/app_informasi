<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_aliran = $_POST['id_aliran'];
$id_user = $_POST['id_user'];
$isi_laporan = $_POST['isi_laporan'];
$status_laporan = $_POST['status_laporan'];

if(isset($_FILES['laporan'])) {
    $file_name = basename($_FILES['laporan']['name']);
    $file_tmp = $_FILES['laporan']['tmp_name'];
    $file_destination = 'C:\xampp\htdocs\informasiDb\file\\' . $file_name;

    if(move_uploaded_file($file_tmp, $file_destination)) {
        $update = "UPDATE aliran SET id_user = '$id_user', isi_laporan = '$isi_laporan', laporan = '$file_name', status_laporan = '$status_laporan' WHERE id_aliran = '$id_aliran'";
        if (mysqli_query($koneksi, $update)) {
            $response['value'] = 1;
            $response['message'] = "Berhasil update data Pengawasan Aliran dan Kepercayaan";
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal update data Pengawasan Aliran dan Kepercayaan";
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal menyimpan file di server";
    }
} 

if(isset($_FILES['file_ktp'])) {
    $file_ktp_name = basename($_FILES['file_ktp']['name']);
    $file_ktp_tmp = $_FILES['file_ktp']['tmp_name'];
    $file_ktp_destination = 'C:\xampp\htdocs\informasiDb\file\\' . $file_ktp_name;

    if(move_uploaded_file($file_ktp_tmp, $file_ktp_destination)) {
        $update = "UPDATE aliran SET id_user = '$id_user', isi_laporan = '$isi_laporan', file_ktp = '$file_ktp_name', status_laporan = '$status_laporan' WHERE id_aliran = '$id_aliran'";
        if (mysqli_query($koneksi, $update)) {
            $response['value'] = 1;
            $response['message'] = "Berhasil update data Pengawasan Aliran dan Kepercayaan";
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal update data Pengawasan Aliran dan Kepercayaan";
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal menyimpan file KTP di server";
    }
}

if (!isset($_FILES['laporan']) && !isset($_FILES['file_ktp'])) {
    $update = "UPDATE aliran SET id_user = '$id_user', isi_laporan = '$isi_laporan', status_laporan = '$status_laporan' WHERE id_aliran = '$id_aliran'";
    if (mysqli_query($koneksi, $update)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil update data Pengawasan Aliran dan Kepercayaan";
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal update data Pengawasan Aliran dan Kepercayaan";
    }
}

if (!isset($_POST['id_aliran']) || !isset($_POST['id_user']) || !isset($_POST['isi_laporan']) || !isset($_POST['status_laporan'])) {
    $response['value'] = 0;
    $response['message'] = "Data tidak lengkap";
    echo json_encode($response);
    exit;
}

echo json_encode($response);

?>
