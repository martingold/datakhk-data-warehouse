<?php

$scripts = concatFolderContents('./*');

$procedure = <<<SQL
IF EXISTS (
    SELECT * FROM sys.objects 
   WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('UpdateDataProcedure'))
BEGIN
    DROP PROCEDURE UpdateDataProcedure
END

CREATE PROCEDURE UpdateDataProcedure
AS
BEGIN
     $scripts
END
SQL;

file_put_contents('./sp.sql', $procedure);


function concatFolderContents(string $folderPath) {
    $files = glob(rtrim($folderPath, '/') . '/*.sql');

    return implode(
        PHP_EOL . PHP_EOL,
        array_map(function (string $file): string {
            return sprintf(
                '-- %s %s %s',
                $file,
                PHP_EOL,
                file_get_contents($file),
            );
        }, $files)
    );
}