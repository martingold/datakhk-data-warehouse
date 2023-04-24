DROP TABLE IF EXISTS [dbo].[20_okres];

CREATE TABLE [dbo].[20_okres] (
     okres_kod nvarchar(10),
     okres_nazev nvarchar(300),
     pocet_obyvatel int
);

INSERT INTO [dbo].[20_okres]
SELECT DISTINCT
   okres_kod,
   okres_nazev,
   SUM(CAST(REPLACE(pocet_obyvatel, ' ', '') AS int)) as pocet_obyvatel
FROM [00_pocet_obyvatel]
GROUP BY okres_kod, okres_nazev


