DROP TABLE IF EXISTS [dbo].[20_vakcina];

CREATE TABLE [dbo].[20_vakcina] (
     vakcina_kod nvarchar(10),
     vakcina nvarchar(50),
);

INSERT INTO [dbo].[20_vakcina]
SELECT DISTINCT vakcina_kod, vakcina FROM [00_prehled]

