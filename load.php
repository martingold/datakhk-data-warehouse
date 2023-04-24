<?php

$serverName = '';
$connectionInfo = ['database' => '', 'username' => '', 'password' => ''];

$url = 'https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19/ockovani-zakladni-prehled.csv';

$session = curl_init($url);
$save = './prehled.csv';

$csvFilePath = fopen($save, 'wb');
curl_setopt($session, CURLOPT_FILE, $csvFilePath);
curl_setopt($session, CURLOPT_HEADER, 0);
curl_exec($session);
curl_close($session);
fclose($csvFilePath);

try {
    $conn = new PDO(
        "sqlsrv:Server=$serverName;Database={$connectionInfo['database']}",
        $connectionInfo['username'],
        $connectionInfo['password']
    );
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    if (($handle = fopen($csvFilePath, "r")) !== FALSE) {
        $stmt = $conn->query('DELETE FROM [00_prehled]');
        while (($data = fgets($handle)) !== FALSE) {
            $rowData = str_getcsv($data);

            $sql = "INSERT INTO [00_prehled] (
                id, kraj_nazev, kraj_nuts_kod,
                orp_bydliste, orp_bydliste_kod,
                vakcina, vakcina_kod, poradi_davky,
                vekova_skupina, pohlavi, pocet_davek
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            foreach (range(1, 11) as $index) {
                $stmt->bindParam($index, $rowData[$index]);
            }
            $stmt->execute();
        }
        fclose($handle);
    }
    $conn = null;
} catch (PDOException $e) {
    echo 'Error: ' . $e->getMessage();
}