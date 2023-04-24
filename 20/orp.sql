DROP TABLE IF EXISTS [dbo].[20_orp];

CREATE TABLE [dbo].[20_orp] (
     orp_kod nvarchar(10),
     orp_nazev nvarchar(300),
     pocet_obyvatel int
);

INSERT INTO [dbo].[20_orp]
SELECT DISTINCT
   orp_kod,
   orp_nazev
FROM [00_pocet_obyvatel]