--DATOS TERRENO
insert into terreno values ('T','TIERRA');
insert into terreno values ('A','AGUA');
insert into terreno values ('.','Aire');
insert into terreno values ('P','Piedra');
insert into terreno values ('B','Caja Bomba');

SELECT * FROM TERRENO;

--DATOS TABLERO 15X50
--ejecutar SP POPULAR_TABLERO
SELECT count(*) FROM TABLERO;


--------------insert partida
insert into partida  values (1,30,'DIFICIL','0','0');

SELECT * FROM partida;

-------EQUIPO
INSERT INTO EQUIPO VALUES (1,'EQUIPO A',1,'H','W',0,0);
INSERT INTO EQUIPO VALUES (2,'EQUIPO B',1,'H','R',0,0);
INSERT INTO EQUIPO VALUES (3,'EQUIPO C',1,'M','L',0,0);
INSERT INTO EQUIPO VALUES (4,'EQUIPO D',1,'H','H',0,0);

SELECT * FROM equipo;


----------POS PARTIDA PARTIDA
INSERT INTO  POSICION_PARTIDA VALUES (1,1,1,1,1,2,NULL,'.');
INSERT INTO  POSICION_PARTIDA VALUES (1,1,2,1,1,2,NULL,'.');
INSERT INTO  POSICION_PARTIDA VALUES (1,1,3,1,1,4,NULL,'.');
INSERT INTO  POSICION_PARTIDA VALUES (1,1,4,1,1,2,NULL,'.');
INSERT INTO  POSICION_PARTIDA VALUES (1,2,1,1,1,2,NULL,'T');
INSERT INTO  POSICION_PARTIDA VALUES (1,2,2,1,1,4,NULL,'T');
INSERT INTO  POSICION_PARTIDA VALUES (1,2,3,1,1,2,NULL,'T');
INSERT INTO  POSICION_PARTIDA VALUES (1,2,4,1,1,2,NULL,'T');
INSERT INTO  POSICION_PARTIDA VALUES (1,3,1,1,1,4,NULL,'A');
INSERT INTO  POSICION_PARTIDA VALUES (1,3,2,1,1,2,NULL,'A');
INSERT INTO  POSICION_PARTIDA VALUES (1,3,3,1,1,2,NULL,'A');
INSERT INTO  POSICION_PARTIDA VALUES (1,3,4,1,1,4,NULL,'A');

SELECT * FROM POSICION_PARTIDA ORDER BY coordenada_x ASC,coordenada_y ASC;



-------SP  PARA CARGAR DATOS

--1 POPULAR TABLERO
CREATE or replace NONEDITIONABLE PROCEDURE POPULAR_TABLERO(
    p_partidaID in NUMERIC)
AS
indiceX NUMBER(3):=1;
indiceY NUMBER(3):=1;

BEGIN
    
     WHILE indiceX <51
        LOOP
           WHILE indiceY <16
            LOOP
                INSERT  INTO TABLERO  values (p_partidaID,indiceX,indiceY);
                indiceY:=indiceY + 1;
            END LOOP; 
            indiceY:=1;
            indiceX:=indiceX + 1;    
        END LOOP;

END POPULAR_TABLERO;





