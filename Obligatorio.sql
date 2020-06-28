drop table ARMA_EQUIPO;
drop table ARMA;
drop table POSICION_PARTIDA;
drop table GUSANO;
drop table EQUIPO;
drop table PARTIDA;
drop table TABLERO;
drop table TERRENO;


CREATE TABLE TABLERO (
    ID NUMBER (5) NOT NULL ,
    COORDENADA_X NUMBER (3) NOT NULL CHECK (COORDENADA_X > 0 AND COORDENADA_X < 51),
    COORDENADA_Y NUMBER (3) NOT NULL CHECK (COORDENADA_Y > 0 AND COORDENADA_Y < 16),

		CONSTRAINT PK_TABLERO PRIMARY KEY (ID,COORDENADA_X,COORDENADA_Y)
);


CREATE TABLE PARTIDA (
    ID NUMBER (5) NOT NULL,
    DURACION NUMBER (2) NOT NULL CHECK (DURACION IN ('15', '20', '30')),
    DIFICULTAD VARCHAR (20) NOT NULL CHECK (DIFICULTAD IN ('DIFICIL', 'INTERMEDIO', 'FACIL')),
    FINALIZADA NUMBER(1)  default 0 NOT NULL,
    TURNO NUMBER (18) NOT NULL,

		CONSTRAINT PK_PARTIDA PRIMARY KEY (ID)
);

CREATE TABLE TERRENO (
    ID  VARCHAR (1) NOT NULL CHECK (ID IN ('T', 'A', '.', 'P', 'B')),
    DESCRIPCION  VARCHAR (15) NOT NULL,
    CONSTRAINT PK_TERRENO PRIMARY KEY (ID)
 );

CREATE TABLE EQUIPO (
    ID NUMBER (5) PRIMARY KEY,
    NOMBRE VARCHAR (10) NOT NULL,
    PARTIDAID NUMBER (5) REFERENCES PARTIDA (ID),
    TIPO_JUGADOR VARCHAR (20) NOT NULL CHECK (TIPO_JUGADOR IN ('H', 'M')),
    LETRA_GUSANO VARCHAR (1),
    ASESINATOS NUMBER (2),
    MUERTES NUMBER (2)
);

CREATE TABLE GUSANO (
    ID NUMBER (5) NOT NULL,
    EQUIPOID NUMBER (5) NOT NULL, 
    VIDA NUMBER (3) DEFAULT 100, 

		CONSTRAINT PK_Gusano PRIMARY KEY (ID, EQUIPOID),
		CONSTRAINT FK_EQUIPOID FOREIGN KEY (EQUIPOID) REFERENCES EQUIPO(ID)
);


CREATE TABLE POSICION_PARTIDA (
    ID  NUMBER (3) NOT NULL,
    COORDENADA_X NUMBER (3) NOT NULL,
    COORDENADA_Y NUMBER (3) NOT NULL,
    PARTIDAID NUMBER (5) NOT NULL,
    TABLEROID NUMBER (5) NOT NULL,
    EQUIPOID NUMBER (5)  NULL,
    GUSANOID NUMBER (5)  NULL,
    TERRENOID VARCHAR (1) NOT NULL,

		CONSTRAINT PK_CELDA_PARTIDA PRIMARY KEY (ID,COORDENADA_X,COORDENADA_Y,PARTIDAID),
		CONSTRAINT FK_PARTIDA FOREIGN KEY (PARTIDAID) REFERENCES PARTIDA(ID),
		CONSTRAINT FK_TERRENO FOREIGN KEY (TERRENOID) REFERENCES TERRENO(ID),
		CONSTRAINT FK_TABLERO FOREIGN KEY (TABLEROID,COORDENADA_X,COORDENADA_Y) REFERENCES TABLERO(ID,COORDENADA_X,COORDENADA_Y),
		CONSTRAINT FK_GUSANO FOREIGN KEY (GUSANOID,EQUIPOID) REFERENCES GUSANO(ID,EQUIPOID)
);

CREATE TABLE ARMA (
    ID NUMBER (5) NOT NULL,
    DMG NUMBER (5) DEFAULT 100,
    NOMBRE VARCHAR (25) NOT NULL,
  
		CONSTRAINT PK_ARMA PRIMARY KEY (ID)
);


