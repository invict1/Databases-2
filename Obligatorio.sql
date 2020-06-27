drop table PARTIDA;
drop table TABLERO;
drop table TERRENO;
drop table POSICION_PARTIDA;
drop table EQUIPO;
drop table GUSANO;
drop table ARMA;
drop table ARMA_EQUIPO;

CREATE TABLE TABLERO (
    ID NUMBER (5) NOT NULL,
    MAX_Y NUMBER (3) NOT NULL,
    MAX_X NUMBER (3) NOT NULL,
    COORDENADA_X NUMBER (3) NOT NULL,
    COORDENADA_Y NUMBER (3) NOT NULL,

     CONSTRAINT PK_TABLERO PRIMARY KEY (ID)
);


CREATE TABLE PARTIDA (
    ID NUMBER (5) NOT NULL,
    DURACION NUMBER (2) NOT NULL,
    DIFICULLTAD VARCHAR (20) NOT NULL,
    TABLEROID NUMBER (5) REFERENCES TABLERO (ID),
    FINALIZADA NUMBER(1) NOT NULL,
    TURNO NUMBER (18) NOT NULL,

     CONSTRAINT PK_PARTIDA PRIMARY KEY (ID)
);

CREATE TABLE TERRENO (
    ID NUMBER (5) NOT NULL,
    TIPO  VARCHAR (15) NOT NULL,
    CONSTRAINT PK_TERRENO PRIMARY KEY (ID)
);

CREATE TABLE EQUIPO (
    ID NUMBER (5) PRIMARY KEY,
    NOMBRE VARCHAR (10) NOT NULL,
    PARTIDAID NUMBER (5) REFERENCES PARTIDA (ID),
    TIPO_JUGADOR VARCHAR (20),
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
    EQUIPOID NUMBER (5) NOT NULL,
    GUSANOID NUMBER (5)  NULL,
    TERRENOID NUMBER (5) NOT NULL,

     CONSTRAINT PK_CELDA_PARTIDA PRIMARY KEY (ID,COORDENADA_X,COORDENADA_Y,PARTIDAID),
     CONSTRAINT FK_PARTIDA FOREIGN KEY (PARTIDAID) REFERENCES PARTIDA(ID),
     CONSTRAINT FK_TERRENO FOREIGN KEY (TERRENOID) REFERENCES TERRENO(ID),
     CONSTRAINT FK_GUSANO FOREIGN KEY (GUSANOID,EQUIPOID) REFERENCES GUSANO(ID,EQUIPOID)
);

CREATE TABLE ARMA (
    ID NUMBER (5) NOT NULL,
    DMG NUMBER (5) NOT NULL,
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
--Restricciones

-- UN EQUIPO TIENE 8 GUSANOS
CREATE OR REPLACE TRIGGER MAXIMO_GUSANOS
BEFORE INSERT ON GUSANO
FOR EACH ROW
DECLARE
    CANTIDAD_GUSANO_EQUIPO NUMBER;
BEGIN
    SELECT COUNT(*) INTO CANTIDAD_GUSANO_EQUIPO
    FROM GUSANO G
    WHERE g.equipoid = :NEW.IDEQUIPO;
    
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
    FROM arma_equipo C
    WHERE c.equipoid = :NEW.IDEQUIPO;
    
    IF(CANTIDAD_ARMA_EQUIPO = 30)
    THEN RAISE_APPLICATION_ERROR(-4001, 'UN EQUIPO NO PUEDE TENER MAS DE 30 ARMAS');
    END IF;
END;

-- UN PARTIDA TIENE 4 EQUIPOS
CREATE OR REPLACE TRIGGER MAX_EQUIPOS_PARTIDA
BEFORE INSERT ON Equipo
FOR EACH ROW
DECLARE
    CANTIDAD_PARTIDA_EQUIPOS NUMBER;
BEGIN
    SELECT COUNT (*) INTO CANTIDAD_PARTIDA_EQUIPOS
    FROM Equipo e
    WHERE e.partidaid = :NEW.partidaid;
    
    IF(CANTIDAD_PARTIDA_EQUIPOS <> 4)
    THEN RAISE_APPLICATION_ERROR(-4003, 'UNA PARTIDA TIENE QUE TENER 4 EQUIPOS');
    END IF;
END;
