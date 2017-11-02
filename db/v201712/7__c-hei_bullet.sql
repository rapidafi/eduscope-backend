set search_path to v201712;

/*
Korkeakoulu         esim Helsingin yliopisto
Vuosi               esim 2016
Mittariryhmän nimi      esim Koulutus
Mittarin nimi           esim Tutkinnot
Mittarin toteuma-arvo       esim 6000
Mittarin tavoite-arvo       esim 6200 (vipusen pdf:stä)
Minimi              esim 0
Alimman kolmanneksen raja-arvo  esim percentile_cont(33%)
Ylimmän kolmanneksen raja-arvo  esim percentile_cont(67%)
Maksimi         esim 7000           
*/

drop table if exists hei_bullet;

create table if not exists hei_bullet (
    id bigserial not null primary key,
    oppilaitos varchar(5) not null,
    nimi varchar(100) not null,
    nimi_sv varchar(100) null,
    nimi_en varchar(100) null,
    vuosi varchar(4) not null,
    mittariryhma varchar(30) not null,
    mittari varchar(30) not null,
    arvo int not null,
    tavoite int null,
    minimi int null,
    raja1 int null,
    raja2 int null,
    maksimi int null
);
