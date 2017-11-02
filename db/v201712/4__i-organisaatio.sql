set search_path to v201712;

truncate table organisaatio;
SELECT setval('organisaatio_id_seq', 1, false);

insert into organisaatio (tyyppi,koodi,nimi,nimi_sv,nimi_en,tunnus)
select
 'oppilaitos'
,koodi
,coalesce(nimi,nimi_sv,nimi_en) as nimi
,coalesce(nimi_sv,nimi,nimi_en) as nimi_sv
,coalesce(nimi_en,nimi,nimi_sv) as nimi_en
,(select b.koodi from up.koodistot b where b.koodisto='virtakorkeakoulutunnus' and b.nimi=koodistot.koodi) as tunnus
from up.koodistot
where koodisto='oppilaitosnumero'
and koodi in (select b.nimi from up.koodistot b where b.koodisto='virtakorkeakoulutunnus')
--and coalesce(loppupvm,'9999-9-9') > now()
order by 1,2
;

select * from organisaatio;
