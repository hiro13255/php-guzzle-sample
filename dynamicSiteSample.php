<?php
//
//require_once __DIR__ . '/vendor/autoload.php';
//
use DOMWrap\Document;
//use GuzzleHttp\Client;
use HeadlessChromium\BrowserFactory;

$url = 'https://www.sony.jp/ichigan/products/ILCE-7M3/spec.html';

require_once('./vendor/autoload.php');

$browserFactory = new BrowserFactory('/usr/bin/chromium-browser');

$options = [
    'headless' => true,
    'noSandbox' => true,
];
$browser = $browserFactory->createBrowser($options);

$page = $browser->createPage();
$page->navigate($url)->waitForNavigation();

$pageTitle = $page->evaluate('document.title')->getReturnValue();
echo $pageTitle, PHP_EOL;

$browser->close();