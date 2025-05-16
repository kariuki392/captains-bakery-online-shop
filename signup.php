<?php
session_start();

$_SESSION["user"]="";
$_SESSION["usertype"]="";

date_default_timezone_set('Africa/Nairobi');
$date = date('Y-m-d');

$_SESSION["date"]=$date;

if($_POST){
    $_SESSION["personal"]=array(
        'fname'=>$_POST['fname'],
        'lname'=>$_POST['lname'],
        'address'=>$_POST['address'],
        'nic'=>$_POST['nic'],
        'dob'=>$_POST['dob']
    );

    header("location: createaccount.php");
    exit();
} else {
    header("location: signup.html");
    exit();
}