select eta + 20 from contatto;

-- Casting a livello di SQL --
-- Serve per andare a cambiare il formato di quel determinato dato

select cast(123 AS char(3)) 
select cast('123' AS integer)
select cast('123.6' AS decimal)
select cast('2021-05-03' AS date)


-- Estrazione di vari dati, qui abbiamo estratto dei campi calcolati in cui specifichiamo giorno,mese,anno e abbiamo usato degli alias

select
year(data_creazione) as Anno,
month(data_creazione) as Mese,
day(data_creazione) as Giorno
from contatto


-- Operazioni matematiche eseguibili su SQL


select 10 + 10
select 10 - 20
select 10 * 20
select 10 /20
select 21 mod 20 

select eta, eta + 10 from rubrica.contatto



select cast('123' as unsigned) +10 -- per trasformare da stringa a integer

select cast('123.6' as float) + 0.5 -- per trasformare in un float

select cast('2021-12-01' as date) -- per trasformare in una data

-- non tutti i tipi di dato sono convertibili in tutti i tipi di dato
-- ci sono delle tabelle di codifica 


-- ARITMETICA DELLE DATE 

SELECT CURRENT_DATE(), current_timestamp() -- la data corrente ed il timestamp corrente

SELECT current_date(), date_add(current_date(), interval +1 month) -- data corrente e data tra 1 mese

SELECT current_date(), date_add(current_date(), interval -30 day) -- data corrente e data 30 giorni fa

select data_creazione,year(data_creazione),month(data_creazione),day(data_creazione)


-- Sommare 7 giorni alla data di creazione nella tabella contatto

select 
data_creazione,
date_add(data_creazione, interval 7 day) as nuova_data
from rubrica.contatto


-- Dalla nuova data, estrarre anno, mese e giorno come campi separati 

select
day(data_creazione) as Giorno,
month(data_creazione)as Mese,
year(data_creazione)as Anno,
data_creazione
from rubrica.contatto


-- Esercizio sulla WHERE condition 

-- Selezionare contatti di età superiore ai 30 anni
-- Selezionare contatti il cui nome comincia con la lettera "A"
-- Selezionare contatti il cui anno di inserimento è 2020 o 2018
-- Selezionare contatti il cui anno di inserimento è successivo al 2013 escludendo il 2018 

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


-- Formato delle Date 
-- Formattare il campo data_creazione della tabella contatto nel formato GG/MM/AAAA
-- Formattare il campo da_creazione nel formato "Mese DD, AAAA"

select 
data_creazione,
date_format(data_creazione, "%d/%m/%Y")
from rubrica.contatto


select 
data_creazione,
date_format(data_creazione, "%M %d, %Y")
from rubrica.contatto





-- OPERAZIONI SULLE STRINGHE -- 


select
nome,
character_length(nome) -- è una funzione
from contatto

-- ci darà due colonne una costituita 
-- dal nome ed una dalla lunghezza 
-- in caratteri di quel nome

abbiamo poi le funzioni:
upper(nome)
lower(nome)

-- cercare una sottostringa dentro una stringa più lunga 
-- locate ci dà se la prima occorrenza è contenuta nella seconda
-- SQL cercherà a all'interno della stringa Mario

select locate("a","Mario")
-- (ci dà come risultato la posizione) ma senza non incomincia da 0 a contare ma da 1

-- Estrazione di sottostringhe con LEFT,RIGHT

select nome, left(nome,2) from contatto -- (prenderà i primi 2 caratteri da sinistra di nome) 

-- stessa cosa la possiamo fare con 
select right(nome,2)  from contatto

-- questa invece se vogliamo estrarre qualcosa in mezzo 
select substr(nome,2,5) from contatto

-- SOSTITUZIONE :

select replace("Corso di SQL", "SQL", "Linguaggio SQL") 

-- CONCATENAZIONE : 
-- con separatore
select concat_ws(",","Corso","SQL")
-- senza separatore
select concat("Corso","SQL")

-- RIEMPIMENTO INIZIO O FINE stringa : concetto di padding significa aggiungere un caratterre in testa o in coda fino ad una lunghezza prefissata

select lpad("123",12,"0") -- left : riempimento a sinistra
-- aggiunta alla stringa 123 fino ad un numero caratteri di 12, poi alla fine il carattere da aggiungere 

