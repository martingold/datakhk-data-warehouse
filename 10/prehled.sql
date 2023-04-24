DROP TABLE IF EXISTS [dbo].[10_prehled];

CREATE TABLE [dbo].[10_prehled] (
   orp_kod nvarchar(10),
   vakcina nvarchar(300),
   vakcina_kod nvarchar(30),
   poradi_davky int,
   vekova_skupina nvarchar(10),
   pohlavi nvarchar(10),
   pocet_davek int,
   okres_kod nvarchar(10)
);

INSERT INTO [10_prehled]
SELECT
    p.orp_bydliste_kod AS orp_kod,
    p.vakcina,
    p.vakcina_kod,
    CAST(p.poradi_davky AS int) AS poradi_davky,
    p.vekova_skupina,
    p.pohlavi,
    p.pocet_davek AS pocet_davek,
    (SELECT TOP 1 orp.okres_kod FROM [00_pocet_obyvatel] orp WHERE orp.orp_kod = p.orp_bydliste_kod) as okres_kod
FROM
    (
        SELECT
            i.orp_bydliste_kod, i.vakcina_kod, i.vakcina, i.poradi_davky, i.vekova_skupina,
            i.pohlavi, SUM(CAST(i.pocet_davek AS int)) AS pocet_davek
        FROM [00_prehled] i
        GROUP BY orp_bydliste_kod, vakcina_kod, vakcina, poradi_davky, vekova_skupina, pohlavi
    ) p
WHERE
    p.orp_bydliste_kod IN (
        '5201', '5202', '5203', '5204', '5205',
        '5206', '5207', '5208', '5209', '5210',
        '5211', '5212', '5213', '5214', '5215'
    )