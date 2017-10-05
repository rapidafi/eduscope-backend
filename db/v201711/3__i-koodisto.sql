set search_path to v201711;

truncate table koodisto;
SELECT setval('koodisto_id_seq', 1, false);

insert into koodisto (koodisto,koodi,nimi,nimi_sv,nimi_en)
select
 koodisto
,koodi
,coalesce(nimi,nimi_sv,nimi_en) as nimi
,coalesce(nimi_sv,nimi,nimi_en) as nimi_sv
,coalesce(nimi_en,nimi,nimi_sv) as nimi_en
from up.koodistot
where 1=1
and coalesce(loppupvm,'9999-9-9') > now() --todo: compare to what?
and koodisto not in ('oppilaitosnumero','virtakorkeakoulutunnus') --todo: really?
order by 1,2
;

select * from koodisto;
