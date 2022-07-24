<?php

    $image = $_FILES['image']['name'];
    $title = $_Post['title'];
    $imagePath="Offers/".$image;

    move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);
?>