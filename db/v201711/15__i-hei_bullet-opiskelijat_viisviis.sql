set search_path to v201711;

delete from hei_bullet where mittariryhma='koulutus' and mittari='opiskelijat_viisviis';

insert into hei_bullet (oppilaitos,nimi,nimi_en,vuosi,mittariryhma,mittari,arvo,tavoite,minimi,raja1,raja2,maksimi)
  select
   d1.koodi as oppilaitos
  ,d1.nimi as nimi
  ,d1.nimi_en as nimi_en
  ,vuosi
  ,'koulutus' as mittariryhma
  ,'opiskelijat_viisviis' as mittari
  ,arvo
  ,null as tavoite
  ,0 as minimi
  ,(select percentile_cont(.33) within group (order by t2.arvo) from up.t_vipunen_opiskelijat_viisviis t2 where t2.vuosi=t.vuosi)  as raja1
  ,(select percentile_cont(.67) within group (order by t2.arvo) from up.t_vipunen_opiskelijat_viisviis t2 where t2.vuosi=t.vuosi)  as raja2
  ,(select max(t2.arvo) from up.t_vipunen_opiskelijat_viisviis t2 where t2.vuosi=t.vuosi) as maksimi
from up.t_vipunen_opiskelijat_viisviis as t
join organisaatio d1 on d1.tyyppi='oppilaitos'
 and d1.nimi=(
     case korkeakoulu
     -- fix some Vipunen terms
     when 'Humanistinen ammattikorkeak.' then 'Humanistinen ammattikorkeakoulu'
     when 'Kymenlaakson ammattikorkeak.' then 'Kymenlaakson ammattikorkeakoulu'
     when 'Lappeenrannan tekn. yliopisto' then 'Lappeenrannan teknillinen yliopisto'
     when 'Tampereen tekn. yliopisto' then 'Tampereen teknillinen yliopisto'
     else korkeakoulu
     end
    )
order by vuosi,nimi
;

--select * from hei_bullet;
