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
, (select sum(hei_bullet.arvo) from hei_bullet
    where hei_bullet.oppilaitos=koulutus_perus_kk_ala_vuosi.organisaatio_koodi and cast(hei_bullet.vuosi as int)=koulutus_perus_kk_ala_vuosi.vuosi
    and hei_bullet.mittari='opiskelijat_viisviis') AS opiskelijat_viisviis
FROM koulutus_perus_kk_ala_vuosi
group by vuosi, organisaatio_koodi, organisaatio, organisaatio_sv, organisaatio_en
order by 1,2
;