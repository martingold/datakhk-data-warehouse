DROP TABLE IF EXISTS [dbo].[20_okres_vekove_skupiny];

CREATE TABLE [dbo].[20_okres_vekove_skupiny] (
      okres_kod nvarchar(10),
      pocet_obyvatel int,
      vekova_skupina nvarchar(10)
);

INSERT INTO [dbo].[20_okres_vekove_skupiny]
SELECT
    okres_kod,
    SUM(CAST(REPLACE(pocet_obyvatel, ' ', '') AS int)) as pocet_obyvatel,
    vekova_skupina
FROM [00_pocet_obyvatel]
GROUP BY okres_kod, vekova_skupina