select rpad("123",12,"0") -- right : riempimento a destra

-- RIMOZIONE SPAZI DA UNA STRINGA: 

ltrim("      Mario")
rtrim("Mario      ")
trim("    Mario   ")

-- DIFFERENZA TRA DUE DATE: in giorni 
-- Importante quando vogliamo considerare delgi intervalli di giorni ben precisi 9

select
DATEDIFF("2007-12-31","2008-01-30") -- Funzione



-- WHERE CONDITION, ci permette di creare i filtri 



select * from contatti
where nome = "Mario"
/*
= uguale a
<> Diverso da 
> e >= maggiore o uguale a 
< e <= minore o uguale a 
IN  contenuto in 
LIKE Soddisfa un certo pattern per stringhe 

Poi ci sono i soliti AND / OR / NOT 
*/

-- Case When PER CREAZIONE CAMPI CALCOLATI basato su condizioni logiche

select 
nome, cognome,
case
when anno(data_creazione) < 2000 then "< 2000"
when anno(data_creazione) < 2010 then "< 2010"
else "> 2010"
end as fascia
from contatto 


-- FUNZIONI AGGREGATE (CONTEGGIO,SOMMA ECC.)


select COUNT(*) from contatto

select count(distinct recapito) from recapito

-- distinc va ad eliminare i duplicati
/*
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


HAVING => Filtra i risultati di una Query in base al valore restituito 
da una funzione aggregata
*/

select 
tipo_recapito,
count(*)
from recapito
group by tipo_recapito 
having count(*) > 1 

-- E' una where condition applicata però alla funzione aggregata
-- Having va scritta dopo la group by 



select
count(*) AS conteggio
from rubrica.recapito
where tipo_recapito like "e%"

select
AVG(eta) media_età, -- possiamo inserire un alias anche senza aggiungere "as"
min(eta) as età_minima,
max(eta) as età_massima
from rubrica.contatto


select 
case 
when eta <= 30 then 'Under 30'
when eta > 30 then 'Over 31'
end as fascia_eta,
count(*) 
from rubrica.contatto
group by fascia_eta

-- Estrarre tutti i tipi di recapito che hanno almeno 2 record nella tabella "recapito"

select 
tipo_recapito,count(*)
from rubrica.recapito
group by tipo_recapito
having count(*) >= 2


-- Incrociare i dati (I vari tipi di Join)

-- La join costruisce un nuovo dataset creando una nuova tabella 

-- INNER JOIN 

-- Considera solo i record che hanno lo stesso valore della chiave che si decide di avere come chiave di join 
-- sintassi tipo

select * from
recapito rec -- nome tabella di sinistra seguito da un alias
inner join contatto cont -- inner join seguito dal nome della tabella di distra più l'alias
on rec.id_contatto = cont.id_contatto -- parola chiave "on" e la condizione chiave della join ovvero

-- colonna id_contatto di rec deve essere uguale alla colonna id_contatto di cont
-- questa condizione verrà verificata contatto dopo contatto

-- LEFT JOIN

-- Considera tutti i record della tabella di sinistra agganciando i record della tabella di destra mediante la chiave di join
-- se c'è match verrà inserita quella riga della tabella di destra se non c'è record verrà messo un null (assenza valore)

select * from
recapito rec
left join contatto cont
on rec.id_contatto = cont.id_contatto


-- RIGHT JOIN

-- E' la versione speculare della left join dove consideriamo tutti i valori della tabella di destra ed eventualmente facciamo una join con la sinistra
-- se c'è match ci sara popolamento se no ci sarà il non valore "null"

select * from
recapito rec
right join contatto cont
on rec.id_contatto = cont.id_contatto

-- IMPORTANTE NON SEMPRE IL NOME DELLA COLONNA DI SINISTRA E UGUALE ALLA COLONNA DI DESTRA (COLONNA CHE USIAMO COME CHIAVE DI JOIN)

-- SUBQUERY 

-- E' una query all'interno di un'altra query tipo: 

select * from (
select id_contatto from recapito) 

-- prende anche il nome di tabella derivata rispetto ad una qualunque from
-- Modalità non molto ottimizzata infatti appesantisce la scrittura del codice

