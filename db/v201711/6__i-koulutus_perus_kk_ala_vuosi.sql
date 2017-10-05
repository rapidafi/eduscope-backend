set search_path to v201711;

truncate table koulutus_perus_kk_ala_vuosi;
SELECT setval('koulutus_perus_kk_ala_vuosi_id_seq', 1, false);

INSERT INTO koulutus_perus_kk_ala_vuosi
(okmohjauksenala_koodi, okmohjauksenala, okmohjauksenala_sv, okmohjauksenala_en
 , organisaatio_koodi, organisaatio, organisaatio_sv, organisaatio_en
 , vuosi, opiskelijat, aloittaneet, opiskelijat_fte, opiskelijat_lasna, tutkinnot)
select 
 d1.koodi as okmohjauksenala_koodi
,d1.nimi as okmohjauksenala
,d1.nimi_sv as okmohjauksenala_sv
,d1.nimi_en as okmohjauksenala_en
,d2.koodi as organisaatio_koodi
,d2.nimi as organisaatio
,d2.nimi_sv as organisaatio_sv
,d2.nimi_en as organisaatio_en
,cast(vuosi as int) as vuosi
,case when coalesce(opiskelijat,'')!='' then cast(opiskelijat as int) end as opiskelijat
,case when coalesce(aloittaneet,'')!='' then cast(aloittaneet as int) end as aloittaneet
,case when coalesce(opiskelijat_fte,'')!='' then cast(opiskelijat_fte as float) end as opiskelijat_fte
,case when coalesce(opiskelijat_lasna,'')!='' then cast(opiskelijat_lasna as int) end as opiskelijat_lasna
,case when coalesce(tutkinnot,'')!='' then cast(tutkinnot as int) end as tutkinnot
from up.t_vipunen_a5_kk_opiskelijat as f
join koodisto as d1 on d1.koodisto='okmohjauksenala' and d1.nimi=f.ohjauksenala
join organisaatio as d2 on d2.tyyppi='oppilaitos' and d2.nimi=f.korkeakoulu
;

--select * from koulutus_perus_kk_ala_vuosi;
