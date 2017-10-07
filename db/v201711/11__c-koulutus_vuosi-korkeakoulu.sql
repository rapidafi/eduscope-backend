set search_path to v201711;

DROP VIEW IF EXISTS koulutus_vuosi_korkeakoulu;

CREATE VIEW koulutus_vuosi_korkeakoulu AS
SELECT vuosi
, organisaatio_koodi, organisaatio, organisaatio_sv, organisaatio_en
, sum(opiskelijat) as opiskelijat
, sum(aloittaneet) as aloittaneet
, sum(opiskelijat_fte) as opiskelijat_fte
, sum(opiskelijat_lasna) as opiskelijat_lasna
, sum(tutkinnot) as tutkinnot
FROM koulutus_perus_kk_ala_vuosi
--WHERE organisaatio_koodi='02609' AND vuosi=2016
group by vuosi, organisaatio_koodi, organisaatio, organisaatio_sv, organisaatio_en
order by 1,2
;