-- INCROCIARE I DATI PER RIGA (operazioni sugli insiemi di record)

-- UNION crea dataset che accoda irecord di due dataset distinti RIMUOVENDO I duplicati

select id_contatto,nome from contatto where nome = "Mario"
union
select id_contatto,nome from contatto where nome = "Luigi"

-- UNION ALL fa la stessa cosa ma mantenendo i duplicati

-- INTERSECT  crea dataset costituito dai soli record in comune tra i due dataset di input

select id_contatto, nome from contatto where nome = "Mario"
intersect
select id_contatto, nome from contatto

-- MINUS crea un dataset costituito dai soli record presenti nel primo dataset esclusi quelli presenti nel secondo
-- Si vanno a rimuovere tutti i record che il primo ha in comune con il secondo

-- 1. Calcolare età media degli utenti che hanno un indirizzo e-mail (non PEC)
-- Mettiamo in join la tabella dei contatti e quella dei recapiti 

select
avg(cont.eta)
from
rubrica.contatto cont
inner join rubrica.recapito rec 
on cont.id_contatto = rec.id_contatto
where tipo_recapito = "e-mail"

-- le Join si scrivono al contrario perchè si parte dalla fine per poi arrivare all'inizio

-- 2. Calcolare, per ogni utente, il numero di recapiti che ha (se non ne ha, specificare 0)
-- Stiamo considerando tutti gli utenti e siamo agganciando eventualmente il recapito se il recapito non è agganciabile allora si specifica 0

select
cont.id_contatto,
cont.nome,
cont.cognome,
count(rec.recapito)
from
rubrica.contatto cont
left join rubrica.recapito rec
on cont.id_contatto = rec.id_contatto
group by 1,2,3

-- prima di inserire nome,count(recapito) possiamo usare "*" per semplicemente vedere com'è venuta la join

-- ESERCIZIO SULLE SUBQUERY
-- Estrarre gli identificativi dei contatti che hanno almeno un recapito di qualsiasi tipo

select
distinct cont.*
from rubrica.contatto cont
inner join (select id_contatto from rubrica.recapito) rec
on cont.id_contatto = rec.id_contatto

-- E' solitamente preferibile fare le JOIN senza le SUBQUERY al loro interno perchè è computazionalmente svantaggioso 
-- oppure

select
cont.*
from rubrica.contatto cont
where id_contatto in (select id_contatto from rubrica.recapito)

-- La Subquery si può utilizzare dentro una join ma anche dentro una "in"

-- Intersecare l'insieme di contatti creati dopo il 2010 con l'insieme di contatti di eta maggiore a 35 anni

select * from rubrica.contatto where data_creazione >= '2010-01-01'
intersect
select * from rubrica.contatto where eta > 35


select * from rubrica.contatto where data_creazione >= '2010-01-01'
except
select * from rubrica.contatto where eta > 35
-- Se io prendo il primo dataset e rimuovo tutti i record contenuti nel secondo dataset la risultate è il dataset costituito solo da Luigi Rossi



-- CREAZIONE DI DATASET 

create database prova -- Il concetto di database viene associato al vocabolo schema per indicare il database

-- Creazione tabelle
create table prova.tabella (
id integer,
nome text,
eta integer)

-- Tabella temporanea : esiste fin tanto che siamo connessi al database

create temporary tabble db.tabella(
id integer,
nome text,
eta integer)

-- Creazione di View : struttura dati che esegue una query appena viene interrogata
-- Dietro una view c'è la query, la view di per se non contiene dati ma li espone
-- Molto comode quando vogliamo mantenere il dato grezzo nel database

create view contatti_recapiti as
select id_contatto,nome,tipo_recapito,recapito
from contatto cont
left join recapito rec
on cont.id_contatto = rec.id_contatto


-- UPDATE : è possibile aggiornare uno o più record di una tabella che soddisfano una determinata condizione 

update recapito
set recapito = 'N/A'
where recapito is null

-- DELETE : cancellare dei record che soddisfano determinate condizioni
-- Istruzione molto pericolosa, molti client SQL senza al where condition ci danno un allarme
delete from recapito
where tipo_recapito is null

-- INSERT: consente di creare nuovi record

insert into contatto (id,nome) values (20,'Matteo');

insert into contatto select ... -- Quando vogliamo inserire il risultato di una certa query

