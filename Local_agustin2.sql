INSERT INTO TB_CATEGORIAS (CODIGO_CA, DESCRIPCION_CA) VALUES(2, 'HOGARES');
INSERT INTO TB_CATEGORIAS (CODIGO_CA, DESCRIPCION_CA) VALUES(3, 'EVENTOS');

INSERT INTO TB_MEDIDAS (CODIGO_ME, ABREVIATURA_ME, DESCRIPCION_ME) VALUES(1, 'UND', 'UNIDADES');
INSERT INTO TB_MEDIDAS (CODIGO_ME, ABREVIATURA_ME, DESCRIPCION_ME) VALUES(2, 'KGS', 'KILOGRAMOS');
INSERT INTO TB_MEDIDAS (CODIGO_ME, ABREVIATURA_ME, DESCRIPCION_ME) VALUES(3, 'MTS', 'METROS');
INSERT INTO TB_MEDIDAS (CODIGO_ME, ABREVIATURA_ME, DESCRIPCION_ME) VALUES(4, 'LTS', 'LISTROS');

INSERT INTO TB_ARTICULOS (CODIGO_AR, DESCRIPCION_AR, MARCA_AR, CODIGO_ME, CODIGO_CA) 
    VALUES(1, 'COMPUTADORA', 'DELL', 1, 1);
INSERT INTO TB_ARTICULOS (CODIGO_AR, DESCRIPCION_AR, MARCA_AR, CODIGO_ME, CODIGO_CA) 
    VALUES(3, 'HOLADERA', 'LG', 1, 2);
INSERT INTO TB_ARTICULOS (CODIGO_AR, DESCRIPCION_AR, MARCA_AR, CODIGO_ME, CODIGO_CA) 
    VALUES(4, 'MICROONDAS', 'LG', 1, 2);
INSERT INTO TB_ARTICULOS (CODIGO_AR, DESCRIPCION_AR, MARCA_AR, CODIGO_ME, CODIGO_CA) 
    VALUES(5, 'MEDA EVENTO', 'ESTANDAR', 1, 3);
INSERT INTO TB_ARTICULOS (CODIGO_AR, DESCRIPCION_AR, MARCA_AR, CODIGO_ME, CODIGO_CA) 
    VALUES(6, 'ESCRITORIO', 'ESTANDAR', 1, 1);
    
UPDATE tb_articulos SET MARCA_AR = 'CANON' WHERE codigo_ar = 2; 
UPDATE tb_articulos SET MARCA_AR = 'SAMSUNG' WHERE codigo_ar IN (3,4); 
UPDATE tb_articulos SET descripcion_ar = CONCAT('* ',descripcion_ar) WHERE marca_ar = 'ESTANDAR'; 

delete from tb_articulos where codigo_ar in (5,6);
delete from tb_articulos where codigo_ar > 4;
delete from tb_articulos where marca_ar = 'ESTANDAR';

DELETE FROM TB_MEDIDAS WHERE CODIGO_ME in (3,4);

select * from tb_medidas;
select codigo_ar, descripcion_ar, marca_ar from tb_articulos where codigo_ca = 2;
select * from tb_articulos where marca_ar in ('LENOVO', 'CANON');
select * from tb_articulos where NOT marca_ar in ('LENOVO', 'CANON');
select * from tb_articulos where descripcion_ar like 'H%';

create table tb_notas_alumnos(codigo_al number(3,0),
                                nombre_al varchar2(50),
                                curso varchar2(30),
                                nota1 number (2,0),
                                nota2 number (2,0),
                                nota3 number (2,0),
                                promedio number (5,2));

select * from tb_notas_alumnos;

insert into tb_notas_alumnos values(1, 'Homero', 'Matermatica', 13, 14, 17, 0);
insert into tb_notas_alumnos values(2, 'Maria', 'Matermatica', 15, 6, 17, 0);
insert into tb_notas_alumnos values(3, 'Roberto', 'Matermatica', 15, 6, 17, 0);

select codigo_al, nombre_al, curso, nota1+nota2+nota3 from tb_notas_alumnos;
select codigo_al, nombre_al, curso, round((nota1+nota2+nota3)/3 , 2) as promedio from tb_notas_alumnos;
update tb_notas_alumnos set promedio = ROUND((nota1 + nota2 + nota3) / 3, 2);

