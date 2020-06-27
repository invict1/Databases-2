--DATOS TERRENO
insert into terreno values ('T','TIERRA');
insert into terreno values ('A','AGUA');
insert into terreno values ('.','Aire');
insert into terreno values ('P','Piedra');
insert into terreno values ('B','Caja Bomba');

SELECT * FROM TERRENO;

--DATOS TABLERO 15X150
INSERT  INTO TABLERO  values (1,1,1);
INSERT  INTO TABLERO  values (1,1,2);
INSERT  INTO TABLERO  values (1,1,3);

SELECT * FROM TABLERO;


--------------insert partida
insert into partida  values (1,30,'MEDIA','0','0');

SELECT * FROM partida;

-------EQUIPO
INSERT INTO EQUIPO VALUES (1,'EQUIPO A',1,'H','W',0,0);
INSERT INTO EQUIPO VALUES (2,'EQUIPO B',1,'H','R',0,0);
INSERT INTO EQUIPO VALUES (3,'EQUIPO C',1,'M','L',0,0);
INSERT INTO EQUIPO VALUES (4,'EQUIPO D',1,'H','H',0,0);

SELECT * FROM equipo;


----------POS PARTIDA
INSERT INTO  POSICION_PARTIDA VALUES (1,1,1,1,1,2,NULL,'A');
INSERT INTO  POSICION_PARTIDA VALUES (1,1,2,1,1,2,NULL,'A');
INSERT INTO  POSICION_PARTIDA VALUES (1,1,3,1,1,4,NULL,'T');

select * from posicion_partida;













