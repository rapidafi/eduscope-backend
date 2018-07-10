--\i 0__c-schema.sql
DROP SCHEMA v201808 CASCADE;

CREATE SCHEMA v201808;

set search_path to v201808;

\i 1__c-koodisto.sql
\i 2__c-organisaatio.sql
\i 3__i-koodisto.sql
\i 4__i-organisaatio.sql
\i 5__c-koulutus_perus_kk_ala_vuosi.sql
\i 6__i-koulutus_perus_kk_ala_vuosi.sql
\i 7__c-hei_bullet.sql
\i 8__i-hei_bullet-opiskelijat.sql
\i 9__i-hei_bullet-tutkinnot.sql
\i 10__u-hei_bullet-tutk_tavoitteet.sql
\i 11__c-koulutus_vuosi-korkeakoulu.sql
\i 12__i-hei_bullet-aloittaneet.sql
\i 13__i-hei_bullet-opiskelijat_fte.sql
\i 14__i-hei_bullet-opiskelijat_lasna.sql
\i 15__i-hei_bullet-opiskelijat_viisviis.sql
\i 16__c-lapaisy4v_yliopisto.sql
\i 17__i-hei_bullet-lapaisy4v_yliopisto.sql
