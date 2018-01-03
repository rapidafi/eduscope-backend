drop table if exists organisaatio;

create table if not exists organisaatio (
    id bigserial not null primary key,
    tyyppi varchar(20) not null,
    koodi varchar(30) not null,
    nimi varchar(200) not null,
    nimi_sv varchar(200) null,
    nimi_en varchar(200) null,
    tunnus varchar(10) null
);
