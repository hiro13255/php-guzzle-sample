<?php

require_once __DIR__ . '/vendor/autoload.php';

use GuzzleHttp\Client;
use Symfony\Component\DomCrawler\Crawler;


$client = new Client();
$response = $client->request('GET', 'https://www.sony.jp/ichigan/products/ILCE-7M3/spec.html');

$httpStatusCode = $response->getStatusCode();

if ($httpStatusCode === 200) {
    $source = $response->getBody()->getContents();
    $htmlDocument = new Crawler($source);

    $targetElement = $htmlDocument->filter('.s5-specTable>table');
    $text = $targetElement->text();

    echo $text."\n";
} else {
    echo "ステータスコードが正常ではありません。";
}

