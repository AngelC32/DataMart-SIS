USE MASTER
GO
DROP DATABASE IF EXISTS DM_SIS;
CREATE DATABASE DM_SIS;
GO
USE DM_SIS;
CREATE TABLE DIM_LUGAR(
	SK_LUGAR INT NOT NULL IDENTITY(1,1)
	,NOMBRE_REGION VARCHAR(50)
	,NOMBRE_PROVINCIA VARCHAR(50)
	,NOMBRE_DISTRITO VARCHAR(50)
	,UBIGEO VARCHAR(6)
	PRIMARY KEY(SK_LUGAR)
);

CREATE TABLE DIM_IPRESS(
	SK_IPRESS INT NOT NULL IDENTITY(1,1)
	,COD_UNIDAD_EJECUTORA VARCHAR(4) NOT NULL
	,NOMBRE_UNIDAD_EJECUTORA VARCHAR(100)
	,AMBITO_INEI VARCHAR(10) NOT NULL
	,CODIGO_IPRESS VARCHAR(10) NOT NULL
	,NOMBRE_IPRESS VARCHAR(100)
	PRIMARY KEY(SK_IPRESS)
);

CREATE TABLE DIM_PLAN_DE_SEGURO(
	SK_PLAN_DE_SEGURO INT NOT NULL IDENTITY(1,1)
	,REGIMEN_FINANCIAMIENTO VARCHAR(20) NOT NULL
	,NOMBRE_PLAN_DE_SEGURO VARCHAR(20)
	PRIMARY KEY(SK_PLAN_DE_SEGURO)
);

CREATE TABLE DIM_NACIONALIDAD(
	SK_NACIONALIDAD INT NOT NULL IDENTITY(1,1)
	,NACIONAL_EXTRANJERO VARCHAR(10) NOT NULL
	,PAIS_EXTRANJERO VARCHAR(50)
	,DOCUMENTO_IDENTIDAD VARCHAR(36)
	PRIMARY KEY(SK_NACIONALIDAD)
);
CREATE TABLE DIM_EDAD(
	SK_EDAD INT NOT NULL IDENTITY(1,1)
	,EDAD VARCHAR(4)
	PRIMARY KEY(SK_EDAD)
)
;
ALTER TABLE [DM_SIS].[dbo].[DIM_EDAD]
ADD Rango_edad AS
CASE 
	WHEN (0<=edad AND edad<=10) THEN '[1-10]'
	WHEN (11<=edad AND edad<=20)THEN '[11-20]' 
	WHEN (21<=edad AND edad<=30)THEN '[21-30]' 
	WHEN (31<=edad AND edad<=40)THEN '[31-40]'
	WHEN (41<=edad AND edad<=50)THEN '[41-50]'
	WHEN (51<=edad AND edad<=60)THEN '[51-60]'
	WHEN (61<=edad AND edad<=70)THEN '[61-70]'
	WHEN (71<=edad AND edad<=80)THEN '[71-80]'
	WHEN (81<=edad AND edad<=90)THEN '[81-90]'
	WHEN (91<=edad AND edad<=100)THEN '[91-100]'
	WHEN (101<=edad AND edad<=110)THEN '[101-110]'
	WHEN (111<=edad AND edad<=120)THEN '[111-120]'
	WHEN (121<=edad AND edad<=130)THEN '[121-130]'
	ELSE NULL
END
CREATE TABLE DIM_SEXO(
	SK_SEXO INT NOT NULL IDENTITY(1,1)
	,SEXO VARCHAR(10)
	PRIMARY KEY(SK_SEXO)
)
;
CREATE TABLE FACT_AFILIADOS(
	SK_LUGAR INT NOT NULL
	,SK_IPRESS INT NOT NULL
	,SK_PLAN_DE_SEGURO INT NOT NULL
	,SK_NACIONALIDAD INT NOT NULL
	,SK_EDAD INT NOT NULL
	,SK_SEXO INT NOT NULL
	,TOTAL_AFILIADOS INT
	,FOREIGN KEY(SK_LUGAR)
	REFERENCES DIM_LUGAR(SK_LUGAR)
	,FOREIGN KEY(SK_IPRESS)
	REFERENCES DIM_IPRESS(SK_IPRESS)
	,FOREIGN KEY(SK_NACIONALIDAD)
	REFERENCES DIM_NACIONALIDAD(SK_NACIONALIDAD)
	,FOREIGN KEY(SK_PLAN_DE_SEGURO)
	REFERENCES DIM_PLAN_DE_SEGURO(SK_PLAN_DE_SEGURO)
	,FOREIGN KEY(SK_EDAD)
	REFERENCES DIM_EDAD(SK_EDAD)
	,FOREIGN KEY(SK_SEXO)
	REFERENCES DIM_SEXO(SK_SEXO)
);