select codigo_al, nombre_al || '-' || curso as nombre_curso from tb_notas_alumnos;
select codigo_al, nombre_al, curso, nota1, nota2, nota3 from tb_notas_alumnos where (nota1 > 5 and nota2 >10);

select lpad('VICTOR', 10, 'X') FROM DUAL;
SELECT CONCAT('BOL-', LPAD('5', 5, '0')) FROM DUAL;
SELECT CONCAT('BOL-', LPAD('17', 5, '0')) FROM DUAL;
SELECT RPAD('HOLA', 10, 'X') FROM DUAL;
SELECT CONCAT(RPAD('P-', 10, '0'), '23') FROM DUAL;
select concat(rtrim('hola      '),ltrim('    prueba')) from dual;
select replace('hola///hola2//435', '/', '#') from dual;
select UPPER(substr('curso de oracle db', 10, 9)) from dual;
select LENGTH('CURSO DE ORACLE DB') from dual;
select INSTR('CURSO DE ORACLE DB', 'ORACLE') from dual;
select LOWER(TRANSLATE('CURSO DE ORACLE DB', 'EOS', '305')) from dual;

select mod(18, 5) from dual; --resto de la division
select sum(codigo_ar) as suma_total from tb_articulos;
select MAX(codigo_ar) from tb_articulos;
select AVG(codigo_ar) from tb_articulos;

SELECT CURRENT_DATE FROM DUAL;
SELECT ADD_MONTHS(CURRENT_DATE, 1) FROM DUAL;
SELECT ADD_MONTHS('01/01/2000', 1) FROM DUAL;
SELECT LAST_DAY('01/01/2000') FROM DUAL;
SELECT MONTHS_BETWEEN('01/01/2005','01/01/2002') FROM DUAL;
SELECT NEXT_DAY('01/01/2000', 'MARTES') FROM DUAL;
select systimestamp from dual;
select current_timestamp from dual;
select extract(month from sysdate) from dual;
select concat(to_char(sysdate), ' Fecha del sistema') from dual;
select to_date('19/02/2023')-5 from dual;

UPDATE tb_articulos SET ACTIVO = 1, STOCK_ACTUAL = 0, fecha_registro = SYSDATE;

select 
    tb_categorias.codigo_ca,
    tb_categorias.descripcion_ca,
    tb_articulos.descripcion_ar,
    tb_articulos.marca_ar
from 
    tb_categorias
left join 
    tb_articulos on tb_categorias.codigo_ca = tb_articulos.codigo_ca;

select
    ar.codigo_ar,
    ar.descripcion_ar,
    ar.marca_ar,
    me.descripcion_me
from 
    tb_articulos ar
right join 
    tb_medidas me on ar.codigo_me = me.codigo_me;

select * from tb_articulos order by marca_ar desc, descripcion_ar desc;

select 
    tb_articulos.codigo_ar, 
    tb_articulos.descripcion_ar, 
    tb_articulos.marca_ar,
    tb_medidas.descripcion_me,
    tb_categorias.descripcion_ca,
    tb_articulos.stock_actual,
    tb_articulos.fecha_registro
from 
    tb_articulos
inner join 
    tb_categorias on tb_articulos.codigo_ca = tb_categorias.codigo_ca
inner join 
    tb_medidas on tb_articulos.codigo_me = tb_medidas.codigo_me;

create view vista_articulos as 
select 
    tb_articulos.codigo_ar, 
    tb_articulos.descripcion_ar, 
    tb_articulos.marca_ar,
    tb_medidas.descripcion_me,
    tb_categorias.descripcion_ca,
    tb_articulos.stock_actual,
    tb_articulos.fecha_registro
from 
    tb_articulos
inner join 
    tb_categorias on tb_articulos.codigo_ca = tb_categorias.codigo_ca
inner join 
    tb_medidas on tb_articulos.codigo_me = tb_medidas.codigo_me
order by 
    tb_articulos.codigo_ar;

select * from vista_articulos;

select 
    cat.descripcion_ca,
    count(art.descripcion_ar) as total_articulo
from 
    tb_categorias cat
inner join
    tb_articulos art on art.codigo_ca = cat.codigo_ca
group by cat.descripcion_ca;

select 
    marca_ar,
    count(descripcion_ar) as total_articulos
from 
    tb_articulos