CREATE TABLE ARMA_EQUIPO (
    ID NUMBER (5) NOT NULL,
    ARMAID NUMBER (5) NOT NULL,
    EQUIPOID NUMBER (5) NOT NULL,
 
    CONSTRAINT PK_ARMA_EQUIPO PRIMARY KEY (ID,ARMAID,EQUIPOID),
    CONSTRAINT FK_ARMA_EQUIPOID FOREIGN KEY (EQUIPOID) REFERENCES EQUIPO(ID),
    CONSTRAINT FK_ARMA FOREIGN KEY (ARMAID) REFERENCES ARMA(ID)
);
----------------------------------
-- Restricciones - Triggers

-- UN EQUIPO TIENE 8 GUSANOS
CREATE OR REPLACE TRIGGER MAXIMO_GUSANOS
BEFORE INSERT ON GUSANO
FOR EACH ROW
DECLARE
    CANTIDAD_GUSANO_EQUIPO NUMBER;
BEGIN
    SELECT COUNT(*) INTO CANTIDAD_GUSANO_EQUIPO
    FROM GUSANO G
    WHERE G.EQUIPOID = :NEW.EQUIPOID;
    
    IF(CANTIDAD_GUSANO_EQUIPO = 8)
    THEN RAISE_APPLICATION_ERROR(-4000, 'UN EQUIPO NO PUEDE TENER MAS DE 8 GUSANOS');
    END IF;
END;

-- UN EQUIPO TIENE 30 ARMAS
CREATE OR REPLACE TRIGGER MAXIMO_ARMA
BEFORE INSERT ON EQUIPO_ARMA
FOR EACH ROW
DECLARE
    CANTIDAD_ARMA_EQUIPO NUMBER;
BEGIN
    SELECT COUNT(*) INTO CANTIDAD_ARMA_EQUIPO
    FROM ARMA_EQUIPO C
    WHERE C.EQUIPOID = :NEW.IDEQUIPO;
    
    IF(CANTIDAD_ARMA_EQUIPO = 30)
    THEN RAISE_APPLICATION_ERROR(-4001, 'UN EQUIPO NO PUEDE TENER MAS DE 30 ARMAS');
    END IF;
END;

-- UN PARTIDA TIENE 4 EQUIPOS
CREATE OR REPLACE TRIGGER MAX_EQUIPOS_PARTIDA
BEFORE INSERT ON EQUIPO
FOR EACH ROW
DECLARE
    CANTIDAD_PARTIDA_EQUIPOS NUMBER;
BEGIN
    SELECT COUNT (*) INTO CANTIDAD_PARTIDA_EQUIPOS
    FROM EQUIPO E
    WHERE E.PARTIDAID = :NEW.PARTIDAID;
    
    IF(CANTIDAD_PARTIDA_EQUIPOS <> 4)
    THEN RAISE_APPLICATION_ERROR(-4002, 'UNA PARTIDA TIENE QUE TENER 4 EQUIPOS');
    END IF;
END;

-- UN PARTIDA TIENE AL MENOS 1 JUGADOR HUMANO
CREATE OR REPLACE TRIGGER MIN_HUMANOS_PARTIDA
AFTER INSERT ON EQUIPO
FOR EACH ROW
DECLARE
    CANTIDAD_HUMANOS_PARTIDA NUMBER;
BEGIN
    SELECT COUNT (*) INTO CANTIDAD_HUMANOS_PARTIDA
    FROM EQUIPO E
    WHERE E.PARTIDAID = :NEW.PARTIDAID
		AND E.TIPO_JUGADOR = 'H';
    
    IF(CANTIDAD_HUMANOS_PARTIDA = 0)
    THEN RAISE_APPLICATION_ERROR(-4003, 'UNA PARTIDA TIENE QUE TENER AL MENOS 1 JUGADOR HUMANO');
    END IF;
END;

-- A UN EQUIPO SOLO SE LE PUEDE ASIGNAR UNA PARTIDA SI POSEE ENTRE 1 y 30 ARMAS
CREATE OR REPLACE TRIGGER ASIGNAR_EQUIPO_PARTIDA
BEFORE UPDATE ON EQUIPO
FOR EACH ROW
DECLARE
    CANTIDAD_ARMA_EQUIPO NUMBER;
BEGIN
    SELECT COUNT(*) INTO CANTIDAD_ARMA_EQUIPO
    FROM ARMA_EQUIPO A
    WHERE A.EQUIPOID = :NEW.ID;
    
    IF(CANTIDAD_ARMA_EQUIPO = 0)
    THEN RAISE_APPLICATION_ERROR(-4005, 'A UN EQUIPO SOLO SE LE PUEDE ASIGNAR UNA PARTIDA SI POSEE ENTRE 1 y 30 ARMAS');
    END IF;
