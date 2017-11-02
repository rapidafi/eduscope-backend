set search_path to v201712;

drop table if exists koulutus_perus_kk_ala_vuosi;

create table if not exists koulutus_perus_kk_ala_vuosi (
    id bigserial NOT NULL PRIMARY KEY,
    --
    okmohjauksenala_koodi varchar(30) NOT NULL,
    okmohjauksenala varchar(200) not null,
    okmohjauksenala_sv varchar(200) not null,
    okmohjauksenala_en varchar(200) not null,
    organisaatio_koodi varchar(30) NOT NULL,
    organisaatio varchar(200) not null,
    organisaatio_sv varchar(200) not null,
    organisaatio_en varchar(200) not null,
    vuosi int NOT NULL,
    --
    opiskelijat int,
    aloittaneet int,
    opiskelijat_fte float,
    opiskelijat_lasna int,
    tutkinnot int
);