-- Eliminare gli oggetti : DROP consente di eliminare un oggetto

drop database prova;
drop table tab;
drop view vista;


-- ESERCIZI 
-- 1. creazione tabella "tmp" con i campi ragione_sociale (testo), partita_iva(testo), data_creazion (data), fatturato (numero in virgola mobile)

create temporary table rubrica.tmp(
ragione_sociale text,
partita_iva text,
data_creazione date,
fatturato float
)

select * from rubrica.tmp

-- 2. Creare una view che contenga solo i contatti di età maggiore o uguale a 35 anni 

select * from rubrica.contatto where eta >= 35
-- equivale a 
select * from rubrica.over35 -- where over35 is a view

-- 1.Creare una tabella temporanea con la stessa struttura e contenuto dell atabella "contatto"

create temporary table rubrica.tmp as
select* from rubrica.contatto

-- 2. Modificare la data di creazione fissandola a 30 giorni fa per tutti i contatti di età inferiore a 40 anni

update rubrica.tmp
set data_creazione = date_add(current_date(),interval -30 day)
where eta < 40

-- 1. Creare una tabella "tmp" con la stessa struttura e contenuto della tabella "contatto"
-- 2. Cancellare tutti i record dei contatti di età inferiore a 40 anni 

create temporary table rubrica.tmp as
select * from rubrica.contatto

select * from rubrica.tmp -- verifichiamo il contenuto

delete from rubrica.tmp
where eta eta < 40 

-- Creare nuovi record 
-- ESERCIZI 

-- 1. Creare una tabella temporanea "nuovi_contatti" con la stessa struttura della tabella "contatto"
-- 2. Inserire il seguente record: id_contatto=6, nome=John, cognome=Morris, data_creazione = (40 giorni fa)
-- 3. Creare una tabella temporanea con la stessa struttura della tabella "contatto" e chiamarla "cliente"
-- 4. Inserire, nella tabella "clienti", tutti i contatti di età inveriore a 40 anni 

create temporary table rubrica.nuovi_contatti as 
select * from rubrica.contatto where 1=2 -- si aggiunge una where impossibile cosi si costruisce con la stessa struttura ma senza records all'interno 

-- O possiamo anche fare 

create temporary table rubrica.nuovi_contatti like rubrica.contatto

select* from rubrica.nuovi_contatti
 
insert into rubrica.nuovi_contatti (id_contatto,nome,cognome,data_creazione) 
values (6,'John','Morris',date_add(current_date(),interval -40 day))
 
 create temporary table rubrica.clienti like rubrica.contatto
 
 insert into rubrica.clienti 
 select * from rubrica.contatto where eta < 40 
 
 select * from rubrica.clienti
 
 
 -- ACCENNO AL MONDO NO SQL 
 
 -- ci rientrano i database basati su strutture dati JSON  (MongoDB / CosmoDB)
 -- I campo JSON sono non-relazioni, abbiamo coppie di chiavi-valori 

/*
Sintassi per operare con oggetti JSON da database SQL

SELECT
obj->>'$.nome' as nome,
obj->>'$.cognome' as cognome
obj->>'$.indirizzi[0]' as indirizzo_0,
obj->>'$.telefoni.fisso' as telefono_fisso #quando abbiamo due chiavi
FROM tmp

Questa sintassi è la sintassi Json Path

*/
-- Uqelle di seguit sono manipolazioni di tipo nonSQL
create temporary table rubrica.jsontemp(
obj json
)

insert into rubrica.jsontemp (obj) values('
{
 "nome":"Mario",
 "telefoni":[339847345,334674325]
}

')

select obj ->> "$.nome" from rubrica.jsontemp


/*
MySQL è solo uno dei vari database relazionali che si trovano in commercio

I databse commerciali:
- Oracle Database 
- Microsoft SQL Server
- Teradata (DB ottimizzato sopratutto per finalità di data warehouse)

Open Source:
-MySQL
-PostgreSQL (usato per al parte di analisi dati tantissimo, per volumi di dati grandissimi)
-SQLite (Un Database che risiede su un unico file, usato da applicazioni standalone, molto economico)
-Hive (Consente di vedere i contenuti di un data lake sotto forma di file csv come se fossero tabelle relazionali)

