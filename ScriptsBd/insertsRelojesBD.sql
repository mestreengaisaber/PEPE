SELECT * FROM prestamos.prestamo p;
select * from prestamos.reloj;

select count(*) from prestamos.reloj
where id_reloj like '7%';



insert into prestamos.reloj values(2,'RELOJ',001,'Reloj Cuentakilometros Ultimo Diseño',19.99,0,19.99,0,0,'velocimetro.jpg','2012-01-09',3);
insert into prestamos.reloj values(2,'RELOJ',002,'Reloj en binario',19.99,0,14.95,0,0,'binario.jpg','2012-01-09',3);
insert into prestamos.reloj values(2,'RELOJ',302,'Reloj brazalete correa negre leds azules',19.99,0,17.99,0,0,'brazaleteCnegre.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',301,'Reloj brazalete correa blanca leds azules',19.99,0,17.99,0,0,'brazaleteCblanca.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',00401,'Reloj led moderno square correa blanca',19.99,0,14.95,0,0,'squareCblanca.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',00402,'Reloj led moderno square correa negra',19.99,0,14.95,0,0,'squareCnegra.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',501,'Reloj Led Rect Blue',19.99,0,14.99,0,0,'ledRectBlue.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',502,'Reloj Led Rect Red',19.99,0,14.99,0,0,'ledRectRed.jpg','2012-01-09',1);
insert into prestamos.reloj values(2,'RELOJ',006,'Reloj correa Lego ',19.99,0,14.50,0,0,'lego.jpg','2012-01-09',2);
insert into prestamos.reloj values(2,'RELOJ',007,'Reloj 29 leds correa blanca',19.99,0,17.99,0,0,'twentnineLedswhite.jpg','2012-01-09',1);