group by 
    tb_articulos.marca_ar;

select curso,
    sum(nota1) as total_suma_nota1
from tb_notas_alumnos
group by curso;

create procedure insertar_un_registro_me
as
begin
    insert into tb_medidas(codigo_me,
                            abreviatura_me,
                            descripcion_me)
    values(3, 'LT', 'LITROS');
    commit;
end;

execute insertar_un_registro_me;

create procedure crud_medidas_categorias
as
begin
    insert into tb_medidas(codigo_me,abreviatura_me,descripcion_me)
        values(4, 'MT', 'METROS');
    UPDATE TB_CATEGORIAS SET descripcion_ca = 'EVENTOS 2023' WHERE CODIGO_CA = 3;
    commit;
end;

execute crud_medidas_categorias;

create procedure ACTUALIZAR_CA(pCodigo in int, pDescripcion in varchar2)
as
begin
    UPDATE TB_CATEGORIAS SET DESCRIPCION_CA = pDescripcion where CODIGO_CA = pCodigo;
end;

create OR REPLACE procedure ACTUALIZAR_CA(pCodigo in int, pDescripcion in varchar2)
as
begin
    UPDATE TB_CATEGORIAS SET DESCRIPCION_CA = pDescripcion where CODIGO_CA = pCodigo;
    COMMIT;
end;

EXECUTE ACTUALIZAR_CA(3, 'EVENTOS ESPECIALES');

create procedure guardar_ar(pCODIGO_AR NUMBER,
                            pDESCRIPCION_AR VARCHAR2,
                            pMARCA_AR VARCHAR2,
                            pCODIGO_ME NUMBER,
                            pCODIGO_CA NUMBER,
                            pSTOCK_ACTUAL NUMBER,
                            pFECHA_REGISTRO DATE,
                            pACTIVO NUMBER)
as
begin
    INSERT INTO TB_ARTICULOS(CODIGO_AR,
                            DESCRIPCION_AR,
                            MARCA_AR,
                            CODIGO_ME,
                            CODIGO_CA,
                            STOCK_ACTUAL,
                            FECHA_REGISTRO,
                            ACTIVO)
                    VALUES(pCODIGO_AR,
                            pDESCRIPCION_AR,
                            pMARCA_AR,
                            pCODIGO_ME,
                            pCODIGO_CA,
                            pSTOCK_ACTUAL,
                            pFECHA_REGISTRO,
                            pACTIVO);
COMMIT;
end;

EXECUTE guardar_ar(7, 'NUEVO ARTICULO', 'MARCA NUEVA', 1, 3, 5, '21-03-2024', 1);

create procedure buscar_nota_alumno(pCODIGO_AL IN NUMBER,
                                    pNOTA1 OUT NUMBER)
as
begin
    SELECT NOTA1 INTO pNOTA1 FROM tb_notas_alumnos WHERE CODIGO_AL = pCODIGO_AL;
end;

VAR vNOTA1 NUMBER;
EXECUTE buscar_nota_alumno(4, :vNOTA1);
PRINT vNOTA1;

create procedure PROC_DESCRIPCION_ME(p01 IN varchar2,
                                    p02 OUT varchar2)
as
begin
    SELECT descripcion_me INTO p02 FROM tb_medidas WHERE abreviatura_me = p01;
end;

VAR vDESCRIPCION_ME varchar2;
EXECUTE PROC_DESCRIPCION_ME('LT', :vDESCRIPCION_ME);
PRINT vDESCRIPCION_ME;

create procedure buscar_descripcion_me(p01 in out varchar2)
as
begin
    select descripcion_me into p01
    from tb_medidas
    where abreviatura_me = p01;
end;


create or replace function F_SUMAR(p01 number, p02 number)
return number
as
begin
    return(p01 + p02);
end;

create function F_MAYUSCULA(TEXTO VARCHAR2)
return VARCHAR2
as
begin
    return UPPER(TEXTO);
end;

create function F_EVALUAR_EDAD(pEDAD NUMBER)
return VARCHAR2
as
    V_RETORNO VARCHAR2;
begin
    V_RETORNO := '';
    IF pEDAD < 18 THEN
        V_RETORNO:='ERES MENOR DE EDAD';
    ELSE V_RETORNO:='ERES UN ADULTO';
    END IF;
    RETURN V_RETORNO;
end;