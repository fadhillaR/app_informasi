<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

$id_user = $_POST['id_user'];
$isi_laporan = $_POST['isi_laporan'];
$status_laporan = $_POST['status_laporan'];

// Memeriksa file telah diunggah
if(isset($_FILES['file_ktp']) && isset($_FILES['laporan'])) {
    $file_name = basename($_FILES['laporan']['name']);
    $file_ktp_name = basename($_FILES['file_ktp']['name']);
    $file_tmp = $_FILES['laporan']['tmp_name'];
    $file_ktp_tmp = $_FILES['file_ktp']['tmp_name'];
    $file_destination = 'C:\xampp\htdocs\informasiDb\file\\' . $file_name;
    $file_ktp_destination = 'C:\xampp\htdocs\informasiDb\file\\' . $file_ktp_name;
    
    // Pindahkan file KTP ke lokasi penyimpanan di server
    if(move_uploaded_file($file_ktp_tmp, $file_ktp_destination)) {
        // Pindahkan file laporan ke lokasi penyimpanan di server
        if(move_uploaded_file($file_tmp, $file_destination)) {
            // Query untuk menyimpan path file ke database
            $insert = "INSERT INTO hukum (id_user, file_ktp, isi_laporan, laporan, status_laporan) VALUES ('$id_user', '$file_ktp_name', '$isi_laporan', '$file_name', '$status_laporan')";
            
            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['message'] = "Berhasil tambah data penyuluhan hukum";
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal tambah data penyuluhan hukum";
            }
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal menyimpan file laporan di server";
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal menyimpan file KTP di server";
    }
} else {
    $response['value'] = 0;
    $response['message'] = "Tidak ada file yang diunggah";
}

echo json_encode($response);

?>
