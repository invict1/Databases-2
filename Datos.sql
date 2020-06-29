---Consultar datos:
SELECT * FROM TERRENO;
SELECT * FROM partida;
SELECT * FROM equipo;
SELECT * FROM GUSANO;
SELECT count(*) FROM TABLERO;
SELECT * FROM POSICION_PARTIDA;



--DATOS TERRENO
insert into terreno values ('T','TIERRA');
insert into terreno values ('A','AGUA');
insert into terreno values ('.','Aire');
insert into terreno values ('P','Piedra');
insert into terreno values ('B','Caja Bomba');
--------------insert partida
insert into partida  values (1,30,'DIFICIL','0','0');

--------------insert arma
insert into arma  values (1,100,'PISTOLA');
insert into arma  values (2,100,'TNT');
insert into arma  values (3,100,'BURRO');

-------EQUIPO
INSERT INTO EQUIPO VALUES (1,'EQUIPO A',1,'H','W',0,0);
INSERT INTO EQUIPO VALUES (2,'EQUIPO B',1,'H','R',0,0);
INSERT INTO EQUIPO VALUES (3,'EQUIPO C',1,'M','L',0,0);
INSERT INTO EQUIPO VALUES (4,'EQUIPO D',1,'H','H',0,0);
--ARMAS_EQUIPO
insert into arma_equipo  values (1,1,1);
insert into arma_equipo  values (2,2,1);

-------GUSANO
INSERT INTO GUSANO VALUES (1,1,100);
INSERT INTO GUSANO VALUES (2,1,100);
INSERT INTO GUSANO VALUES (3,1,100);
INSERT INTO GUSANO VALUES (4,1,100);
INSERT INTO GUSANO VALUES (5,1,100);
INSERT INTO GUSANO VALUES (6,1,100);
INSERT INTO GUSANO VALUES (7,1,100);
INSERT INTO GUSANO VALUES (8,1,100);

INSERT INTO GUSANO VALUES (9,2,100);
INSERT INTO GUSANO VALUES (10,2,100);
INSERT INTO GUSANO VALUES (11,2,100);
INSERT INTO GUSANO VALUES (12,2,100);
INSERT INTO GUSANO VALUES (13,2,100);
INSERT INTO GUSANO VALUES (14,2,100);
INSERT INTO GUSANO VALUES (15,2,100);
INSERT INTO GUSANO VALUES (16,2,100);

INSERT INTO GUSANO VALUES (17,3,100);
INSERT INTO GUSANO VALUES (18,3,100);
INSERT INTO GUSANO VALUES (19,3,100);
INSERT INTO GUSANO VALUES (20,3,100);
INSERT INTO GUSANO VALUES (21,3,100);
INSERT INTO GUSANO VALUES (22,3,100);
INSERT INTO GUSANO VALUES (23,3,100);
INSERT INTO GUSANO VALUES (24,3,100);

INSERT INTO GUSANO VALUES (25,4,100);
INSERT INTO GUSANO VALUES (26,4,100);
INSERT INTO GUSANO VALUES (27,4,100);
INSERT INTO GUSANO VALUES (28,4,100);
INSERT INTO GUSANO VALUES (29,4,100);
INSERT INTO GUSANO VALUES (30,4,100);
INSERT INTO GUSANO VALUES (31,4,100);
INSERT INTO GUSANO VALUES (32,4,100);

--DATOS TABLERO 15X50
--ejecutar SP POPULAR_TABLERO
EXEC POPULAR_TABLERO(1);
----------POS PARTIDA PARTIDA
EXEC POPULAR_PARTIDA(1);

----INSERTAR GUSANOS EN UNA PARTIDA


UPDATE  POSICION_PARTIDA SET EQUIPOID = '1', GUSANOID = '1'  WHERE coordenada_x=4 AND coordenada_y=5;
UPDATE  POSICION_PARTIDA SET EQUIPOID = '1', GUSANOID = '3'  WHERE coordenada_x= 22 AND coordenada_y=5;
UPDATE  POSICION_PARTIDA SET EQUIPOID = '2', GUSANOID = '9'  WHERE coordenada_x= 34 AND coordenada_y=5;
UPDATE  POSICION_PARTIDA SET EQUIPOID = '4', GUSANOID = '30' WHERE coordenada_x= 45 AND coordenada_y=5;

UPDATE  POSICION_PARTIDA SET EQUIPOID = '1', GUSANOID = '6'  WHERE coordenada_x= 5 AND coordenada_y=9;
UPDATE  POSICION_PARTIDA SET EQUIPOID = '4', GUSANOID = '28' WHERE coordenada_x= 35 AND coordenada_y=9;
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

---------------------------------
-- SP2 POPULAR LAS TODAS LAS CELDAS DE LA PARTIDA
create or replace NONEDITIONABLE PROCEDURE POPULAR_PARTIDA(
    p_partidaID in NUMERIC)
AS
indiceX NUMBER(3):=1;
indiceY NUMBER(3):=1;

BEGIN
    
     WHILE indiceX <51
        LOOP
           WHILE indiceY <16
            LOOP
               -- INSERT  INTO TABLERO  values (p_partidaID,indiceX,indiceY);
                 IF(indiceY <6)
                   THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'.');
                  END IF;
                IF(indiceY >=6 AND indiceY <8)
                   THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'T');
                  END IF;
                IF(indiceY >=8 AND indiceY <10)
                   THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'.');
                  END IF;
                 IF(indiceY >=10 AND indiceY <12)
                   THEN
                    IF (indiceX<=15)
                    THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'T');
                    END IF;
                    IF (indiceX >=30)
                    THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'T');
                    END IF;
                     IF ( indiceX >15 and indicex <30)
                    THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'.');
                    END IF;
                  END IF;   
                  IF(indiceY >12)
                   THEN
                     INSERT INTO  POSICION_PARTIDA VALUES (p_partidaID,indiceX,indiceY,1,1,NULL,NULL,'A');
                  END IF;
               
                indiceY:=indiceY + 1;
            END LOOP; 
            indiceY:=1;
            indiceX:=indiceX + 1;    
        END LOOP;

END POPULAR_PARTIDA;