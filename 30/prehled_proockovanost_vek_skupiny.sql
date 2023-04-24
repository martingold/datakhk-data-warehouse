CREATE OR ALTER VIEW [dbo].[30_prehled_proockovanost_vek_skupiny] AS
(
    SELECT
            SUM(pocet_davek) / CAST(
                (
                    SELECT
                        SUM(pocet_obyvatel) FROM [20_okres_vekove_skupiny] [i]
                    WHERE
                            [i].okres_kod = [p].okres_kod
                      AND [i].vekova_skupina = [p].vekova_skupina
                ) AS float
            ) AS proockovanost,
            SUM(pocet_davek) AS pocet_davek,
            [p].vekova_skupina,
            [o].okres_nazev
    FROM [dbo].[20_prehled] [p]
             JOIN [dbo].[20_okres] [o] ON [p].okres_kod = [o].okres_kod
    WHERE poradi_davky = 1
    GROUP BY [p].vekova_skupina, [p].okres_kod, [o].okres_nazev
)