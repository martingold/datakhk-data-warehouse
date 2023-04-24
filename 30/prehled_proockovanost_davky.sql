CREATE OR ALTER VIEW [dbo].[30_prehled_proockovanost_davky] AS
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
        [p].poradi_davky,
        [o].okres_nazev
    FROM [dbo].[20_prehled] [p]
    JOIN [dbo].[20_okres] [o] ON [p].okres_kod = [o].okres_kod
    GROUP BY [p].poradi_davky, [p].okres_kod, [o].okres_nazev
) UNION (
    SELECT
        1 - (SUM([p].pocet_davek) / CAST((
            SELECT
               SUM([i].pocet_obyvatel)
            FROM [20_okres] [i]
            WHERE [i].okres_kod = [p].okres_kod
        ) AS float)) AS pocet_davek_procent,
        (CAST((
            SELECT
               SUM([i].pocet_obyvatel)
            FROM [20_okres] [i]
            WHERE [i].okres_kod = [p].okres_kod
        ) AS float)) - SUM([p].pocet_davek) AS pocet_davek,
        0 AS poradi_davky,
        [o].okres_nazev
    FROM [20_prehled] [p]
        JOIN [dbo].[20_okres] [o] ON [p].okres_kod = [o].okres_kod
    WHERE poradi_davky = 1
    GROUP BY [p].poradi_davky, [p].okres_kod, [o].okres_nazev
)