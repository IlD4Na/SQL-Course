-- select eta + 20 from contatto

-- Casting a livello di SQL --
/*
select cast(123 AS char(3))
select cast('123' AS integer)
select cast('123.6' AS decimal)
select cast('2021-05-03' AS date)
*/

-- Estrazione di vari dati, qui abbiamo estratto dei campi calcolati 
/*
select
year(data_creazione) as Anno,
month(data_creazione) as Mese,
day(data_creazione) as Giorno
from contatto
*/

-- Operazioni matematiche eseguibili su SQL

/*

select 10 + 10
select 10 - 20
select 10 * 20
select 10 /20
select 21 mod 20 

select eta, eta + 10 from rubrica.contatto
*/


-- select cast('123' as unsigned) +10 -- per trasformare da stringa a integer

-- select cast('123.6' as float) + 0.5

-- select cast('2021-12-01' as date)

-- non tutti i tipi di dato sono convertibili in tutti i tipi di dato
-- ci sono delle tabelli di codifica 


-- ARITMETICA DELLE DATE 
/*
-- SELECT CURRENT_DATE(), current_timestamp()

-- SELECT current_date(), date_add(current_date(), interval +1 month)

-- SELECT current_date(), date_add(current_date(), interval -30 day)

-- select data_creazione,year(data_creazione),month(data_creazione),day(data_creazione)
*/
-- Sommare 7 giorni alla data di creazione nella tabella contatto
/*
select 
data_creazione,
date_add(data_creazione, interval 7 day) as nuova_data
from rubrica.contatto
*/
-- Dalla nuova data, estrarre anno, mese e giorno come campi separati 
/*
select
day(data_creazione) as Giorno,
month(data_creazione)as Mese,
year(data_creazione)as Anno,
data_creazione
from rubrica.contatto
*/
-- Esercizio sulla WHERE condition 

-- Selezionare contatti di età superiore ai 30 anni
-- Selezionare contatti il cui nome comincia con la lettera "A"
-- Selezionare contatti il cui anno di inserimento è 2020 o 2018
-- Selezionare contatti il cui anno di inserimento è successivo al 2013 escludendo il 2018 
/*
select *
from rubrica.contatto
where eta > 30 

select *
from rubrica.contatto 
where nome like "A%"


select * 
from rubrica.contatto
where year(data_creazione) in (2018,2020)

select * from rubrica.contatto
where year(data_creazione) = 2018 or year(data_creazione) = 2020


select * from rubrica.contatto 
where year(data_creazione) >= 2013 and year(data_creazione) <> 2018 
*/

-- Formato delle Date 
-- Formattare il campo data_creazione della tabella contatto nel formato GG/MM/AAAA
-- Formattare il campo da_creazione nel formato "Mese DD, AAAA"
/*
select 
data_creazione,
date_format(data_creazione, "%d/%m/%Y")
from rubrica.contatto


select 
data_creazione,
date_format(data_creazione, "%M %d, %Y")
from rubrica.contatto
*/




-- OPERAZIONI SULLE STRINGHE -- 

/* 
select
nome,
character_length(nome)
from contatto

ci darà due colonne una costituita 
dal nome ed una dalla lunghezza 
in caratteri di quel nome

abbiamo poi le funzioni:
upper(nome)
lower(nome)

cercare una sottostringa dentro una stringa più lunga 
locate ci dà se la prima occorrenza è contenuta nella seconda
SQL cercherà a all'interno della stringa Mario

select locate("a","Mario")
(ci dà come risultato la posizione) 

Estrazione di sottostringhe con LEFT,RIGHT

select nome, left(nome,2) from contatto (prenderà i primi 2 caratteri da sinistra di nome) 

stessa cosa la possiamo fare con right(nome,2) 

questa invece se vogliamo estrarre qualcosa in mezzo substr(nome,2,5)

SOSTITUZIONE :

replace("Corso di SQL", "SQL", "Linguaggio SQL") 

CONCATENAZIONE : 
con separatore
concat_ws(",","Corso","SQL")
senza separatore
concat("Corso","SQL")

RIEMPIMENTO INIZIO O FINE stringa : concetto di padding significa aggiunger eun caratterre in testa o in coda fino ad una lunghezza prefissata

select Ipad("123",12,"0") left : riempimento a sinistra
aggiunta alla stringa 123 fino ad un numero caratteri di 12, poi alla fine il carattere da aggiungere 

select rpad("123",12,"0") right : riempimento a destra

RIMOZIONE SPAZI DA UNA STRINGA: 

ltrim("      Mario")
rtrim("Mario      ")
trim("    Mario   ")

DIFFERENZA TRA DUE DATE: in giorni 
Importante quando vogliamo considerare delgi intervalli di giorni ben precisi 9

select
DATEDIFF("2007-12-31","2008-01-30")

*/

-- WHERE CONDITION, ci permette di creare i filtri 

/* 

select * from contatti
where nome = "Mario"

= uguale a
<> Diverso da 
> e >= maggiore o uguale a 
< e <= minore o uguale a 
IN  contenuto in 
LIKE Soddisfa un certo pattern per stringhe 

Poi ci sono i soliti AND / OR / NOT 
*/

-- Case When. PER CREAZIONE CAMPI CALCOLATI basato su condizioni logiche

/*

select 
nome, cognome,
case
when anno(data_creazione) < 2000 then "< 2000"
when anno(data_creazione) < 2010 then "< 2010"
else "> 2010"
end as fascia

from contatto 

*/

-- FUNZIONI AGGREGATE (CONTEGGIO,SOMMA ECC.)

select COUNT(*) from contatto

select count(distinct recapito) from recapito

distinc va ad eliminare i duplicati

Tra le funzioni aggregate più usate troviamo
COUNT
COUNT(distinct...)
SUM
AVG (Media)
MAX (Valore Massimo)
MIN (Valore Minimo)

Uso di Group By, serve per distribuire i risultati. 
Se abbiamo ad esempio un records di telefoni fissi e cellulari nel campo 
(tipologia di numero) e usiamo group by tipologia_di_numero andiamo a distribuire i risultati delle funzioni aggregate



