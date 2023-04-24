CREATE OR ALTER VIEW [dbo].[30_prehled_proockovanost_okresy] AS
(
    SELECT
        SUM(pocet_davek) / CAST(
            (
                SELECT
                    SUM(pocet_obyvatel) FROM [20_okres] [i]
                WHERE [i].okres_kod = [p].okres_kod
            ) AS float
        ) AS pocet_davek_procent,
        SUM(pocet_davek) AS pocet_davek,
        [o].okres_nazev
    FROM [dbo].[20_prehled] [p]
    JOIN [dbo].[20_okres] [o] ON [p].okres_kod = [o].okres_kod
    WHERE poradi_davky = 1
    GROUP BY [p].poradi_davky, [p].okres_kod, [o].okres_nazev
)