DROP TABLE IF EXISTS [dbo].[10_pocet_obyvatel];

CREATE TABLE [dbo].[10_pocet_obyvatel]
(
    okres_nazev nvarchar(100),
    orp_nazev nvarchar(100),
    orp_kod nvarchar(10),
    okres_kod nvarchar(10),
    vekova_skupina nvarchar(10),
    pocet_obyvatel int
);

INSERT INTO [10_pocet_obyvatel]
SELECT
    okres_nazev,
    orp_nazev,
    orp_kod,
    okres_kod,
    vekova_skupina,
    CAST(REPLACE(pocet_obyvatel, ' ', '') AS int)
FROM
    [00_pocet_obyvatel]