END;

/*Fin Triggers*/


/*Procedures*/
/*1
Proveer un servicio que dada una partida muestre en pantalla los datos del terreno.*/create or replace procedure  MOSTRAR_TABLERO_PARTIDA(
    p_partidaID in NUMERIC)
AS
indiceX NUMBER(3):=1;
indiceY NUMBER(3):=1;
auxTerreno varchar(1);
auxGusano  varchar (5);
CURx SYS_REFCURSOR;
CURy SYS_REFCURSOR;


BEGIN

      OPEN CURy FOR 
       SELECT DISTINCT (COORDENADA_Y)  FROM posicion_partida WHERE ID=p_partidaid order by coordenada_y asc;
       LOOP 
        FETCH CURy INTO indiceY; 
        dbms_output.put_line('');
             OPEN CURx FOR SELECT COORDENADA_X FROM posicion_partida WHERE COORDENADA_Y=indiceY and ID=p_partidaID order by coordenada_x asc,coordenada_y asc;
             LOOP
              FETCH CURx INTO indiceX;
                 EXIT WHEN CURx %NOTFOUND; 
                   select p.terrenoid,e.letra_gusano into auxTerreno,auxGusano 
                   FROM posicion_partida p 
                   LEFT join GUSANO g on g.id = p.gusanoid
                   LEFT join equipo e on e.id = g.equipoid
                   WHERE COORDENADA_X=indiceX and p.id=p_partidaID AND COORDENADA_Y=indiceY;
                   IF(auxGusano IS NOT NULL)
                   THEN
                    DBMS_OUTPUT.PUT(auxGusano);
                   ELSE
                   DBMS_OUTPUT.PUT(auxTerreno);
                  END IF;
             
             END LOOP;
        EXIT WHEN CURy %NOTFOUND;   
        END LOOP;
        
END MOSTRAR_TABLERO_PARTIDA;
/*2
Proveer un servicio que dado un gusano y una posición en el contexto de una partida, ubique al gusano en la posición, si es posible. */

create or replace NONEDITIONABLE PROCEDURE MOVER_GUSANO(
    p_partidaID in NUMERIC,
    p_gusID in NUMERIC,
    p_cordX in NUMERIC,
    p_cordy in NUMERIC   
    )
AS
indiceX NUMBER(3):=1;
indiceY NUMBER(3):=1;

auxTerreno varchar(1);
auxGusano  varchar (5);
auxeQUIPO  NUMERIC (5);



BEGIN
    --obtener pos origen
    select coordenada_x,coordenada_y,equipoid into indiceX,indicey,auxeQUIPO from posicion_partida where gusanoid =p_gusid;
    
    --MOVER
    select p.terrenoid,p.gusanoid into auxTerreno,auxGusano from posicion_partida p where p.coordenada_x=p_cordx and p.coordenada_y=p_cordy ;
          
         IF(auxTerreno = '.' AND  auxGusano IS NULL)   
         THEN
              update posicion_partida p set gusanoid=p_gusID , p.equipoid=auxeQUIPO 
                  where   p.id=p_partidaID and p.coordenada_x=p_cordX and p.coordenada_y=p_cordy ;
            
                 ---LUEGO DE MOVER
        
                update posicion_partida p set gusanoid=null , p.equipoid=null 
                 where   p.id=p_partidaID and p.coordenada_x=indicex and p.coordenada_y=indicey ;
         END IF;
    
    mostrar_tablero_partida(p_partidaID);
        
END MOVER_GUSANO;
/*3
Proveer un servicio que dada una posición horizontal, en el contexto de una partida, “suelte” el arma del burro.*/
create or replace NONEDITIONABLE PROCEDURE TIRAR_BURRO(
    p_partidaID in NUMERIC,
    p_PosX in NUMERIC,
    p_PosY in NUMERIC)
AS
indiceX NUMBER(3):=1;
indiceY NUMBER(3):=1;
auxGusanoId NUMBER(3);
auxTerreno varchar(1);
auxGusano  varchar (5);
desde NUMBER (3);
hasta NUMBER (3);

CURx SYS_REFCURSOR;
CURy SYS_REFCURSOR;


