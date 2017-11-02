set search_path to v201712;

delete from hei_bullet where mittariryhma='koulutus' and mittari='lapaisy4v';

insert into hei_bullet (oppilaitos,nimi,nimi_sv,nimi_en,vuosi,mittariryhma,mittari,arvo,tavoite,minimi,raja1,raja2,maksimi)
  select
   organisaatio_koodi as oppilaitos
  ,organisaatio as nimi
  ,organisaatio_sv as nimi_sv
  ,organisaatio_en as nimi_en
  ,vuosi
  ,'koulutus' as mittariryhma
  ,'lapaisy4v' as mittari
  ,avg(suhdeluku)*100 suhdeluku
  ,null as tavoite
  ,0 as minimi
  ,(select percentile_cont(.33) within group (order by t2.suhdeluku) from lapaisy4v_yliopisto t2 where t2.vuosi=t.vuosi)*100  as raja1
  ,(select percentile_cont(.67) within group (order by t2.suhdeluku) from lapaisy4v_yliopisto t2 where t2.vuosi=t.vuosi)*100  as raja2
  ,(select max(t2.suhdeluku)*100 from lapaisy4v_yliopisto t2 where t2.vuosi=t.vuosi) as maksimi --nb! NO 10% increase since scale is 0-100%
from lapaisy4v_yliopisto as t
group by vuosi,organisaatio_koodi,organisaatio,organisaatio_sv,organisaatio_en
order by vuosi,nimi
;

--select * from hei_bullet;
