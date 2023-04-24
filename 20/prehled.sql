DROP TABLE IF EXISTS [dbo].[20_prehled];

CREATE TABLE [dbo].[20_prehled] (
     orp_kod nvarchar(10),
     vakcina_kod nvarchar(10),
     poradi_davky nvarchar(10),
     vekova_skupina nvarchar(10),
     pohlavi nvarchar(10),
     pocet_davek int,
     pouze_davka int,
     okres_kod nvarchar(10),
     orp_vek_pocet_obyvatel int
);

INSERT INTO [dbo].[20_prehled]
    SELECT
        orp_kod,
        vakcina_kod,
        poradi_davky,
        vekova_skupina,
        pohlavi,
        pocet_davek,
        ABS(pocet_davek - LAG(pocet_davek, 1, 0) OVER (
            PARTITION BY
                orp_kod,
                vakcina_kod,
                vekova_skupina,
                pohlavi
            ORDER BY poradi_davky DESC)) AS pouze_davka,
        okres_kod,
        orp_vek_pocet_obyvatel
    FROM
        [10_prehled] p