create table TS_SAL_DATA_USER.FCT_SALES_DD
(
   event_dt             date                           not null,
   game_surr_id         number                         not null,
   company_id           number                         not null,
   customer_id          number                         not null,
   date_id              number                         not null,
   territory_id         number                         not null,
   sales_cat_id         number                         not null,
   fct_sales_amount     number                         null,
   fct_sales_dollars    decimal                        null,
   fct_profit_margin    int                            null,
   insert_dt            date                           not null
)

 PARTITION BY RANGE (event_dt) SUBPARTITION BY HASH (sales_cat_id)
  SUBPARTITIONS 4
 ( PARTITION sales_q1_2020 VALUES LESS THAN (TO_DATE('01-APR-2020','dd-MON-yyyy'))
 , PARTITION sales_q2_2020 VALUES LESS THAN (TO_DATE('01-JUL-2020','dd-MON-yyyy'))
 , PARTITION sales_q3_2020 VALUES LESS THAN (TO_DATE('01-OCT-2020','dd-MON-yyyy'))
 , PARTITION sales_q4_2020 VALUES LESS THAN (TO_DATE('01-JAN-2021','dd-MON-yyyy'))
 )tablespace ts_sal_data;
 
 
 
alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_GEO_LOCATIONS foreign key (territory_id)
      references TS_SAL_DATA_USER.DIM_GEO_LOCATIONS (territory_id)
      on delete cascade;

alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_GAME foreign key (game_surr_id)
      references TS_SAL_DATA_USER.DIM_GAMES_SCD (game_surr_id)
     on delete cascade;

alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_COMPANIES foreign key (company_id)
      references TS_SAL_DATA_USER.DIM_COMPANIES (company_id)
      on delete cascade;

alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_CUSTOMERS foreign key (customer_id)
      references TS_SAL_DATA_USER.DIM_CUSTOMERS (customer_id)
      on delete cascade;

alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_DATE foreign key (date_id)
      references TS_SAL_DATA_USER.DIM_DATE (date_id)
      on delete cascade;

alter table TS_SAL_DATA_USER.FCT_SALES_DD
   add constraint FK_FCT_SALE_REFERENCE_DIM_GEN_PERIODS foreign key (sales_cat_id)
      references TS_SAL_DATA_USER.DIM_GEN_PERIODS  (sales_cat_id)
      on delete cascade;
      
      
