set search_path to v201711;

CREATE VIEW lapaisy4v_yliopisto AS
SELECT "Vuosi" as vuosi
,gg.koodi as organisaatio_koodi
,gg.nimi as organisaatio
,gg.nimi_sv as organisaatio_sv
,gg.nimi_en as organisaatio_en
,coalesce(kl.okmohjauksenalakoodi,'-') as okmohjauksenala_koodi
,coalesce(kl.okmohjauksenalanimi,'Tieto puuttuu') as okmohjauksenala
,coalesce(kl.okmohjauksenalanimi_sv,'Information saknas') as okmohjauksenala_sv
,coalesce(kl.okmohjauksenalanimi_en,'Missing data') as okmohjauksenala_en
,sum(cast("Tutkintokertyma (4v)" as int)) as tutkintokertyma_4v
,sum(cast("Aloittaneet (4v sitten)" as int)) as aloittaneet_4v
,cast(sum(cast("Tutkintokertyma (4v)" as float)) / sum(cast("Aloittaneet (4v sitten)" as float)) as float) as suhdeluku
FROM up.yliopisto_lapaisy_4v as f
JOIN up.koulutusluokitus as kl on kl.koodi=f."Koulutuskoodi"
JOIN organisaatio as gg on gg.tyyppi='oppilaitos' and gg.koodi=f."Korkeakoulu"
GROUP BY vuosi
, organisaatio_koodi,organisaatio,organisaatio_sv,organisaatio_en
, okmohjauksenala_koodi,okmohjauksenala,okmohjauksenala_sv,okmohjauksenala_en
;

--select * from lapaisy4v_yliopisto