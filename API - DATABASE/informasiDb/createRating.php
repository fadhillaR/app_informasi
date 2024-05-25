<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'koneksi.php';

$response = array();

if (isset($_POST['id_user']) && isset($_POST['rating']) && isset($_POST['komen'])) {
    $id_user = $_POST['id_user'];
    $rating = $_POST['rating'];
    $komen = $_POST['komen'];

    if (!empty($rating) && !empty($komen)) {
        $id_user = mysqli_real_escape_string($koneksi, $id_user);
        $rating = mysqli_real_escape_string($koneksi, $rating);
        $komen = mysqli_real_escape_string($koneksi, $komen);

        $checkQuery = "SELECT * FROM rating WHERE id_user = '$id_user'";
        $checkResult = mysqli_query($koneksi, $checkQuery);

        if (mysqli_num_rows($checkResult) > 0) {
            $response['value'] = 2;
            $response['message'] = "Rating telah diberikan";
        } else {
            $insert = "INSERT INTO rating (id_user, rating, komen) VALUES ('$id_user', '$rating', '$komen')";
            
            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['message'] = "Berhasil tambah data rating";
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal tambah data rating";
            }
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Rating dan komentar harus diisi";
    }
} else {
    $response['value'] = 0;
    $response['message'] = "Data tidak lengkap";
}

echo json_encode($response);

?>