BEGIN
dbms_output.put_line('TABLERO ANTES DEL BURRO:');
dbms_output.put_line('////////////////////////');
      MOSTRAR_TABLERO_PARTIDA(p_partidaID);
      
      desde:=p_posx-2;
      hasta:=p_posx+2;
      
      OPEN CURy FOR 
       SELECT DISTINCT (COORDENADA_Y)  FROM posicion_partida WHERE ID=p_partidaid order by coordenada_y asc;
       LOOP 
        FETCH CURy INTO indiceY; 
             OPEN CURx FOR SELECT COORDENADA_X FROM posicion_partida WHERE COORDENADA_Y=indiceY and ID=p_partidaID order by coordenada_x asc,coordenada_y asc;
             LOOP
              FETCH CURx INTO indiceX;
                 EXIT WHEN CURx %NOTFOUND; 
                  
                   select p.terrenoid,e.letra_gusano,p.gusanoid into auxTerreno,auxGusano,auxGusanoId 
                   FROM posicion_partida p 
                   LEFT join GUSANO g on g.id = p.gusanoid
                   LEFT join equipo e on e.id = g.equipoid
                   WHERE COORDENADA_X=indiceX and p.id=p_partidaID AND COORDENADA_Y=indiceY;
                  
                   IF( indiceX >= desde AND indiceX<=hasta and auxTerreno <> 'A' )
                   THEN             
                    
                    update posicion_partida p set gusanoid=null , p.equipoid=null, p.terrenoid='.'
                    where  p.id=p_partidaID and p.coordenada_x=indiceX and p.coordenada_y=indiceY;
                    
                    update gusano g set vida=0 where g.id= auxGusanoId; 
                  
                   END IF;
                   
             END LOOP;
        EXIT WHEN CURy %NOTFOUND;   
        END LOOP;
      
      
 dbms_output.put_line('');       
dbms_output.put_line('//////////////////////////');
dbms_output.put_line('TABLERO DESPUES DEL BURRO:');
dbms_output.put_line('');
      MOSTRAR_TABLERO_PARTIDA(p_partidaID);
END TIRAR_BURRO;

/*4
Proveer un servicio que retorne el resumen de la partida, que será invocado por la aplicación cuando finalice.*/
CREATE OR REPLACE PROCEDURE ESTADISTICA_PARTIDA(PARTIDA INT) IS

        CURSOR RESUMEN_PARTIDA(PARTIDA INT) IS
            SELECT E.EQUIPO AS NOMBRE, E.ASESINATOS AS ASESINATOS, E.MUERTES AS MUERTES
            FROM EQUIPO E
            WHERE E.PARTIDAID = PARTIDA
            ORDER BY E.ASESINATOS DESC;

        RESUMENPARTIDA RESUMEN_PARTIDA%ROWTYPE;
BEGIN

    OPEN RESUMEN_PARTIDA(PARTIDA);
    FETCH RESUMEN_PARTIDA INTO RESUMENPARTIDA;

          WHILE RESUMEN_PARTIDA%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('NUMERO JUGADOR = ' || RESUMENPARTIDA.NOMBRE ||
                               ', ASESINATOS = ' || RESUMENPARTIDA.ASESINATOS ||
							   ', MUERTES = ' || RESUMENPARTIDA.MUERTES);
            FETCH RESUMEN_PARTIDA INTO RESUMENPARTIDA;
          END LOOP;
    CLOSE RESUMEN_PARTIDA;
END ESTADISTICA_PARTIDA;

/*5
Proveer un servicio que reciba por parámetro una partida y la elimine de modo que no quede registro de sus datos relacionados, como si no hubiera existido.*/
CREATE OR REPLACE PROCEDURE BORRAR_PARTIDA(PARTIDA INT) IS

  CURSOR OBTENER_EQUIPO(PARTIDA INT) IS
    SELECT E.ID
    FROM EQUIPO E
    WHERE E.PARTIDAID = PARTIDA;
	
	ROWEQUIPO OBTENER_EQUIPO%ROWTYPE;

HAY_GUSANO INT;

BEGIN
    OPEN OBTENER_EQUIPO(PARTIDA);
    FETCH OBTENER_EQUIPO INTO EQUIPO;
    SELECT COUNT(*) INTO HAY_GUSANO FROM GUSANO G WHERE G.EQUIPOID = EQUIPO.ID;
    SAVEPOINT PUNTO_PARTIDA;

    IF (HAY_GUSANO > 0) THEN
        DELETE FROM GUSANO G WHERE G.EQUIPOID = EQUIPO.ID;
    END IF;

	DELETE FROM EQUIPO EQ WHERE EQ.PARTIDAID = PARTIDA;
    DELETE FROM PARTIDA P WHERE P.ID = PARTIDA;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO PUNTO_PARTIDA;
    COMMIT;
END BORRAR_PARTIDA;
