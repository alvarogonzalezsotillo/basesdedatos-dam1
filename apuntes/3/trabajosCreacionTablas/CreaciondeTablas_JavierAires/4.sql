INSERT INTO pinturas 	(color, fecha, bastidor) 
		VALUES 			('Rojo',TO_DATE('01/1/11','dd/mm/yy'),'ABCD123456')
INSERT INTO pinturas 	(color, fecha, bastidor) 
		VALUES 			('Verde',TO_DATE('01/06/12','dd/mm/yy'),'ABCD123456')

INSERT INTO acabados 	(id_acabado, navegador, bluetooth, asient_calef, nombre_cat) 
		VALUES 			('05','si','si','si','Prestige')

UPDATE flotas SET id_acabado = 05 WHERE id_acabado = 03

INSERT INTO revisiones 	(tipo, km_ant, km_sig, ant_fecha, bastidor)
		VALUES			('mantenimiento','15000','30000',TO_DATE('01/03/12','dd/mm/yy'),'1234ABCDEF').
INSERT INTO revisiones 	(tipo, km_sig, ant_fecha, sig_fecha, bastidor)
		VALUES			('mantenimiento','15000',TO_DATE('01/04/12','dd/mm/yy'),TO_DATE('01/10/12','dd/mm/yy'),'WXYZ987654')
INSERT INTO revisiones 	(tipo, km_ant, km_sig, ant_fecha, bastidor)
		VALUES			('mantenimiento','15000','30000',TO_DATE('01/10/12','dd/mm/yy'),'WXYZ987654')
INSERT INTO revisiones 	(tipo, sig_fecha, bastidor)
		VALUES			('itv',TO_DATE('01/02/16','dd/mm/yy'),'WXYZ987654')
INSERT INTO revisiones 	(tipo, km_ant, km_sig, ant_fecha, bastidor)
		VALUES			('mantenimiento','20000','40000',TO_DATE('01/04/12','dd/mm/yy'),,'ABCD123456')
INSERT INTO revisiones 	(tipo, sig_fecha, bastidor)
		VALUES			('itv',TO_DATE('01/01/11','dd/mm/yy'),'ABCD123456')
INSERT INTO revisiones 	(tipo, km_ant, km_sig, bastidor)
		VALUES			('mantenimiento','15000','30000','9876VUWYXZ')
;