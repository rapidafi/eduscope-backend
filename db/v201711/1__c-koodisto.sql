set search_path to v201711;

drop table if exists koodisto;

create table if not exists koodisto (
    id bigserial not null primary key,
    koodisto varchar(100) not null,
    koodi varchar(30) not null,
    nimi varchar(200) not null,
    nimi_sv varchar(200) null,
    nimi_en varchar(200) null
);
