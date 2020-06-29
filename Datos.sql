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
insert into arma  values (4,100,'PISTOLA');
insert into arma  values (5,100,'A');
insert into arma  values (6,100,'B');
insert into arma  values (7,100,'C');
insert into arma  values (8,100,'D');
insert into arma  values (9,100,'E');
insert into arma  values (10,100,'F');
insert into arma  values (11,100,'G');
insert into arma  values (12,100,'H');
insert into arma  values (13,100,'I');
insert into arma  values (14,100,'J');
insert into arma  values (15,100,'K');
insert into arma  values (16,100,'L');
insert into arma  values (17,100,'M');
insert into arma  values (18,100,'N');
insert into arma  values (19,100,'O');
insert into arma  values (20,100,'P');
insert into arma  values (21,100,'Q');
insert into arma  values (22,100,'R');
insert into arma  values (23,100,'S');
insert into arma  values (24,100,'T');
insert into arma  values (24,100,'U');
insert into arma  values (26,100,'V');
insert into arma  values (27,100,'W');
insert into arma  values (28,100,'X');
insert into arma  values (29,100,'Y');
insert into arma  values (30,100,'Z');
insert into arma  values (31,100,'ARCO');

-------EQUIPO
INSERT INTO EQUIPO VALUES (1,'EQUIPO A',1,'H','W',0,0);
INSERT INTO EQUIPO VALUES (2,'EQUIPO B',1,'H','R',0,0);
INSERT INTO EQUIPO VALUES (3,'EQUIPO C',1,'M','L',0,0);
INSERT INTO EQUIPO VALUES (4,'EQUIPO D',1,'H','H',0,0);

--ARMAS_EQUIPO
insert into arma_equipo  values (1,1,1);
insert into arma_equipo  values (2,2,1);
insert into arma_equipo  values (3,3,1);
insert into arma_equipo  values (4,4,1);
insert into arma_equipo  values (5,5,1);
insert into arma_equipo  values (6,6,1);
insert into arma_equipo  values (7,7,1);
insert into arma_equipo  values (8,8,1);
insert into arma_equipo  values (9,9,1);
insert into arma_equipo  values (10,10,1);
insert into arma_equipo  values (11,11,1);
insert into arma_equipo  values (12,12,1);
insert into arma_equipo  values (13,13,1);
insert into arma_equipo  values (14,14,1);
insert into arma_equipo  values (15,15,1);
insert into arma_equipo  values (16,16,1);
insert into arma_equipo  values (17,17,1);
insert into arma_equipo  values (18,18,1);
insert into arma_equipo  values (19,19,1);
insert into arma_equipo  values (20,20,1);
insert into arma_equipo  values (21,21,1);
insert into arma_equipo  values (22,22,1);
insert into arma_equipo  values (23,23,1);
insert into arma_equipo  values (24,24,1);
insert into arma_equipo  values (25,25,1);
insert into arma_equipo  values (26,26,1);
insert into arma_equipo  values (27,27,1);
insert into arma_equipo  values (28,28,1);
insert into arma_equipo  values (29,29,1);
insert into arma_equipo  values (30,30,1);
insert into arma_equipo  values (31,2,1);
--insert into arma_equipo  values (25,25,1); PARA HACER SALTAR TRIGER MAXIMO_ARMA

-------GUSANO
INSERT INTO GUSANO VALUES (1,1,100);
INSERT INTO GUSANO VALUES (2,1,100);
INSERT INTO GUSANO VALUES (3,1,100);
INSERT INTO GUSANO VALUES (4,1,100);
INSERT INTO GUSANO VALUES (5,1,100);
INSERT INTO GUSANO VALUES (6,1,100);
INSERT INTO GUSANO VALUES (7,1,100);
INSERT INTO GUSANO VALUES (8,1,100);
--INSERT INTO GUSANO VALUES (77,1,100); PARA HACER SALTAR EL TRIGER MAXIMO_GUSANOS

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