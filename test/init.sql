create table sites
(
    site_id serial
        primary key,
    site    text not null
        constraint constraint_name
            unique,
    config  jsonb
);

create table report_templates
(
    template_id               serial
        constraint templates_pkey
            primary key,
    template_type             text not null,
    template_name             text not null,
    template_filename         text not null,
    slide_config              text,
    custom_slide_config_data  jsonb,
    custom_template_file_data bytea,
    constraint unique_template_type_name
        unique (template_type, template_name)
);

create table olive_downs
(
    rca_id         numeric,
    priority       integer,
    initial_time   timestamp(0),
    last_updated   timestamp(0),
    machine        varchar(1024) not null,
    time           timestamp(0)  not null,
    end_time       timestamp(0),
    "Duration"     varchar(1024),
    "Impacted"     integer,
    "Total_Impact" numeric,
    "Type"         varchar(1024),
    "Cat_1"        varchar(1024),
    "Cat_2"        varchar(1024),
    "Cat_3"        varchar(1024),
    "Cat_4"        varchar(1024),
    "Fault"        varchar(1024),
    "AP_1"         varchar(1024),
    "AP_2"         varchar(1024),
    "Area"         varchar(1024),
    "Shift"        varchar(1024),
    "Comments"     varchar(1024),
    total_impacted varchar(50),
    updated_time   varchar(50),
    update_count   integer default 0,
    "Operator"     varchar(1024),
    constraint olive_downs_pk
        primary key (machine, time)
);

create table kearl
(
    rca_id         numeric,
    priority       integer,
    initial_time   timestamp(0),
    last_updated   timestamp(0),
    machine        varchar(1024) not null,
    time           timestamp(0)  not null,
    end_time       timestamp(0),
    "Duration"     varchar(1024),
    "Impacted"     integer,
    "Total_Impact" numeric,
    "Type"         varchar(1024),
    "Cat_1"        varchar(1024),
    "Cat_2"        varchar(1024),
    "Cat_3"        varchar(1024),
    "Cat_4"        varchar(1024),
    "Fault"        varchar(1024),
    "AP_1"         varchar(1024),
    "AP_2"         varchar(1024),
    "Area"         varchar(1024),
    "Shift"        varchar(1024),
    "Comments"     varchar(1024),
    total_impacted varchar(50),
    updated_time   varchar(50),
    update_count   integer default 0,
    "Operator"     varchar(1024),
    constraint kearl_pk
        primary key (machine, time)
);

create table qvc
(
    rca_id         numeric,
    priority       integer,
    initial_time   timestamp(0),
    last_updated   timestamp(0),
    machine        varchar(1024) not null,
    time           timestamp(0)  not null,
    end_time       timestamp(0),
    "Duration"     varchar(1024),
    "Impacted"     integer,
    "Total_Impact" numeric,
    "Type"         varchar(1024),
    "Cat_1"        varchar(1024),
    "Cat_2"        varchar(1024),
    "Cat_3"        varchar(1024),
    "Cat_4"        varchar(1024),
    "Fault"        varchar(1024),
    "AP_1"         varchar(1024),
    "AP_2"         varchar(1024),
    "Area"         varchar(1024),
    "Shift"        varchar(1024),
    "Comments"     varchar(1024),
    total_impacted varchar(50),
    updated_time   varchar(50),
    update_count   integer default 0,
    "Operator"     varchar(1024),
    constraint qvc_pk
        primary key (machine, time)
);


create table cote_gold
(
    rca_id         numeric,
    priority       integer,
    initial_time   timestamp(0),
    last_updated   timestamp(0),
    machine        varchar(1024) not null,
    time           timestamp(0)  not null,
    end_time       timestamp(0),
    "Duration"     varchar(1024),
    "Impacted"     integer,
    "Total_Impact" numeric,
    "Type"         varchar(1024),
    "Cat_1"        varchar(1024),
    "Cat_2"        varchar(1024),
    "Cat_3"        varchar(1024),
    "Cat_4"        varchar(1024),
    "Fault"        varchar(1024),
    "AP_1"         varchar(1024),
    "AP_2"         varchar(1024),
    "Area"         varchar(1024),
    "Shift"        varchar(1024),
    "Comments"     varchar(1024),
    total_impacted varchar(50),
    updated_time   varchar(50),
    update_count   integer default 0,
    "Operator"     varchar(1024),
    constraint cote_gold_pk
        primary key (machine, time)
);

create table test
(
    rca_id         numeric,
    priority       integer,
    initial_time   timestamp(0),
    last_updated   timestamp(0),
    machine        varchar(1024) not null,
    time           timestamp(0)  not null,
    end_time       timestamp(0),
    "Duration"     varchar(1024),
    "Impacted"     integer,
    "Total_Impact" numeric,
    "Type"         varchar(1024),
    "Cat_1"        varchar(1024),
    "Cat_2"        varchar(1024),
    "Cat_3"        varchar(1024),
    "Cat_4"        varchar(1024),
    "Fault"        varchar(1024),
    "AP_1"         varchar(1024),
    "AP_2"         varchar(1024),
    "Area"         varchar(1024),
    "Shift"        varchar(1024),
    "Comments"     varchar(1024),
    total_impacted varchar(50),
    updated_time   varchar(50),
    update_count   integer default 0,
    "Operator"     varchar(1024),
    constraint test_pk
        primary key (machine, time)
);

create function increment_update_count() returns trigger
    language plpgsql
as
$$
BEGIN
    NEW.update_count := OLD.update_count + 1;
    RETURN NEW;
END;
$$;


create trigger update_counter
    before update
    on qvc
    for each row
execute procedure increment_update_count();

--Insert Sites
INSERT INTO sites (site, config) VALUES ('Olive Downs', '{"company": "Thiess", "min_sme": 1, "otsc_premium": true, "daily_template": "Daily Report", "database_table": "olive_downs", "weekly_template": "Thiess - Olive Downs", "monthly_template": "Thiess - Olive Downs", "expander_data_source": "Command FMS Event Impact State (JHM)"}');
INSERT INTO sites (site, config) VALUES ('Kearl', '{"company": "Imperial Oil", "min_sme": 6, "otsc_premium": false, "daily_template": "Daily Report", "database_table": "kearl", "weekly_template": "Kearl-Weekly-Template", "expander_data_source": "Command FMS Event Impact State (JHM)"}');
INSERT INTO sites (site, config) VALUES ('Cote Gold', '{"company": "IAMGOLD", "min_sme": 4, "otsc_premium": false, "daily_template": "Daily Report", "database_table": "cote_gold", "weekly_template": "IAMGOLD - Côté Gold", "expander_data_source": "Command FMS Event Impact State (JHM)"}');
INSERT INTO sites (site, config) VALUES ('QVC', '{"company": "Anglo America", "min_sme": 4, "otsc_premium": true, "daily_template": "Daily Report", "database_table": "qvc", "weekly_template": "QVC - Anglo America", "expander_data_source": "Command FMS Event Impact State (JHM)"}');
INSERT INTO sites (site, config) VALUES ('Test', '{"company": "Test", "min_sme": 1, "otsc_premium": false, "daily_template": "Daily Report", "database_table": "test", "weekly_template": "Thiess - Olive Downs", "monthly_template": "Thiess - Olive Downs", "expander_data_source": "Command FMS Event Impact State (JHM)", "daily_stats_template": "Daily Stats (Excel)"}');

--Insert Report Templates
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('daily', 'Daily Report', 'daily_template.pptx', null, null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'Thiess - Olive Downs', 'thiess_weekly_template.pptx', 'Generic (with LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('monthly', 'Thiess - Olive Downs', 'thiess_monthly_template.pptx', 'Generic', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'Imperial Oil - Kearl', 'imperial_oil_weekly_template.pptx', 'Generic (no LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'IAMGOLD - Côté Gold', 'iamgold_weekly_template.pptx', 'Generic (with LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'QVC - Anglo America (English)', 'qvc_weekly_template.pptx', 'Generic (no LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'QVC - Anglo America (Spanish)', 'qvc_weekly_template.pptx', 'Spanish (no LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('weekly', 'IAMGOLD - Cote Gold', 'iamgold_weekly_template.pptx', 'Generic (no LTE)', null, null);
INSERT INTO report_templates (template_type, template_name, template_filename, slide_config, custom_slide_config_data, custom_template_file_data) VALUES ('daily_stats', 'Daily Stats (Excel)', 'stats_template.xlsx', null, null, null);

--Insert test data for the 'Test' site
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4446,NULL,NULL,NULL,'DZ298','2024-03-01 03:29:40','2024-03-01 03:30:30','00:00:50',2,60,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 4','29 N',NULL,NULL,NULL,0,'Operator E'),
	 (4447,NULL,NULL,NULL,'DZ298','2024-03-01 03:59:40','2024-03-01 04:00:20','00:00:40',2,30,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 8','29 N',NULL,NULL,NULL,0,'Operator F'),
	 (4453,NULL,NULL,NULL,'DZ300','2024-03-01 06:19:30','2024-03-01 06:20:20','00:00:50',2,90,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 6','01 D','Last operator - David Iopu, oncoming - Lawrence Condren',NULL,NULL,0,'Operator C'),
	 (4458,NULL,NULL,NULL,'RD783','2024-03-01 13:29:30','2024-03-01 13:30:00','00:00:30',3,110,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 2','01 D',NULL,NULL,NULL,0,'Operator H'),
	 (4461,NULL,NULL,NULL,'EX17','2024-03-01 17:25:00','2024-03-01 17:26:10','00:01:10',1,30,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 10','01 D',NULL,NULL,NULL,0,'Operator A'),
	 (4478,NULL,NULL,NULL,'DZ298','2024-03-02 03:14:10','2024-03-02 03:16:40','00:02:30',4,360,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 3','01 N',NULL,NULL,NULL,0,'Operator K'),
	 (4487,NULL,NULL,NULL,'DZ291','2024-03-02 06:51:30','2024-03-02 06:51:30','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 3','02 D',NULL,NULL,NULL,0,'Operator K'),
	 (4488,NULL,NULL,NULL,'DZ291','2024-03-02 06:51:50','2024-03-02 06:51:50','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 6','02 D',NULL,NULL,NULL,0,'Operator H'),
	 (4490,NULL,NULL,NULL,'DZ290','2024-03-02 07:42:20','2024-03-02 07:42:40','00:00:20',7,200,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 7','02 D',NULL,NULL,NULL,0,'Operator A'),
	 (4492,NULL,NULL,NULL,'RD843','2024-03-02 10:08:20','2024-03-02 10:08:20','00:00:00',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 3','02 D',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4499,NULL,NULL,NULL,'AHS27','2024-03-02 21:11:00','2024-03-02 21:12:20','00:01:20',4,220,'Tope','On-Board','Systems','Application','TOPE','Crash TOPE',NULL,NULL,'Test Zone 3','02 N',NULL,NULL,NULL,0,NULL),
	 (4501,NULL,NULL,NULL,'DZ298','2024-03-02 22:45:30','2024-03-02 22:48:50','00:03:20',2,50,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,'Test Zone 1','02 N',NULL,NULL,NULL,0,'Operator B'),
	 (4502,NULL,NULL,NULL,'RD843','2024-03-02 23:07:10','2024-03-02 23:07:10','00:00:00',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 9','02 N',NULL,NULL,NULL,0,'Operator E'),
	 (4503,NULL,NULL,NULL,'RD849','2024-03-03 00:45:00','2024-03-03 00:45:00','00:00:00',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 8','02 N',NULL,NULL,NULL,0,'Operator B'),
	 (4504,NULL,NULL,NULL,'RD850','2024-03-03 00:46:20','2024-03-03 00:46:20','00:00:00',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','02 N',NULL,NULL,NULL,0,'Operator G'),
	 (4505,NULL,NULL,NULL,'RD842','2024-03-03 00:57:40','2024-03-03 00:57:40','00:00:00',2,20,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 9','02 N',NULL,NULL,NULL,0,'Operator G'),
	 (4515,NULL,NULL,NULL,'RD841','2024-03-03 11:24:50','2024-03-03 11:26:10','00:01:20',5,160,'AMT','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 9','03 D',NULL,NULL,NULL,0,'Operator D'),
	 (4519,NULL,NULL,NULL,'RD850','2024-03-03 11:48:30','2024-03-03 11:48:30','00:00:00',2,20,'AMT','Off-Board','RF Coverage','-','-','Coverage',NULL,NULL,'Test Zone 8','03 D',NULL,NULL,NULL,0,'Operator J'),
	 (4524,NULL,NULL,NULL,'RD848','2024-03-03 16:16:20','2024-03-03 16:16:20','00:00:00',1,10,'AMT','On-Board','Systems','Application','TOPE','No pos data in PR2 TOPE',NULL,NULL,NULL,'03 D',NULL,NULL,NULL,0,'Operator E'),
	 (4549,NULL,NULL,NULL,'RD785','2024-03-04 01:52:30','2024-03-04 01:53:00','00:00:30',1,30,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 8','03 N',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4550,NULL,NULL,NULL,'RD786','2024-03-04 03:21:00','2024-03-04 03:21:30','00:00:30',12,360,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,NULL,'03 N',NULL,NULL,NULL,0,NULL),
	 (4553,NULL,NULL,NULL,'RD791','2024-03-04 04:22:30','2024-03-04 04:23:40','00:01:10',1,10,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 5','03 N',NULL,NULL,NULL,0,NULL),
	 (4555,NULL,NULL,NULL,'RD849','2024-03-04 05:51:40','2024-03-04 05:51:40','00:00:00',2,20,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','03 N',NULL,NULL,NULL,0,'Operator J'),
	 (4556,NULL,NULL,NULL,'DZ298','2024-03-04 06:38:50','2024-03-04 06:39:10','00:00:20',5,150,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 8','04 D',NULL,NULL,NULL,0,'Operator B'),
	 (4562,NULL,NULL,NULL,'AHS05','2024-03-04 10:43:30','2024-03-04 10:43:40','00:00:10',1,10,'Tope','Off-Board','Network','Outage','-','Outage',NULL,NULL,'Test Zone 2','04 D',NULL,NULL,NULL,0,'Operator G'),
	 (4566,NULL,NULL,NULL,'AHS10','2024-03-04 10:43:30','2024-03-04 10:43:50','00:00:20',2,30,'Tope','Off-Board','Network','Outage','-','Outage',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator G'),
	 (4575,NULL,NULL,NULL,'AHS22','2024-03-04 10:43:40','2024-03-04 10:43:40','00:00:00',1,10,'Tope','Off-Board','Network','Outage','-','Outage',NULL,NULL,'Test Zone 2','04 D',NULL,NULL,NULL,0,'Operator J'),
	 (4588,NULL,NULL,NULL,'RD839','2024-03-04 11:22:50','2024-03-04 11:22:50','00:00:00',2,20,'AMT','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator A'),
	 (4589,NULL,NULL,NULL,'DZ292','2024-03-04 11:25:40','2024-03-04 11:26:10','00:00:30',13,370,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator E'),
	 (4591,NULL,NULL,NULL,'WC808','2024-03-04 12:14:40','2024-03-04 12:14:50','00:00:10',1,10,'Tope','Off-Board','Network','Outage','-','Outage',NULL,NULL,'Test Zone 9','04 D',NULL,NULL,NULL,0,NULL);
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4595,NULL,NULL,NULL,'RD840','2024-03-04 14:27:30','2024-03-04 14:27:30','00:00:00',2,20,'AMT','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 3','04 D',NULL,NULL,NULL,0,'Operator K'),
	 (4601,NULL,NULL,NULL,'AHS27','2024-03-05 01:38:40','2024-03-05 01:38:50','00:00:10',1,10,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,NULL),
	 (4602,NULL,NULL,NULL,'AHS27','2024-03-05 01:39:30','2024-03-05 01:39:40','00:00:10',1,10,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (4603,NULL,NULL,NULL,'AHS27','2024-03-05 01:40:20','2024-03-05 01:40:30','00:00:10',2,30,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator K'),
	 (4604,NULL,NULL,NULL,'AHS27','2024-03-05 01:41:10','2024-03-05 01:41:20','00:00:10',2,30,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 2','04 N',NULL,NULL,NULL,0,'Operator F'),
	 (4605,NULL,NULL,NULL,'AHS27','2024-03-05 01:42:00','2024-03-05 01:42:10','00:00:10',2,30,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (4606,NULL,NULL,NULL,'AHS27','2024-03-05 01:43:40','2024-03-05 01:43:50','00:00:10',2,20,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 4','04 N',NULL,NULL,NULL,0,'Operator A'),
	 (4607,NULL,NULL,NULL,'AHS27','2024-03-05 01:44:30','2024-03-05 01:44:40','00:00:10',2,20,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (4608,NULL,NULL,NULL,'AHS27','2024-03-05 01:46:10','2024-03-05 01:46:20','00:00:10',3,50,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,NULL,'04 N',NULL,NULL,NULL,0,'Operator F'),
	 (4609,NULL,NULL,NULL,'AHS27','2024-03-05 01:47:00','2024-03-05 01:47:10','00:00:10',3,40,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4610,NULL,NULL,NULL,'AHS27','2024-03-05 01:47:50','2024-03-05 01:48:00','00:00:10',3,40,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator H'),
	 (4614,NULL,NULL,NULL,'AHS27','2024-03-05 02:56:10','2024-03-05 02:56:20','00:00:10',3,40,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator B'),
	 (4615,NULL,NULL,NULL,'AHS27','2024-03-05 03:00:20','2024-03-05 03:00:30','00:00:10',2,40,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (4616,NULL,NULL,NULL,'AHS27','2024-03-05 03:01:10','2024-03-05 03:01:20','00:00:10',2,40,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator I'),
	 (4617,NULL,NULL,NULL,'AHS27','2024-03-05 03:02:00','2024-03-05 03:02:10','00:00:10',2,30,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (4618,NULL,NULL,NULL,'AHS27','2024-03-05 03:02:50','2024-03-05 03:03:00','00:00:10',2,20,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (4621,NULL,NULL,NULL,'RD838','2024-03-05 03:44:50','2024-03-05 03:44:50','00:00:00',10,100,'AMT','On-Board','Systems','G407','-','G407',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator D'),
	 (4626,NULL,NULL,NULL,'RD837','2024-03-05 12:20:10','2024-03-05 12:20:10','00:00:00',1,10,'AMT','Off-Board','OT Network','Roaming','-','Roaming / Hand over',NULL,NULL,'Test Zone 2','05 D',NULL,NULL,NULL,0,NULL),
	 (4630,NULL,NULL,NULL,'DZ300','2024-03-05 18:04:10','2024-03-05 18:05:30','00:01:20',1,20,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 10','05 N',NULL,NULL,NULL,0,'Operator C'),
	 (4640,NULL,NULL,NULL,'EX62','2024-03-05 22:47:00','2024-03-05 22:47:10','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 2','05 N',NULL,NULL,NULL,0,'Operator B');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4656,NULL,NULL,NULL,'AHS02','2024-03-06 05:28:50','2024-03-06 05:29:30','00:00:40',3,60,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 7','05 N',NULL,NULL,NULL,0,'Operator D'),
	 (4662,NULL,NULL,NULL,'RD837','2024-03-06 08:07:30','2024-03-06 08:08:00','00:00:30',1,10,'AMT','On-Board','UE','Cabling','Antenna System','UE Antenna',NULL,NULL,'Test Zone 3','06 D',NULL,NULL,NULL,0,'Operator D'),
	 (4663,NULL,NULL,NULL,'AHS27','2024-03-06 11:32:40','2024-03-06 11:32:40','00:00:00',2,20,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 8','06 D',NULL,NULL,NULL,0,'Operator I'),
	 (4674,NULL,NULL,NULL,'RD838','2024-03-06 18:19:10','2024-03-06 18:19:10','00:00:00',2,20,'AMT','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 3','06 N',NULL,NULL,NULL,0,'Operator H'),
	 (4677,NULL,NULL,NULL,'DZ300','2024-03-06 18:30:40','2024-03-06 18:33:10','00:02:30',2,230,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 5','06 N',NULL,NULL,NULL,0,'Operator C'),
	 (4680,NULL,NULL,NULL,'DZ300','2024-03-06 19:01:00','2024-03-06 19:02:20','00:01:20',2,140,'Terrain','On-Board','Systems','Application','Terrain','Crash Terrain',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,'Operator D'),
	 (4681,NULL,NULL,NULL,'DZ300','2024-03-06 19:29:50','2024-03-06 19:30:50','00:01:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 5','06 N',NULL,NULL,NULL,0,'Operator E'),
	 (4694,NULL,NULL,NULL,'RD786','2024-03-06 23:22:40','2024-03-06 23:24:00','00:01:20',12,1050,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,NULL),
	 (4701,NULL,NULL,NULL,'RD838','2024-03-07 03:16:10','2024-03-07 03:16:10','00:00:00',1,10,'AMT','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 6','06 N',NULL,NULL,NULL,0,'Operator G'),
	 (4702,NULL,NULL,NULL,'DZ300','2024-03-07 03:28:10','2024-03-07 03:28:30','00:00:20',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 10','06 N',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4703,NULL,NULL,NULL,'DZ300','2024-03-07 03:29:50','2024-03-07 03:30:50','00:01:00',2,40,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,'Operator J'),
	 (4709,NULL,NULL,NULL,'RD788','2024-03-07 07:21:50','2024-03-07 07:24:20','00:02:30',10,1500,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 3','07 D',NULL,NULL,NULL,0,'Operator B'),
	 (4711,NULL,NULL,NULL,'DZ300','2024-03-07 08:56:50','2024-03-07 09:01:30','00:04:40',3,510,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 2','07 D','Jarrod Ollington',NULL,NULL,0,NULL),
	 (4712,NULL,NULL,NULL,'DZ297','2024-03-07 09:41:40','2024-03-07 09:42:50','00:01:10',1,20,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 10','07 D','Shaun Lake',NULL,NULL,0,'Operator D'),
	 (4717,NULL,NULL,NULL,'RD783','2024-03-07 14:02:10','2024-03-07 14:03:00','00:00:50',8,480,'AMT','On-Board','Systems','Application','AMT','CAT Router',NULL,NULL,'Test Zone 6','07 D',NULL,NULL,NULL,0,'Operator J'),
	 (4719,NULL,NULL,NULL,'RD783','2024-03-07 14:08:40','2024-03-07 14:09:10','00:00:30',10,310,'AMT','On-Board','Systems','Application','AMT','CAT Router',NULL,NULL,'Test Zone 9','07 D',NULL,NULL,NULL,0,'Operator C'),
	 (4720,NULL,NULL,NULL,'RD785','2024-03-07 16:21:10','2024-03-07 16:23:00','00:01:50',11,1250,'AMT','On-Board','Systems','Application','AMT','CAT Router',NULL,NULL,'Test Zone 9','07 D',NULL,NULL,NULL,0,'Operator A'),
	 (4721,NULL,NULL,NULL,'RD785','2024-03-07 16:23:40','2024-03-07 16:25:10','00:01:30',11,1090,'AMT','On-Board','Systems','Application','AMT','CAT Router',NULL,NULL,'Test Zone 6','07 D',NULL,NULL,NULL,0,'Operator F'),
	 (4760,NULL,NULL,NULL,'RD790','2024-03-08 02:04:30','2024-03-08 02:05:30','00:01:00',12,790,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 3','07 N',NULL,NULL,NULL,0,'Operator K'),
	 (4771,NULL,NULL,NULL,'RD849','2024-03-08 05:51:20','2024-03-08 05:51:20','00:00:00',2,20,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 5','07 N',NULL,NULL,NULL,0,'Operator J');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4776,NULL,NULL,NULL,'DZ306','2024-03-08 06:51:00','2024-03-08 06:51:30','00:00:30',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 8','08 D',NULL,NULL,NULL,0,'Operator B'),
	 (4775,NULL,NULL,NULL,'DZ291','2024-03-08 06:51:00','2024-03-08 06:51:20','00:00:20',1,30,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 9','08 D',NULL,NULL,NULL,0,'Operator G'),
	 (4785,NULL,NULL,NULL,'RD848','2024-03-08 16:22:40','2024-03-08 16:22:50','00:00:10',4,40,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 3','08 D',NULL,NULL,NULL,0,'Operator H'),
	 (4803,NULL,NULL,NULL,'RD838','2024-03-08 19:10:30','2024-03-08 19:10:30','00:00:00',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 2','08 N',NULL,NULL,NULL,0,NULL),
	 (4809,NULL,NULL,NULL,'RD841','2024-03-09 01:10:10','2024-03-09 01:14:10','00:04:00',11,2210,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,NULL,'08 N',NULL,NULL,NULL,0,'Operator A'),
	 (4810,NULL,NULL,NULL,'RD841','2024-03-09 01:18:00','2024-03-09 01:18:30','00:00:30',9,250,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 5','08 N',NULL,NULL,NULL,0,'Operator F'),
	 (4811,NULL,NULL,NULL,'RD841','2024-03-09 01:18:50','2024-03-09 01:20:50','00:02:00',11,1250,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,NULL,'08 N',NULL,NULL,NULL,0,'Operator E'),
	 (4814,NULL,NULL,NULL,'RD840','2024-03-09 04:42:00','2024-03-09 04:42:50','00:00:50',6,150,'AMT','Off-Board','Network','Roaming','-','Roaming',NULL,NULL,'Test Zone 7','08 N',NULL,NULL,NULL,0,NULL),
	 (4815,NULL,NULL,NULL,'RD841','2024-03-09 05:35:10','2024-03-09 05:40:10','00:05:00',11,2940,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 7','08 N',NULL,NULL,NULL,0,NULL),
	 (4816,NULL,NULL,NULL,'DZ298','2024-03-09 06:01:20','2024-03-09 06:01:50','00:00:30',11,440,'Terrain','On-Board','Power','-','-','Power Supply',NULL,NULL,'Test Zone 5','09 D','power',NULL,NULL,0,'Operator F');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4817,NULL,NULL,NULL,'DZ298','2024-03-09 06:02:20','2024-03-09 06:02:20','00:00:00',9,90,'Terrain','On-Board','Power','-','-','Power Supply',NULL,NULL,'Test Zone 7','09 D','power',NULL,NULL,0,'Operator K'),
	 (4818,NULL,NULL,NULL,'GR493','2024-03-09 06:33:20','2024-03-09 06:34:00','00:00:40',4,120,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 2','09 D',NULL,NULL,NULL,0,'Operator E'),
	 (4819,NULL,NULL,NULL,'DZ293','2024-03-09 06:56:50','2024-03-09 06:58:50','00:02:00',1,110,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 10','09 D',NULL,NULL,NULL,0,'Operator I'),
	 (4821,NULL,NULL,NULL,'DZ297','2024-03-09 10:20:40','2024-03-09 10:23:10','00:02:30',1,150,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 6','09 D',NULL,NULL,NULL,0,'Operator F'),
	 (4823,NULL,NULL,NULL,'ST168','2024-03-09 10:45:30','2024-03-09 10:45:50','00:00:20',1,10,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 6','09 D',NULL,NULL,NULL,0,NULL),
	 (4824,NULL,NULL,NULL,'ST168','2024-03-09 10:46:20','2024-03-09 10:46:40','00:00:20',2,40,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 4','09 D',NULL,NULL,NULL,0,NULL),
	 (4825,NULL,NULL,NULL,'ST168','2024-03-09 10:47:10','2024-03-09 10:47:30','00:00:20',2,30,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,NULL,'09 D',NULL,NULL,NULL,0,'Operator D'),
	 (4826,NULL,NULL,NULL,'ST168','2024-03-09 10:48:00','2024-03-09 10:48:20','00:00:20',2,20,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 5','09 D',NULL,NULL,NULL,0,'Operator J'),
	 (4827,NULL,NULL,NULL,'ST168','2024-03-09 10:48:50','2024-03-09 10:49:10','00:00:20',1,10,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 9','09 D',NULL,NULL,NULL,0,'Operator I'),
	 (4828,NULL,NULL,NULL,'ST168','2024-03-09 10:49:40','2024-03-09 10:50:00','00:00:20',1,20,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 7','09 D',NULL,NULL,NULL,0,'Operator H');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4831,NULL,NULL,NULL,'GR493','2024-03-09 11:47:20','2024-03-09 11:48:20','00:01:00',2,110,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,NULL,'09 D',NULL,NULL,NULL,0,'Operator B'),
	 (4832,NULL,NULL,NULL,'AHS02','2024-03-09 12:35:10','2024-03-09 12:35:40','00:00:30',3,30,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 4','09 D',NULL,NULL,NULL,0,'Operator E'),
	 (4833,NULL,NULL,NULL,'GR493','2024-03-09 16:45:00','2024-03-09 16:46:00','00:01:00',5,220,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 1','09 D',NULL,NULL,NULL,0,'Operator K'),
	 (4834,NULL,NULL,NULL,'GR493','2024-03-09 16:46:30','2024-03-09 16:48:30','00:02:00',9,640,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 7','09 D',NULL,NULL,NULL,0,'Operator C'),
	 (4854,NULL,NULL,NULL,'RD841','2024-03-09 21:14:40','2024-03-09 21:14:40','00:00:00',2,20,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 5','09 N',NULL,NULL,NULL,0,'Operator I'),
	 (4855,NULL,NULL,NULL,'RD839','2024-03-09 22:24:00','2024-03-09 22:24:00','00:00:00',2,20,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 4','09 N',NULL,NULL,NULL,0,'Operator B'),
	 (4856,NULL,NULL,NULL,'RD837','2024-03-10 00:33:20','2024-03-10 00:33:20','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 7','09 N',NULL,NULL,NULL,0,'Operator B'),
	 (4857,NULL,NULL,NULL,'RD782','2024-03-10 02:24:30','2024-03-10 02:25:10','00:00:40',12,560,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 5','09 N',NULL,NULL,NULL,0,'Operator E'),
	 (4858,NULL,NULL,NULL,'RD840','2024-03-10 04:14:20','2024-03-10 04:14:20','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 4','09 N',NULL,NULL,NULL,0,'Operator B'),
	 (4859,NULL,NULL,NULL,'GR493','2024-03-10 06:27:20','2024-03-10 06:28:20','00:01:00',2,80,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 4','10 D',NULL,NULL,NULL,0,'Operator C');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4860,NULL,NULL,NULL,'GR493','2024-03-10 06:29:00','2024-03-10 06:31:00','00:02:00',13,630,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 1','10 D',NULL,NULL,NULL,0,'Operator G'),
	 (4861,NULL,NULL,NULL,'GR493','2024-03-10 06:53:30','2024-03-10 06:54:50','00:01:20',7,330,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 8','10 D',NULL,NULL,NULL,0,'Operator G'),
	 (4862,NULL,NULL,NULL,'GR493','2024-03-10 07:03:10','2024-03-10 07:04:40','00:01:30',6,300,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 8','10 D',NULL,NULL,NULL,0,'Operator H'),
	 (4873,NULL,NULL,NULL,'RD837','2024-03-10 15:18:20','2024-03-10 15:18:20','00:00:00',7,70,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 6','10 D',NULL,NULL,NULL,0,'Operator B'),
	 (4874,NULL,NULL,NULL,'EX61','2024-03-10 15:42:30','2024-03-10 15:43:40','00:01:10',7,530,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 5','10 D',NULL,NULL,NULL,0,'Operator G'),
	 (4877,NULL,NULL,NULL,'DZ300','2024-03-10 17:23:30','2024-03-10 17:26:40','00:03:10',3,190,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,NULL,'10 D',NULL,NULL,NULL,0,'Operator F'),
	 (4879,NULL,NULL,NULL,'RD781','2024-03-11 10:16:00','2024-03-11 10:16:50','00:00:50',9,360,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 2','11 D',NULL,NULL,NULL,0,'Operator J'),
	 (4880,NULL,NULL,NULL,'RD781','2024-03-11 10:25:20','2024-03-11 10:26:00','00:00:40',10,370,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 2','11 D',NULL,NULL,NULL,0,NULL),
	 (4884,NULL,NULL,NULL,'DZ300','2024-03-11 15:40:50','2024-03-11 15:44:40','00:03:50',3,260,'Terrain','On-Board','Systems','Application','Terrain','Terrain',NULL,NULL,'Test Zone 3','11 D',NULL,NULL,NULL,0,'Operator F'),
	 (4886,NULL,NULL,NULL,'RD849','2024-03-12 07:02:20','2024-03-12 07:03:00','00:00:40',2,60,'AMT','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 7','12 D',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4902,NULL,NULL,NULL,'RD790','2024-03-12 20:45:00','2024-03-12 20:45:20','00:00:20',6,180,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 1','12 N',NULL,NULL,NULL,0,'Operator B'),
	 (4905,NULL,NULL,NULL,'RD779','2024-03-12 23:58:00','2024-03-12 23:59:00','00:01:00',8,480,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 10','12 N',NULL,NULL,NULL,0,'Operator J'),
	 (4906,NULL,NULL,NULL,'RD839','2024-03-13 00:10:40','2024-03-13 00:11:40','00:01:00',7,340,'Tope','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 2','12 N',NULL,NULL,NULL,0,'Operator H'),
	 (4908,NULL,NULL,NULL,'RD849','2024-03-13 04:23:00','2024-03-13 04:23:00','00:00:00',2,20,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,NULL,'12 N',NULL,NULL,NULL,0,'Operator I'),
	 (4910,NULL,NULL,NULL,'RD778','2024-03-13 07:17:50','2024-03-13 07:17:50','00:00:00',1,10,'AMT','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 5','13 D',NULL,NULL,NULL,0,'Operator K'),
	 (4911,NULL,NULL,NULL,'RD779','2024-03-13 07:57:40','2024-03-13 07:57:50','00:00:10',10,140,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 5','13 D',NULL,NULL,NULL,0,NULL),
	 (4928,NULL,NULL,NULL,'DZ300','2024-03-13 19:00:30','2024-03-13 19:01:00','00:00:30',2,40,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 5','13 N',NULL,NULL,NULL,0,'Operator C'),
	 (4930,NULL,NULL,NULL,'DZ300','2024-03-13 19:30:10','2024-03-13 19:33:20','00:03:10',6,480,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,'Test Zone 2','13 N','G610 Isolation',NULL,NULL,0,'Operator F'),
	 (4932,NULL,NULL,NULL,'RD787','2024-03-13 22:18:40','2024-03-13 22:19:30','00:00:50',12,500,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,NULL,'13 N',NULL,NULL,NULL,0,'Operator B'),
	 (4933,NULL,NULL,NULL,'RD787','2024-03-13 22:31:50','2024-03-13 22:32:20','00:00:30',12,390,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 3','13 N',NULL,NULL,NULL,0,'Operator G');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (4934,NULL,NULL,NULL,'RD850','2024-03-13 22:51:10','2024-03-13 22:51:10','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 2','13 N',NULL,NULL,NULL,0,'Operator H'),
	 (4936,NULL,NULL,NULL,'RD787','2024-03-13 23:03:00','2024-03-13 23:03:20','00:00:20',8,240,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 8','13 N',NULL,NULL,NULL,0,NULL),
	 (4937,NULL,NULL,NULL,'RD787','2024-03-13 23:53:00','2024-03-13 23:53:50','00:00:50',12,620,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 6','13 N',NULL,NULL,NULL,0,'Operator K'),
	 (4974,3,NULL,NULL,'RD839','2024-03-14 06:50:10','2024-03-14 06:50:10','00:00:00',12,120,'AMT','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 10','14 D','go-line',NULL,NULL,0,'Operator K'),
	 (4981,3,NULL,NULL,'DZ293','2024-03-14 10:15:20','2024-03-14 10:23:10','00:07:50',1,130,'Terrain','Process','Procedure','-','-','Procedure','LTE01','LTE Tower','Test Zone 9','14 D',NULL,NULL,NULL,0,'Operator B'),
	 (4993,3,NULL,NULL,'RD778','2024-03-14 10:18:30','2024-03-14 10:19:10','00:00:40',1,20,'AMT','Process','Procedure','-','-','Procedure','LTE01','LTE Tower','Test Zone 10','14 D','RF shadowing a factor',NULL,NULL,0,NULL),
	 (5001,3,NULL,NULL,'DZ293','2024-03-14 10:27:10','2024-03-14 10:28:00','00:00:50',3,180,'Terrain','Process','Procedure','-','-','Procedure','LTE01','LTE Tower',NULL,'14 D',NULL,NULL,NULL,0,'Operator A'),
	 (5035,NULL,NULL,NULL,'RD843','2024-03-14 21:43:40','2024-03-14 21:43:40','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 9','14 N',NULL,NULL,NULL,0,'Operator D'),
	 (5039,NULL,NULL,NULL,'RD785','2024-03-15 10:04:20','2024-03-15 10:04:40','00:00:20',8,210,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 8','15 D',NULL,NULL,NULL,0,'Operator D'),
	 (5040,NULL,NULL,NULL,'RD839','2024-03-15 11:26:30','2024-03-15 11:26:30','00:00:00',1,10,'AMT','On-Board','Systems','Application','AMT','Lost Position Accuracy AMT',NULL,NULL,'Test Zone 2','15 D',NULL,NULL,NULL,0,'Operator H');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5051,NULL,NULL,NULL,'RD842','2024-03-15 18:24:00','2024-03-15 18:24:00','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 8','15 N',NULL,NULL,NULL,0,'Operator K'),
	 (5052,NULL,NULL,NULL,'AHS16','2024-03-16 02:52:00','2024-03-16 02:52:40','00:00:40',5,150,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 3','15 N',NULL,NULL,NULL,0,'Operator K'),
	 (5054,NULL,NULL,NULL,'AHS16','2024-03-16 03:48:30','2024-03-16 03:49:00','00:00:30',3,70,'Tope','On-Board','Systems','G407','-','G407',NULL,NULL,'Test Zone 1','15 N','G407 Isolation',NULL,NULL,0,'Operator H'),
	 (5060,NULL,NULL,NULL,'RD783','2024-03-16 08:25:50','2024-03-16 08:26:10','00:00:20',12,310,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 9','16 D',NULL,NULL,NULL,0,'Operator B'),
	 (5061,NULL,NULL,NULL,'DZ297','2024-03-16 10:05:40','2024-03-16 10:07:00','00:01:20',1,40,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,NULL,'16 D',NULL,NULL,NULL,0,'Operator F'),
	 (5063,NULL,NULL,NULL,'AHS09','2024-03-16 14:13:50','2024-03-16 14:14:20','00:00:30',3,30,'Tope','Off-Board','Network','Roaming','-','Roaming',NULL,NULL,'Test Zone 3','16 D',NULL,NULL,NULL,0,'Operator K'),
	 (5064,NULL,NULL,NULL,'DZ298','2024-03-16 16:29:00','2024-03-16 16:30:40','00:01:40',2,190,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 6','16 D',NULL,NULL,NULL,0,'Operator B'),
	 (5066,NULL,NULL,NULL,'EX17','2024-03-16 17:27:10','2024-03-16 17:31:10','00:04:00',2,220,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 6','16 D',NULL,NULL,NULL,0,'Operator H'),
	 (5067,NULL,NULL,NULL,'DZ300','2024-03-16 17:39:30','2024-03-16 17:40:10','00:00:40',1,40,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 2','16 D',NULL,NULL,NULL,0,'Operator J'),
	 (5069,NULL,NULL,NULL,'RD793','2024-03-16 19:17:10','2024-03-16 19:17:20','00:00:10',11,110,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 10','16 N',NULL,NULL,NULL,0,'Operator H');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5070,NULL,NULL,NULL,'DZ300','2024-03-16 19:22:50','2024-03-16 19:23:40','00:00:50',1,20,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 5','16 N',NULL,NULL,NULL,0,'Operator F'),
	 (5072,NULL,NULL,NULL,'DZ290','2024-03-17 09:06:30','2024-03-17 09:09:10','00:02:40',2,280,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 3','17 D',NULL,NULL,NULL,0,'Operator H'),
	 (5076,NULL,NULL,NULL,'RD784','2024-03-17 10:55:10','2024-03-17 10:55:30','00:00:20',2,30,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','17 D',NULL,NULL,NULL,0,'Operator A'),
	 (5088,NULL,NULL,NULL,'AHS19','2024-03-17 12:33:50','2024-03-17 12:33:50','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 1','17 D',NULL,NULL,NULL,0,'Operator F'),
	 (5164,NULL,NULL,NULL,'EX59','2024-03-17 23:47:20','2024-03-17 23:47:40','00:00:20',3,60,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 2','17 N',NULL,NULL,NULL,0,'Operator D'),
	 (5165,NULL,NULL,NULL,'AHS08','2024-03-17 23:59:10','2024-03-17 23:59:10','00:00:00',1,10,'Tope','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','17 N',NULL,NULL,NULL,0,'Operator I'),
	 (5176,NULL,NULL,NULL,'AHS02','2024-03-18 03:18:10','2024-03-18 03:18:40','00:00:30',3,50,'Tope','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 1','17 N',NULL,NULL,NULL,0,'Operator C'),
	 (5178,NULL,NULL,NULL,'GR493','2024-03-18 04:17:10','2024-03-18 04:21:10','00:04:00',2,100,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 9','17 N',NULL,NULL,NULL,0,'Operator C'),
	 (5186,NULL,NULL,NULL,'DZ297','2024-03-18 08:41:00','2024-03-18 08:43:00','00:02:00',1,20,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,'Test Zone 3','18 D',NULL,NULL,NULL,0,'Operator F'),
	 (5187,NULL,NULL,NULL,'DZ290','2024-03-18 09:42:30','2024-03-18 09:44:10','00:01:40',2,80,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 9','18 D','Suzue Mckean',NULL,NULL,0,'Operator B');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5193,NULL,NULL,NULL,'DZ297','2024-03-18 15:34:30','2024-03-18 15:35:20','00:00:50',2,110,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,NULL,'18 D',NULL,NULL,NULL,0,NULL),
	 (5207,NULL,NULL,NULL,'DZ297','2024-03-18 19:38:30','2024-03-18 19:39:40','00:01:10',2,80,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,'Test Zone 6','18 N',NULL,NULL,NULL,0,'Operator K'),
	 (5217,NULL,NULL,NULL,'EX62','2024-03-19 02:35:10','2024-03-19 02:35:50','00:00:40',1,40,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,'Test Zone 4','18 N',NULL,NULL,NULL,0,NULL),
	 (5218,NULL,NULL,NULL,'DZ298','2024-03-19 03:28:50','2024-03-19 03:29:20','00:00:30',1,30,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,NULL,'18 N',NULL,NULL,NULL,0,'Operator B'),
	 (5220,NULL,NULL,NULL,'RD781','2024-03-19 08:06:10','2024-03-19 08:06:30','00:00:20',10,280,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 2','19 D',NULL,NULL,NULL,0,'Operator D'),
	 (5221,NULL,NULL,NULL,'LO228','2024-03-19 09:52:10','2024-03-19 09:54:10','00:02:00',6,410,'Terrain','On-Board','Systems','G407','-','G407',NULL,NULL,'Test Zone 10','19 D',NULL,NULL,NULL,0,'Operator A'),
	 (5235,NULL,NULL,NULL,'AHS25','2024-03-19 14:49:50','2024-03-19 14:49:50','00:00:00',1,10,'Tope','Off-Board','RF Shadowing','-','-','Shadowing',NULL,NULL,'Test Zone 7','19 D',NULL,NULL,NULL,0,'Operator I'),
	 (5259,NULL,NULL,NULL,'GR494','2024-03-19 15:24:30','2024-03-19 15:25:20','00:00:50',1,30,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 6','19 D',NULL,NULL,NULL,0,'Operator A'),
	 (5251,NULL,NULL,NULL,'AHS08','2024-03-19 15:24:30','2024-03-19 15:24:30','00:00:00',1,10,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 5','19 D',NULL,NULL,NULL,0,'Operator F'),
	 (5247,NULL,NULL,NULL,'AHS18','2024-03-19 15:24:30','2024-03-19 15:26:50','00:02:20',1,30,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 9','19 D',NULL,NULL,NULL,0,'Operator I');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5244,NULL,NULL,NULL,'AHS22','2024-03-19 15:24:30','2024-03-19 15:26:50','00:02:20',1,10,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 1','19 D',NULL,NULL,NULL,0,'Operator I'),
	 (5239,NULL,NULL,NULL,'AHS01','2024-03-19 15:24:30','2024-03-19 15:26:50','00:02:20',1,30,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 5','19 D',NULL,NULL,NULL,0,'Operator H'),
	 (5263,NULL,NULL,NULL,'GR496','2024-03-19 15:25:00','2024-03-19 15:27:10','00:02:10',10,440,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 7','19 D',NULL,NULL,NULL,0,NULL),
	 (5264,NULL,NULL,NULL,'AHS08','2024-03-19 15:25:10','2024-03-19 15:30:10','00:05:00',11,1680,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 10','19 D',NULL,NULL,NULL,0,'Operator A'),
	 (5265,NULL,NULL,NULL,'EX59','2024-03-19 15:25:40','2024-03-19 15:27:40','00:02:00',3,110,'Terrain','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 3','19 D',NULL,NULL,NULL,0,'Operator H'),
	 (5268,NULL,NULL,NULL,'AHS08','2024-03-19 15:30:50','2024-03-19 15:31:10','00:00:20',11,220,'Tope','Off-Board','Network','Backhaul Fault','-','Backhaul Fault',NULL,NULL,'Test Zone 9','19 D',NULL,NULL,NULL,0,NULL),
	 (5271,NULL,NULL,NULL,'DR0997','2024-03-19 15:50:10','2024-03-19 15:51:40','00:01:30',2,50,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 5','19 D',NULL,NULL,NULL,0,'Operator J'),
	 (5274,NULL,NULL,NULL,'DZ300','2024-03-19 16:31:10','2024-03-19 16:31:10','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 1','19 D',NULL,NULL,NULL,0,'Operator C'),
	 (5336,NULL,NULL,NULL,'RD784','2024-03-19 19:45:00','2024-03-19 19:45:20','00:00:20',11,220,'AMT','On-Board','Systems','Application','AMT','Lost Position Accuracy AMT',NULL,NULL,NULL,'19 N',NULL,NULL,NULL,0,'Operator A'),
	 (5338,NULL,NULL,NULL,'RD785','2024-03-20 04:01:00','2024-03-20 04:01:40','00:00:40',2,20,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 8','19 N',NULL,NULL,NULL,0,'Operator F');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5346,NULL,NULL,NULL,'DZ300','2024-03-20 10:30:10','2024-03-20 10:31:10','00:01:00',1,50,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 3','20 D',NULL,NULL,NULL,0,'Operator C'),
	 (5348,NULL,NULL,NULL,'DR1030','2024-03-20 12:28:50','2024-03-20 12:30:50','00:02:00',1,10,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 1','20 D',NULL,NULL,NULL,0,'Operator G'),
	 (5384,NULL,NULL,NULL,'GR493','2024-03-20 13:33:30','2024-03-20 13:33:40','00:00:10',2,20,'Tope','Off-Board','IT Network','Core IT','-','Core IT Network Equipment',NULL,NULL,'Test Zone 5','20 D',NULL,NULL,NULL,0,'Operator A'),
	 (5397,NULL,NULL,NULL,'RD785','2024-03-20 15:23:00','2024-03-20 15:23:30','00:00:30',13,500,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 9','20 D',NULL,NULL,NULL,0,'Operator J'),
	 (5398,NULL,NULL,NULL,'EX61','2024-03-20 15:41:50','2024-03-20 15:43:00','00:01:10',9,630,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 3','20 D',NULL,NULL,NULL,0,'Operator J'),
	 (5399,NULL,NULL,NULL,'AHS02','2024-03-20 15:46:00','2024-03-20 15:46:40','00:00:40',2,60,'Tope','On-Board','Systems','Application','TOPE','High PR2 startup TOPE',NULL,NULL,'Test Zone 3','20 D',NULL,NULL,NULL,0,'Operator H'),
	 (5402,NULL,NULL,NULL,'GR493','2024-03-20 16:51:30','2024-03-20 16:52:30','00:01:00',3,170,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 2','20 D',NULL,NULL,NULL,0,'Operator F'),
	 (5404,NULL,NULL,NULL,'GR493','2024-03-20 17:04:40','2024-03-20 17:05:50','00:01:10',11,560,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 1','20 D',NULL,NULL,NULL,0,'Operator B'),
	 (5406,NULL,NULL,NULL,'GR493','2024-03-20 17:07:40','2024-03-20 17:08:30','00:00:50',4,70,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 8','20 D',NULL,NULL,NULL,0,'Operator D'),
	 (5407,NULL,NULL,NULL,'DZ300','2024-03-20 17:21:00','2024-03-20 17:22:00','00:01:00',2,70,'Terrain','On-Board','Systems','Application','Terrain','Terrain',NULL,NULL,'Test Zone 6','20 D',NULL,NULL,NULL,0,'Operator B');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5408,NULL,NULL,NULL,'RD848','2024-03-20 17:29:20','2024-03-20 17:32:00','00:02:40',9,840,'AMT','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 8','20 D',NULL,NULL,NULL,0,'Operator G'),
	 (5478,NULL,NULL,NULL,'RD783','2024-03-20 18:20:10','2024-03-20 18:20:40','00:00:30',6,240,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 7','20 N',NULL,NULL,NULL,0,'Operator F'),
	 (5480,NULL,NULL,NULL,'LO228','2024-03-20 18:41:10','2024-03-20 18:42:20','00:01:10',1,10,'Terrain','On-Board','Systems','Application','TOPE','Crash TOPE',NULL,NULL,'Test Zone 2','20 N',NULL,NULL,NULL,0,NULL),
	 (5482,NULL,NULL,NULL,'AHS02','2024-03-20 21:17:30','2024-03-20 21:18:30','00:01:00',13,740,'Tope','On-Board','Systems','Application','TOPE','No pos data in PR2 TOPE',NULL,NULL,'Test Zone 9','20 N',NULL,NULL,NULL,0,'Operator D'),
	 (5483,NULL,NULL,NULL,'GR493','2024-03-20 22:19:50','2024-03-20 22:20:10','00:00:20',2,20,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 8','20 N',NULL,NULL,NULL,0,'Operator B'),
	 (5484,NULL,NULL,NULL,'GR493','2024-03-20 22:20:50','2024-03-20 22:21:40','00:00:50',8,220,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 8','20 N',NULL,NULL,NULL,0,'Operator K'),
	 (5485,NULL,NULL,NULL,'GR493','2024-03-21 00:25:30','2024-03-21 00:26:50','00:01:20',3,60,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 10','20 N',NULL,NULL,NULL,0,'Operator D'),
	 (5486,NULL,NULL,NULL,'GR493','2024-03-21 00:27:10','2024-03-21 00:28:40','00:01:30',4,80,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 1','20 N',NULL,NULL,NULL,0,'Operator A'),
	 (5490,NULL,NULL,NULL,'RD841','2024-03-21 04:44:00','2024-03-21 04:44:00','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 3','20 N',NULL,NULL,NULL,0,'Operator I'),
	 (5498,NULL,NULL,NULL,'RD779','2024-03-21 08:38:10','2024-03-21 08:38:50','00:00:40',14,700,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 10','21 D',NULL,NULL,NULL,0,'Operator A');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5504,NULL,NULL,NULL,'RD779','2024-03-21 13:13:50','2024-03-21 13:16:40','00:02:50',10,520,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 10','21 D',NULL,NULL,NULL,0,'Operator D'),
	 (5508,NULL,NULL,NULL,'RD779','2024-03-21 15:40:00','2024-03-21 15:40:40','00:00:40',1,10,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','21 D',NULL,NULL,NULL,0,NULL),
	 (5509,NULL,NULL,NULL,'RD779','2024-03-21 15:41:40','2024-03-21 15:42:00','00:00:20',2,50,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 7','21 D',NULL,NULL,NULL,0,'Operator B'),
	 (5515,NULL,NULL,NULL,'RD779','2024-03-21 15:50:50','2024-03-21 15:51:30','00:00:40',2,40,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 5','21 D',NULL,NULL,NULL,0,'Operator K'),
	 (5516,NULL,NULL,NULL,'RD779','2024-03-21 15:52:40','2024-03-21 15:53:50','00:01:10',3,130,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','21 D',NULL,NULL,NULL,0,'Operator F'),
	 (5517,NULL,NULL,NULL,'RD779','2024-03-21 15:54:30','2024-03-21 15:55:20','00:00:50',2,30,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 1','21 D',NULL,NULL,NULL,0,NULL),
	 (5518,NULL,NULL,NULL,'RD779','2024-03-21 15:56:30','2024-03-21 15:57:00','00:00:30',6,190,'AMT','On-Board','Systems','GPS','-','GPS',NULL,NULL,NULL,'21 D',NULL,NULL,NULL,0,NULL),
	 (5528,NULL,NULL,NULL,'RD783','2024-03-22 03:10:20','2024-03-22 03:10:50','00:00:30',1,30,'AMT','On-Board','Systems','Application','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 9','21 N',NULL,NULL,NULL,0,'Operator A'),
	 (5535,NULL,NULL,NULL,'RD793','2024-03-22 09:33:50','2024-03-22 09:34:50','00:01:00',5,270,'AMT','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 7','22 D',NULL,NULL,NULL,0,'Operator G'),
	 (5536,NULL,NULL,NULL,'DZ300','2024-03-22 09:47:20','2024-03-22 09:52:30','00:05:10',1,190,'Terrain','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 8','22 D',NULL,NULL,NULL,0,NULL);
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5537,NULL,NULL,NULL,'WC808','2024-03-22 12:00:40','2024-03-22 12:02:10','00:01:30',8,470,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,NULL,'22 D',NULL,NULL,NULL,0,'Operator F'),
	 (5550,NULL,NULL,NULL,'RD785','2024-03-22 16:01:50','2024-03-22 16:02:00','00:00:10',1,10,'AMT','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 5','22 D',NULL,NULL,NULL,0,'Operator F'),
	 (5553,NULL,NULL,NULL,'EX17','2024-03-22 17:29:30','2024-03-22 17:33:20','00:03:50',2,250,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 8','22 D',NULL,NULL,NULL,0,'Operator J'),
	 (5555,NULL,NULL,NULL,'GR496','2024-03-22 17:48:40','2024-03-22 17:49:20','00:00:40',9,360,'Tope','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 7','22 D',NULL,NULL,NULL,0,'Operator B'),
	 (5556,NULL,NULL,NULL,'EX17','2024-03-22 18:11:20','2024-03-22 18:12:20','00:01:00',7,430,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 2','22 N',NULL,NULL,NULL,0,'Operator I'),
	 (5558,NULL,NULL,NULL,'AHS15','2024-03-22 20:58:00','2024-03-22 20:58:00','00:00:00',1,10,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 2','22 N',NULL,NULL,NULL,0,'Operator E'),
	 (5559,NULL,NULL,NULL,'AHS15','2024-03-22 21:28:30','2024-03-22 21:28:30','00:00:00',2,20,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 1','22 N',NULL,NULL,NULL,0,NULL),
	 (5566,NULL,NULL,NULL,'RD839','2024-03-23 02:32:00','2024-03-23 02:32:00','00:00:00',8,80,'AMT','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 8','22 N',NULL,NULL,NULL,0,'Operator D'),
	 (5567,NULL,NULL,NULL,'AHS15','2024-03-23 03:40:50','2024-03-23 03:40:50','00:00:00',3,30,'Tope','On-Board','Systems','Application','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 2','22 N',NULL,NULL,NULL,0,'Operator D'),
	 (5576,NULL,NULL,NULL,'AHS04','2024-03-23 08:35:20','2024-03-23 08:36:00','00:00:40',1,10,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 10','23 D',NULL,NULL,NULL,0,'Operator J');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5577,NULL,NULL,NULL,'RD842','2024-03-23 09:26:10','2024-03-23 09:26:10','00:00:00',5,50,'AMT','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 4','23 D','Start-up no HPGPS fix',NULL,NULL,0,'Operator E'),
	 (5580,NULL,NULL,NULL,'AHS08','2024-03-23 12:20:10','2024-03-23 12:20:20','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 2','23 D','Start-up UE bug',NULL,NULL,0,'Operator A'),
	 (5581,NULL,NULL,NULL,'AHS08','2024-03-23 12:21:00','2024-03-23 12:21:10','00:00:10',1,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 9','23 D',NULL,NULL,NULL,0,'Operator F'),
	 (5582,NULL,NULL,NULL,'AHS08','2024-03-23 12:21:50','2024-03-23 12:22:00','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 8','23 D',NULL,NULL,NULL,0,'Operator I'),
	 (5592,NULL,NULL,NULL,'DZ300','2024-03-23 15:56:30','2024-03-23 15:57:50','00:01:20',3,130,'Terrain','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 1','23 D',NULL,NULL,NULL,0,'Operator I'),
	 (5596,NULL,NULL,NULL,'EX61','2024-03-23 17:08:40','2024-03-23 17:09:30','00:00:50',1,60,'Terrain','On-Board','Systems','Application','Terrain','Crash Terrain',NULL,NULL,'Test Zone 9','23 D',NULL,NULL,NULL,0,'Operator B'),
	 (5602,NULL,NULL,NULL,'RD848','2024-03-24 09:25:40','2024-03-24 09:26:30','00:00:50',3,90,'AMT','Off-Board','RF Shadowing','-','-','Shadowing',NULL,NULL,'Test Zone 2','24 D',NULL,NULL,NULL,0,'Operator A'),
	 (5603,NULL,NULL,NULL,'DZ298','2024-03-24 11:13:50','2024-03-24 11:14:40','00:00:50',1,30,'Terrain','On-Board','Systems','Application','Terrain','Terrain',NULL,NULL,'Test Zone 2','24 D',NULL,NULL,NULL,0,'Operator K'),
	 (5608,NULL,NULL,NULL,'AHS25','2024-03-24 15:29:10','2024-03-24 15:29:20','00:00:10',3,60,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 7','24 D','start-up error',NULL,NULL,0,'Operator G'),
	 (5609,NULL,NULL,NULL,'AHS25','2024-03-24 15:30:00','2024-03-24 15:30:10','00:00:10',3,50,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 4','24 D','start-up error',NULL,NULL,0,'Operator A');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5610,NULL,NULL,NULL,'AHS25','2024-03-24 15:30:50','2024-03-24 15:31:00','00:00:10',3,60,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 9','24 D','start-up error',NULL,NULL,0,'Operator G'),
	 (5611,NULL,NULL,NULL,'AHS25','2024-03-24 15:31:40','2024-03-24 15:31:40','00:00:00',3,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 5','24 D','start-up error',NULL,NULL,0,'Operator C'),
	 (5612,NULL,NULL,NULL,'AHS25','2024-03-24 15:32:30','2024-03-24 15:32:30','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 1','24 D','start-up error',NULL,NULL,0,'Operator F'),
	 (5613,NULL,NULL,NULL,'AHS25','2024-03-24 15:33:20','2024-03-24 15:33:30','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 10','24 D','start-up error',NULL,NULL,0,'Operator A'),
	 (5614,NULL,NULL,NULL,'AHS25','2024-03-24 15:34:10','2024-03-24 15:34:20','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 8','24 D','start-up error',NULL,NULL,0,'Operator A'),
	 (5615,NULL,NULL,NULL,'AHS25','2024-03-24 15:35:00','2024-03-24 15:35:00','00:00:00',2,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 3','24 D','start-up error',NULL,NULL,0,'Operator E'),
	 (5616,NULL,NULL,NULL,'AHS25','2024-03-24 15:35:50','2024-03-24 15:35:50','00:00:00',2,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,NULL,'24 D','start-up error',NULL,NULL,0,'Operator F'),
	 (5617,NULL,NULL,NULL,'AHS25','2024-03-24 15:36:40','2024-03-24 15:36:40','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 2','24 D','start-up error',NULL,NULL,0,'Operator E'),
	 (5619,NULL,NULL,NULL,'AHS25','2024-03-24 15:38:20','2024-03-24 15:38:30','00:00:10',3,50,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 10','24 D','start-up error',NULL,NULL,0,'Operator H'),
	 (5620,NULL,NULL,NULL,'AHS25','2024-03-24 15:39:10','2024-03-24 15:39:10','00:00:00',2,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 4','24 D','start-up error',NULL,NULL,0,'Operator B');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5622,NULL,NULL,NULL,'RD788','2024-03-24 16:15:20','2024-03-24 16:17:00','00:01:40',6,600,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,NULL,'24 D',NULL,NULL,NULL,0,'Operator G'),
	 (5650,NULL,NULL,NULL,'DZ300','2024-03-24 18:11:00','2024-03-24 18:12:00','00:01:00',10,600,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 4','24 N',NULL,NULL,NULL,0,'Operator C'),
	 (5651,NULL,NULL,NULL,'AHS15','2024-03-24 18:53:00','2024-03-24 18:53:00','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 5','24 N',NULL,NULL,NULL,0,NULL),
	 (5652,NULL,NULL,NULL,'AHS15','2024-03-24 19:23:30','2024-03-24 19:23:30','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,NULL,'24 N',NULL,NULL,NULL,0,'Operator B'),
	 (5653,NULL,NULL,NULL,'AHS15','2024-03-24 19:54:10','2024-03-24 19:54:10','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,NULL,'24 N',NULL,NULL,NULL,0,'Operator K'),
	 (5654,NULL,NULL,NULL,'AHS15','2024-03-24 20:24:40','2024-03-24 20:24:40','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 8','24 N',NULL,NULL,NULL,0,'Operator B'),
	 (5656,NULL,NULL,NULL,'AHS15','2024-03-24 21:26:00','2024-03-24 21:26:00','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 9','24 N',NULL,NULL,NULL,0,'Operator F'),
	 (5657,NULL,NULL,NULL,'AHS15','2024-03-24 23:29:00','2024-03-24 23:29:10','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 3','24 N',NULL,NULL,NULL,0,NULL),
	 (5658,NULL,NULL,NULL,'AHS15','2024-03-25 04:14:30','2024-03-25 04:14:30','00:00:00',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 1','24 N',NULL,NULL,NULL,0,'Operator H'),
	 (5659,NULL,NULL,NULL,'AHS15','2024-03-25 04:15:10','2024-03-25 04:15:20','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 2','24 N',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5660,NULL,NULL,NULL,'AHS15','2024-03-25 04:16:00','2024-03-25 04:16:10','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 7','24 N',NULL,NULL,NULL,0,'Operator A'),
	 (5661,NULL,NULL,NULL,'AHS15','2024-03-25 04:16:50','2024-03-25 04:17:00','00:00:10',2,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 5','24 N',NULL,NULL,NULL,0,'Operator F'),
	 (5662,NULL,NULL,NULL,'AHS15','2024-03-25 04:17:40','2024-03-25 04:17:50','00:00:10',2,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 8','24 N',NULL,NULL,NULL,0,'Operator B'),
	 (5663,NULL,NULL,NULL,'AHS15','2024-03-25 04:18:30','2024-03-25 04:18:40','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 8','24 N',NULL,NULL,NULL,0,'Operator A'),
	 (5664,NULL,NULL,NULL,'AHS15','2024-03-25 04:19:20','2024-03-25 04:19:30','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 10','24 N',NULL,NULL,NULL,0,'Operator C'),
	 (5665,NULL,NULL,NULL,'AHS15','2024-03-25 04:20:10','2024-03-25 04:20:20','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 10','24 N',NULL,NULL,NULL,0,'Operator H'),
	 (5666,NULL,NULL,NULL,'AHS15','2024-03-25 04:21:00','2024-03-25 04:21:10','00:00:10',1,10,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,NULL,'24 N',NULL,NULL,NULL,0,'Operator C'),
	 (5667,NULL,NULL,NULL,'AHS15','2024-03-25 04:21:50','2024-03-25 04:22:00','00:00:10',1,20,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 7','24 N',NULL,NULL,NULL,0,'Operator J'),
	 (5668,NULL,NULL,NULL,'AHS15','2024-03-25 04:22:40','2024-03-25 04:22:50','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 5','24 N',NULL,NULL,NULL,0,'Operator H'),
	 (5669,NULL,NULL,NULL,'AHS15','2024-03-25 04:23:30','2024-03-25 04:23:40','00:00:10',2,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,NULL,'24 N',NULL,NULL,NULL,0,'Operator I');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5670,NULL,NULL,NULL,'AHS15','2024-03-25 04:24:20','2024-03-25 04:26:30','00:02:10',7,700,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 6','24 N',NULL,NULL,NULL,0,'Operator A'),
	 (5679,NULL,NULL,NULL,'AHS03','2024-03-26 15:14:30','2024-03-26 15:17:00','00:02:30',8,920,'Tope','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 5','26 D',NULL,NULL,NULL,0,NULL),
	 (5683,NULL,NULL,NULL,'RD793','2024-03-26 16:08:30','2024-03-26 16:09:00','00:00:30',8,260,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 6','26 D','start-up',NULL,NULL,0,'Operator B'),
	 (5709,NULL,NULL,NULL,'RD788','2024-03-26 21:47:20','2024-03-26 21:47:40','00:00:20',6,110,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 3','26 N',NULL,NULL,NULL,0,'Operator B'),
	 (5713,NULL,NULL,NULL,'DZ291','2024-03-27 06:30:20','2024-03-27 06:30:40','00:00:20',2,30,'Terrain','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 8','27 D',NULL,NULL,NULL,0,'Operator D'),
	 (5714,NULL,NULL,NULL,'RD783','2024-03-27 06:54:20','2024-03-27 06:54:50','00:00:30',9,360,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,NULL,'27 D',NULL,NULL,NULL,0,'Operator E'),
	 (5721,NULL,NULL,NULL,'DZ293','2024-03-27 13:24:50','2024-03-27 13:25:00','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,'Test Zone 5','27 D',NULL,NULL,NULL,0,'Operator G'),
	 (5724,NULL,NULL,NULL,'DZ298','2024-03-27 14:53:50','2024-03-27 14:56:10','00:02:20',2,140,'Terrain','On-Board','Systems','Application','Terrain','Terrain',NULL,NULL,NULL,'27 D',NULL,NULL,NULL,0,'Operator C'),
	 (5725,NULL,NULL,NULL,'DZ300','2024-03-27 14:56:40','2024-03-27 14:57:50','00:01:10',11,780,'Terrain','On-Board','Systems','Application','Terrain','Crash Terrain',NULL,NULL,'Test Zone 7','27 D',NULL,NULL,NULL,0,NULL),
	 (5747,NULL,NULL,NULL,'RD782','2024-03-27 19:39:40','2024-03-27 19:39:40','00:00:00',9,90,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 6','27 N',NULL,NULL,NULL,0,'Operator F');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5751,NULL,NULL,NULL,'DZ293','2024-03-27 23:38:40','2024-03-27 23:38:40','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 10','27 N',NULL,NULL,NULL,0,'Operator C'),
	 (5753,NULL,NULL,NULL,'DZ290','2024-03-28 00:35:50','2024-03-28 00:36:10','00:00:20',7,200,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 8','27 N',NULL,NULL,NULL,0,NULL),
	 (5754,NULL,NULL,NULL,'DZ290','2024-03-28 00:41:20','2024-03-28 00:41:20','00:00:00',8,80,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 2','27 N',NULL,NULL,NULL,0,'Operator K'),
	 (5755,NULL,NULL,NULL,'DZ290','2024-03-28 00:46:30','2024-03-28 00:46:30','00:00:00',10,100,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 4','27 N',NULL,NULL,NULL,0,'Operator A'),
	 (5757,NULL,NULL,NULL,'AHS08','2024-03-28 04:00:40','2024-03-28 04:01:10','00:00:30',1,30,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 9','27 N',NULL,NULL,NULL,0,'Operator E'),
	 (5758,NULL,NULL,NULL,'DZ290','2024-03-28 05:00:20','2024-03-28 05:01:10','00:00:50',10,500,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,NULL,'27 N',NULL,NULL,NULL,0,'Operator I'),
	 (5759,NULL,NULL,NULL,'DZ290','2024-03-28 05:06:20','2024-03-28 05:06:30','00:00:10',7,130,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 1','27 N',NULL,NULL,NULL,0,'Operator J'),
	 (5763,NULL,NULL,NULL,'RD842','2024-03-28 08:48:10','2024-03-28 08:48:50','00:00:40',1,30,'AMT','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 4','28 D',NULL,NULL,NULL,0,'Operator A'),
	 (5765,NULL,NULL,NULL,'RD841','2024-03-28 09:01:30','2024-03-28 09:02:00','00:00:30',2,30,'AMT','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 3','28 D',NULL,NULL,NULL,0,'Operator H'),
	 (5766,NULL,NULL,NULL,'RD842','2024-03-28 09:02:10','2024-03-28 09:02:20','00:00:10',9,180,'AMT','Process','Shutdown','Isolation',NULL,'Isolation',NULL,NULL,'Test Zone 8','28 D',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5770,NULL,NULL,NULL,'RD795','2024-03-28 12:21:40','2024-03-28 12:23:00','00:01:20',2,30,'AMT','Process','Shutdown','Isolation','-','Crash AMT',NULL,NULL,'Test Zone 4','28 D',NULL,NULL,NULL,0,'Operator B'),
	 (5773,NULL,NULL,NULL,'DZ293','2024-03-28 13:17:00','2024-03-28 13:17:10','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,'Test Zone 3','28 D',NULL,NULL,NULL,0,'Operator I'),
	 (5774,NULL,NULL,NULL,'RD795','2024-03-28 13:39:00','2024-03-28 13:40:00','00:01:00',1,50,'AMT','Process','Shutdown','Isolation','-','Isolation',NULL,NULL,'Test Zone 2','28 D',NULL,NULL,NULL,0,'Operator I'),
	 (5794,NULL,NULL,NULL,'GR496','2024-03-28 18:44:20','2024-03-28 18:45:10','00:00:50',3,180,'Tope','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 2','28 N',NULL,NULL,NULL,0,'Operator J'),
	 (5800,NULL,NULL,NULL,'GR493','2024-03-28 18:54:40','2024-03-28 18:57:30','00:02:50',3,150,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 7','28 N',NULL,NULL,NULL,0,'Operator H'),
	 (5804,NULL,NULL,NULL,'EX17','2024-03-28 19:21:40','2024-03-28 19:24:20','00:02:40',1,120,'Terrain','On-Board','Systems','G407','-','G407',NULL,NULL,'Test Zone 3','28 N',NULL,NULL,NULL,0,'Operator C'),
	 (5818,NULL,NULL,NULL,'GR494','2024-03-29 00:48:20','2024-03-29 00:48:50','00:00:30',7,200,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 6','28 N',NULL,NULL,NULL,0,'Operator E'),
	 (5819,NULL,NULL,NULL,'DZ300','2024-03-29 01:02:20','2024-03-29 01:02:30','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 1','28 N',NULL,NULL,NULL,0,'Operator D'),
	 (5820,NULL,NULL,NULL,'DZ300','2024-03-29 01:03:00','2024-03-29 01:03:10','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 5','28 N',NULL,NULL,NULL,0,'Operator J'),
	 (5821,NULL,NULL,NULL,'DZ300','2024-03-29 01:03:40','2024-03-29 01:03:40','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 9','28 N',NULL,NULL,NULL,0,'Operator H');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5822,NULL,NULL,NULL,'RD782','2024-03-29 01:11:50','2024-03-29 01:12:10','00:00:20',9,180,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 1','28 N',NULL,NULL,NULL,0,'Operator F'),
	 (5826,NULL,NULL,NULL,'DZ300','2024-03-29 02:29:20','2024-03-29 02:29:30','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 8','28 N',NULL,NULL,NULL,0,'Operator H'),
	 (5827,NULL,NULL,NULL,'DZ300','2024-03-29 02:30:00','2024-03-29 02:30:10','00:00:10',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 1','28 N',NULL,NULL,NULL,0,'Operator I'),
	 (5831,NULL,NULL,NULL,'RD839','2024-03-29 08:11:20','2024-03-29 08:11:30','00:00:10',6,90,'AMT','On-Board','Systems','Application','TOPE','Crash TOPE',NULL,NULL,'Test Zone 3','29 D',NULL,NULL,NULL,0,'Operator A'),
	 (5832,NULL,NULL,NULL,'EX59','2024-03-29 08:22:00','2024-03-29 08:22:20','00:00:20',1,30,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 3','29 D',NULL,NULL,NULL,0,'Operator I'),
	 (5833,NULL,NULL,NULL,'RD849','2024-03-29 10:52:20','2024-03-29 10:52:20','00:00:00',1,10,'AMT','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 10','29 D',NULL,NULL,NULL,0,'Operator J'),
	 (5835,NULL,NULL,NULL,'DZ293','2024-03-29 11:42:00','2024-03-29 11:42:00','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,'Test Zone 4','29 D',NULL,NULL,NULL,0,'Operator B'),
	 (5836,NULL,NULL,NULL,'AHS03','2024-03-29 12:23:30','2024-03-29 12:23:30','00:00:00',3,30,'Tope','On-Board','UE','Configuration','Firmware','UE Config Firmware',NULL,NULL,'Test Zone 3','29 D',NULL,NULL,NULL,0,'Operator B'),
	 (5837,NULL,NULL,NULL,'RD792','2024-03-29 12:35:20','2024-03-29 12:35:40','00:00:20',7,140,'AMT','On-Board','Systems','Component','-','On Board Components',NULL,NULL,'Test Zone 5','29 D',NULL,NULL,NULL,0,'Operator D'),
	 (5841,NULL,NULL,NULL,'DZ293','2024-03-29 17:08:40','2024-03-29 17:08:40','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,NULL,'29 D',NULL,NULL,NULL,0,'Operator J');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5842,NULL,NULL,NULL,'AHS23','2024-03-29 17:41:00','2024-03-29 17:41:30','00:00:30',2,40,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 4','29 D',NULL,NULL,NULL,0,'Operator E'),
	 (5863,NULL,NULL,NULL,'EX86','2024-03-29 18:18:40','2024-03-29 18:20:20','00:01:40',8,800,'Terrain','On-Board','Systems','Application','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 8','29 N',NULL,NULL,NULL,0,'Operator J'),
	 (5864,NULL,NULL,NULL,'RD838','2024-03-29 18:53:00','2024-03-29 18:53:00','00:00:00',1,10,'AMT','On-Board','Systems','Application','TOPE','Lost Position Accuracy TOPE',NULL,NULL,'Test Zone 3','29 N',NULL,NULL,NULL,0,'Operator E'),
	 (5865,NULL,NULL,NULL,'DZ300','2024-03-29 19:03:40','2024-03-29 19:03:40','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 4','29 N',NULL,NULL,NULL,0,'Operator A'),
	 (5868,NULL,NULL,NULL,'DZ293','2024-03-29 20:31:50','2024-03-29 20:31:50','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 6','29 N',NULL,NULL,NULL,0,'Operator C'),
	 (5873,NULL,NULL,NULL,'DZ300','2024-03-29 21:30:20','2024-03-29 21:31:50','00:01:30',1,90,'Terrain','On-Board','Systems','G610','-','G610',NULL,NULL,'Test Zone 4','29 N',NULL,NULL,NULL,0,'Operator C'),
	 (5878,NULL,NULL,NULL,'DZ293','2024-03-30 00:56:30','2024-03-30 00:56:30','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Lost Position Accuracy Terrain',NULL,NULL,'Test Zone 8','29 N',NULL,NULL,NULL,0,'Operator K'),
	 (5879,NULL,NULL,NULL,'DZ293','2024-03-30 01:33:20','2024-03-30 01:33:20','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 4','29 N',NULL,NULL,NULL,0,'Operator B'),
	 (5880,NULL,NULL,NULL,'AHS02','2024-03-30 03:03:00','2024-03-30 03:03:50','00:00:50',2,60,'Tope','On-Board','Systems','Application','TOPE','High PR2 startup TOPE',NULL,NULL,'Test Zone 5','29 N',NULL,NULL,NULL,0,'Operator D'),
	 (5902,NULL,NULL,NULL,'DZ300','2024-03-30 19:02:30','2024-03-30 19:03:50','00:01:20',3,50,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 8','30 N',NULL,NULL,NULL,0,'Operator D');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5920,NULL,NULL,NULL,'GR493','2024-03-31 00:05:30','2024-03-31 00:06:00','00:00:30',2,20,'Tope','On-Board','Systems','Application','AMT','Time Synch AMT',NULL,NULL,'Test Zone 6','30 N',NULL,NULL,NULL,0,'Operator K'),
	 (5931,NULL,NULL,NULL,'RD849','2024-03-31 03:39:20','2024-03-31 03:39:20','00:00:00',6,60,'AMT','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 8','30 N',NULL,NULL,NULL,0,'Operator D'),
	 (5933,NULL,NULL,NULL,'RD840','2024-03-31 03:59:40','2024-03-31 03:59:40','00:00:00',8,80,'AMT','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 7','30 N',NULL,NULL,NULL,0,'Operator A'),
	 (5936,NULL,NULL,NULL,'GR493','2024-03-31 04:36:20','2024-03-31 04:36:20','00:00:00',2,20,'Tope','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 1','30 N',NULL,NULL,NULL,0,NULL),
	 (5937,NULL,NULL,NULL,'GR493','2024-03-31 04:38:50','2024-03-31 04:40:00','00:01:10',12,780,'Tope','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 5','30 N',NULL,NULL,NULL,0,'Operator B'),
	 (5938,NULL,NULL,NULL,'GR493','2024-03-31 04:45:50','2024-03-31 04:46:10','00:00:20',14,290,'Tope','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 7','30 N',NULL,NULL,NULL,0,'Operator G'),
	 (5943,NULL,NULL,NULL,'RD839','2024-03-31 05:58:10','2024-03-31 05:58:10','00:00:00',13,130,'AMT','On-Board','Systems','Application','Tope','Tope',NULL,NULL,'Test Zone 3','30 N',NULL,NULL,NULL,0,'Operator J'),
	 (5944,NULL,NULL,NULL,'GR493','2024-03-31 06:05:30','2024-03-31 06:05:30','00:00:00',14,140,'Tope','Unknown','-','-','-','Unknown',NULL,NULL,'Test Zone 6','31 D',NULL,NULL,NULL,0,'Operator A'),
	 (5945,NULL,NULL,NULL,'AHS03','2024-03-31 06:23:30','2024-03-31 06:23:30','00:00:00',1,10,'Tope','On-Board','Systems','Cabling','-','Cabling',NULL,NULL,'Test Zone 9','31 D',NULL,NULL,NULL,0,'Operator K'),
	 (5947,NULL,NULL,NULL,'WC807','2024-03-31 06:31:20','2024-03-31 06:31:30','00:00:10',1,10,'Tope','On-Board','UE','Cabling','Cabling','UE Cabling',NULL,NULL,'Test Zone 1','31 D',NULL,NULL,NULL,0,'Operator A');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (5948,NULL,NULL,NULL,'WC807','2024-03-31 06:32:10','2024-03-31 06:32:20','00:00:10',1,10,'Tope','On-Board','WGB','Cabling','Cabling','Cabling WGB',NULL,NULL,'Test Zone 7','31 D',NULL,NULL,NULL,0,NULL),
	 (5950,NULL,NULL,NULL,'WC807','2024-03-31 06:33:00','2024-03-31 06:33:10','00:00:10',1,10,'Tope','On-Board','WGB','Cabling','Cabling','Cabling WGB',NULL,NULL,'Test Zone 6','31 D',NULL,NULL,NULL,0,'Operator C'),
	 (5951,NULL,NULL,NULL,'WC807','2024-03-31 06:33:50','2024-03-31 06:34:00','00:00:10',1,10,'Tope','On-Board','WGB','Cabling','Cabling','Cabling WGB',NULL,NULL,'Test Zone 6','31 D',NULL,NULL,NULL,0,'Operator D'),
	 (5952,NULL,NULL,NULL,'DZ298','2024-03-31 07:03:00','2024-03-31 07:03:40','00:00:40',1,20,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 3','31 D',NULL,NULL,NULL,0,'Operator H'),
	 (5981,NULL,NULL,NULL,'AHS02','2024-03-31 12:43:30','2024-03-31 12:43:50','00:00:20',2,30,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 1','31 D',NULL,NULL,NULL,0,NULL),
	 (5982,NULL,NULL,NULL,'AHS02','2024-03-31 12:44:20','2024-03-31 12:44:30','00:00:10',1,10,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 5','31 D',NULL,NULL,NULL,0,'Operator F'),
	 (5984,NULL,NULL,NULL,'AHS02','2024-03-31 12:46:00','2024-03-31 12:46:20','00:00:20',4,50,'Tope','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 10','31 D',NULL,NULL,NULL,0,'Operator H'),
	 (5989,NULL,NULL,NULL,'DZ298','2024-03-31 13:32:30','2024-03-31 13:33:10','00:00:40',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 9','31 D',NULL,NULL,NULL,0,NULL),
	 (5991,NULL,NULL,NULL,'DZ293','2024-03-31 13:33:50','2024-03-31 13:34:20','00:00:30',1,30,'Terrain','On-Board','Systems','Application','Terrain','Crash Terrain',NULL,NULL,'Test Zone 8','31 D',NULL,NULL,NULL,0,'Operator E'),
	 (5998,NULL,NULL,NULL,'RD787','2024-03-31 14:35:40','2024-03-31 14:36:00','00:00:20',2,20,'AMT','On-Board','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 8','31 D',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6003,NULL,NULL,NULL,'DZ298','2024-03-31 15:03:00','2024-03-31 15:03:40','00:00:40',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,NULL,'31 D',NULL,NULL,NULL,0,NULL),
	 (6005,NULL,NULL,NULL,'DZ298','2024-03-31 15:32:40','2024-03-31 15:33:30','00:00:50',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 7','31 D',NULL,NULL,NULL,0,NULL),
	 (6008,NULL,NULL,NULL,'DZ293','2024-03-31 16:30:30','2024-03-31 16:30:30','00:00:00',1,10,'Terrain','On-Board','Systems','GPS','-','GPS',NULL,NULL,'Test Zone 2','31 D',NULL,NULL,NULL,0,'Operator I'),
	 (6009,NULL,NULL,NULL,'GR493','2024-03-31 16:41:50','2024-03-31 16:42:20','00:00:30',8,180,'Tope','On-Board','Systems','G407','-','G407',NULL,NULL,NULL,'31 D',NULL,NULL,NULL,0,'Operator J'),
	 (6010,NULL,NULL,NULL,'RD794','2024-03-31 16:54:00','2024-03-31 16:55:00','00:01:00',14,980,'AMT','Off-Board','RF Shadowing','-','-','Shadowing',NULL,NULL,'Test Zone 5','31 D',NULL,NULL,NULL,0,'Operator A'),
	 (6080,NULL,NULL,NULL,'DZ293','2024-03-31 18:42:20','2024-03-31 18:42:20','00:00:00',1,10,'Terrain','On-Board','Systems','Application','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 6','31 N',NULL,NULL,NULL,0,'Operator A'),
	 (6081,NULL,NULL,NULL,'DZ297','2024-03-31 19:25:50','2024-03-31 19:26:30','00:00:40',1,40,'Terrain','On-Board','Systems','Application','Terrain','Crash Terrain',NULL,NULL,'Test Zone 3','31 N',NULL,NULL,NULL,0,'Operator D'),
	 (6089,NULL,NULL,NULL,'DZ290','2024-03-31 23:35:40','2024-03-31 23:36:00','00:00:20',1,30,'Terrain','On-Board','UE','Roaming','-','UE Roaming',NULL,NULL,'Test Zone 9','31 N',NULL,NULL,NULL,0,'Operator A');


--Insert some test data (using Spanish Categories)
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6446,NULL,NULL,NULL,'DZ298','2024-04-01 03:29:40','2024-04-01 03:30:30','00:00:50',2,60,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 4','29 N',NULL,NULL,NULL,0,'Operator E'),
	 (6447,NULL,NULL,NULL,'DZ298','2024-04-01 03:59:40','2024-04-01 04:00:20','00:00:40',2,30,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 8','29 N',NULL,NULL,NULL,0,'Operator F'),
	 (6453,NULL,NULL,NULL,'DZ300','2024-04-01 06:19:30','2024-04-01 06:20:20','00:00:50',2,90,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 6','01 D','Last operator - David Iopu, oncoming - Lawrence Condren',NULL,NULL,0,'Operator C'),
	 (6458,NULL,NULL,NULL,'RD783','2024-04-01 13:29:30','2024-04-01 13:30:00','00:00:30',3,110,'AMT','Abordo','Sistemas','Componentes','-','Componentes a bordo',NULL,NULL,'Test Zone 2','01 D',NULL,NULL,NULL,0,'Operator H'),
	 (6461,NULL,NULL,NULL,'EX17','2024-04-01 17:25:00','2024-04-01 17:26:10','00:01:10',1,30,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 10','01 D',NULL,NULL,NULL,0,'Operator A'),
	 (6478,NULL,NULL,NULL,'DZ298','2024-04-02 03:14:10','2024-04-02 03:16:40','00:02:30',4,360,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 3','01 N',NULL,NULL,NULL,0,'Operator K'),
	 (6487,NULL,NULL,NULL,'DZ291','2024-04-02 06:51:30','2024-04-02 06:51:30','00:00:00',1,10,'Terrain','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 3','02 D',NULL,NULL,NULL,0,'Operator K'),
	 (6488,NULL,NULL,NULL,'DZ291','2024-04-02 06:51:50','2024-04-02 06:51:50','00:00:00',1,10,'Terrain','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 6','02 D',NULL,NULL,NULL,0,'Operator H'),
	 (6490,NULL,NULL,NULL,'DZ290','2024-04-02 07:42:20','2024-04-02 07:42:40','00:00:20',7,200,'Terrain','Abordo','Sistemas','Aplicación','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 7','02 D',NULL,NULL,NULL,0,'Operator A'),
	 (6492,NULL,NULL,NULL,'RD843','2024-04-02 10:08:20','2024-04-02 10:08:20','00:00:00',1,10,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 3','02 D',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6499,NULL,NULL,NULL,'AHS27','2024-04-02 21:11:00','2024-04-02 21:12:20','00:01:20',4,220,'Tope','Abordo','Sistemas','Aplicación','TOPE','Crash TOPE',NULL,NULL,'Test Zone 3','02 N',NULL,NULL,NULL,0,NULL),
	 (6501,NULL,NULL,NULL,'DZ298','2024-04-02 22:45:30','2024-04-02 22:48:50','00:03:20',2,50,'Terrain','Abordo','Sistemas','G610','-','G610',NULL,NULL,'Test Zone 1','02 N',NULL,NULL,NULL,0,'Operator B'),
	 (6502,NULL,NULL,NULL,'RD843','2024-04-02 23:07:10','2024-04-02 23:07:10','00:00:00',1,10,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 9','02 N',NULL,NULL,NULL,0,'Operator E'),
	 (6503,NULL,NULL,NULL,'RD849','2024-04-03 00:45:00','2024-04-03 00:45:00','00:00:00',1,10,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 8','02 N',NULL,NULL,NULL,0,'Operator B'),
	 (6504,NULL,NULL,NULL,'RD850','2024-04-03 00:46:20','2024-04-03 00:46:20','00:00:00',1,10,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 4','02 N',NULL,NULL,NULL,0,'Operator G'),
	 (6505,NULL,NULL,NULL,'RD842','2024-04-03 00:57:40','2024-04-03 00:57:40','00:00:00',2,20,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 9','02 N',NULL,NULL,NULL,0,'Operator G'),
	 (6515,NULL,NULL,NULL,'RD841','2024-04-03 11:24:50','2024-04-03 11:26:10','00:01:20',5,160,'AMT','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 9','03 D',NULL,NULL,NULL,0,'Operator D'),
	 (6519,NULL,NULL,NULL,'RD850','2024-04-03 11:48:30','2024-04-03 11:48:30','00:00:00',2,20,'AMT','Externo','Cobertura RF','-','-','Cobertura',NULL,NULL,'Test Zone 8','03 D',NULL,NULL,NULL,0,'Operator J'),
	 (6524,NULL,NULL,NULL,'RD848','2024-04-03 16:16:20','2024-04-03 16:16:20','00:00:00',1,10,'AMT','Externo','Red','Afectación','-','Afectación',NULL,NULL,NULL,'03 D',NULL,NULL,NULL,0,'Operator E'),
	 (6549,NULL,NULL,NULL,'RD785','2024-04-04 01:52:30','2024-04-04 01:53:00','00:00:30',1,30,'AMT','Externo','sombreado de rf','-','-','Sombreado',NULL,NULL,'Test Zone 8','03 N',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6550,NULL,NULL,NULL,'RD786','2024-04-04 03:21:00','2024-04-04 03:21:30','00:00:30',12,360,'AMT','Abordo','Sistemas','Aplicación','AMT','No pos data in PR2 AMT',NULL,NULL,NULL,'03 N',NULL,NULL,NULL,0,NULL),
	 (6553,NULL,NULL,NULL,'RD791','2024-04-04 04:22:30','2024-04-04 04:23:40','00:01:10',1,10,'AMT','Abordo','Sistemas','Componentes','-','Componentes a bordo',NULL,NULL,'Test Zone 5','03 N',NULL,NULL,NULL,0,NULL),
	 (6555,NULL,NULL,NULL,'RD849','2024-04-04 05:51:40','2024-04-04 05:51:40','00:00:00',2,20,'AMT','Abordo','Sistemas','GPS','-','GPS',NULL,NULL,'Test Zone 4','03 N',NULL,NULL,NULL,0,'Operator J'),
	 (6556,NULL,NULL,NULL,'DZ298','2024-04-04 06:38:50','2024-04-04 06:39:10','00:00:20',5,150,'Terrain','Abordo','Sistemas','Aplicación','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 8','04 D',NULL,NULL,NULL,0,'Operator B'),
	 (6562,NULL,NULL,NULL,'AHS05','2024-04-04 10:43:30','2024-04-04 10:43:40','00:00:10',1,10,'Tope','Externo','Red','Afectación','-','Afectación',NULL,NULL,'Test Zone 2','04 D',NULL,NULL,NULL,0,'Operator G'),
	 (6566,NULL,NULL,NULL,'AHS10','2024-04-04 10:43:30','2024-04-04 10:43:50','00:00:20',2,30,'Tope','Externo','Red','Afectación','-','Afectación',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator G'),
	 (6575,NULL,NULL,NULL,'AHS22','2024-04-04 10:43:40','2024-04-04 10:43:40','00:00:00',1,10,'Tope','Externo','Red','Afectación','-','Afectación',NULL,NULL,'Test Zone 2','04 D',NULL,NULL,NULL,0,'Operator J'),
	 (6588,NULL,NULL,NULL,'RD839','2024-04-04 11:22:50','2024-04-04 11:22:50','00:00:00',2,20,'AMT','Abordo','Sistemas','Aplicación','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator A'),
	 (6589,NULL,NULL,NULL,'DZ292','2024-04-04 11:25:40','2024-04-04 11:26:10','00:00:30',13,370,'Terrain','Abordo','Sistemas','Aplicación','Terrain','No pos data in PR2 Terrain',NULL,NULL,'Test Zone 4','04 D',NULL,NULL,NULL,0,'Operator E'),
	 (6591,NULL,NULL,NULL,'WC808','2024-04-04 12:14:40','2024-04-04 12:14:50','00:00:10',1,10,'Tope','Externo','Red','Afectación','-','Afectación',NULL,NULL,'Test Zone 9','04 D',NULL,NULL,NULL,0,NULL);
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6595,NULL,NULL,NULL,'RD840','2024-04-04 14:27:30','2024-04-04 14:27:30','00:00:00',2,20,'AMT','Abordo','Sistemas','Aplicación','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 3','04 D',NULL,NULL,NULL,0,'Operator K'),
	 (6601,NULL,NULL,NULL,'AHS27','2024-04-05 01:38:40','2024-04-05 01:38:50','00:00:10',1,10,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,NULL),
	 (6602,NULL,NULL,NULL,'AHS27','2024-04-05 01:39:30','2024-04-05 01:39:40','00:00:10',1,10,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6603,NULL,NULL,NULL,'AHS27','2024-04-05 01:40:20','2024-04-05 01:40:30','00:00:10',2,30,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator K'),
	 (6604,NULL,NULL,NULL,'AHS27','2024-04-05 01:41:10','2024-04-05 01:41:20','00:00:10',2,30,'Tope','Abordo','WGB','Cableado','Cableado','Cableado WGB',NULL,NULL,'Test Zone 2','04 N',NULL,NULL,NULL,0,'Operator F'),
	 (6605,NULL,NULL,NULL,'AHS27','2024-04-05 01:42:00','2024-04-05 01:42:10','00:00:10',2,30,'Tope','Abordo','WGB','Cableado','Cableado','Cableado WGB',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6606,NULL,NULL,NULL,'AHS27','2024-04-05 01:43:40','2024-04-05 01:43:50','00:00:10',2,20,'Tope','Abordo','WGB','Cableado','Cableado','Cableado WGB',NULL,NULL,'Test Zone 4','04 N',NULL,NULL,NULL,0,'Operator A'),
	 (6607,NULL,NULL,NULL,'AHS27','2024-04-05 01:44:30','2024-04-05 01:44:40','00:00:10',2,20,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6608,NULL,NULL,NULL,'AHS27','2024-04-05 01:46:10','2024-04-05 01:46:20','00:00:10',3,50,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,NULL,'04 N',NULL,NULL,NULL,0,'Operator F'),
	 (6609,NULL,NULL,NULL,'AHS27','2024-04-05 01:47:00','2024-04-05 01:47:10','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6610,NULL,NULL,NULL,'AHS27','2024-04-05 01:47:50','2024-04-05 01:48:00','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator H'),
	 (6614,NULL,NULL,NULL,'AHS27','2024-04-05 02:56:10','2024-04-05 02:56:20','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator B'),
	 (6615,NULL,NULL,NULL,'AHS27','2024-04-05 03:00:20','2024-04-05 03:00:30','00:00:10',2,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6616,NULL,NULL,NULL,'AHS27','2024-04-05 03:01:10','2024-04-05 03:01:20','00:00:10',2,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator I'),
	 (6617,NULL,NULL,NULL,'AHS27','2024-04-05 03:02:00','2024-04-05 03:02:10','00:00:10',2,30,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6618,NULL,NULL,NULL,'AHS27','2024-04-05 03:02:50','2024-04-05 03:03:00','00:00:10',2,20,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6621,NULL,NULL,NULL,'RD838','2024-04-05 03:44:50','2024-04-05 03:44:50','00:00:00',10,100,'AMT','Abordo','Sistemas','G407','-','G407',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator D'),
	 (6626,NULL,NULL,NULL,'RD837','2024-04-05 12:20:10','2024-04-05 12:20:10','00:00:00',1,10,'AMT','Externo','Red OT','Roaming','-','Roaming / Hand over',NULL,NULL,'Test Zone 2','05 D',NULL,NULL,NULL,0,NULL),
	 (6630,NULL,NULL,NULL,'DZ300','2024-04-05 18:04:10','2024-04-05 18:05:30','00:01:20',1,20,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 10','05 N',NULL,NULL,NULL,0,'Operator C'),
	 (6640,NULL,NULL,NULL,'EX62','2024-04-05 22:47:00','2024-04-05 22:47:10','00:00:10',1,10,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 2','05 N',NULL,NULL,NULL,0,'Operator B');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6656,NULL,NULL,NULL,'AHS02','2024-04-06 05:28:50','2024-04-06 05:29:30','00:00:40',3,60,'Tope','Abordo','UE','Hardware','-','UE Hardware',NULL,NULL,'Test Zone 7','05 N',NULL,NULL,NULL,0,'Operator D'),
	 (6662,NULL,NULL,NULL,'RD837','2024-04-06 08:07:30','2024-04-06 08:08:00','00:00:30',1,10,'AMT','Abordo','UE','Cableado','Sistema de antenas','UE Antenna',NULL,NULL,'Test Zone 3','06 D',NULL,NULL,NULL,0,'Operator D'),
	 (6663,NULL,NULL,NULL,'AHS27','2024-04-06 11:32:40','2024-04-06 11:32:40','00:00:00',2,20,'Tope','Abordo','Sistemas','Aplicación','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 8','06 D',NULL,NULL,NULL,0,'Operator I'),
	 (6674,NULL,NULL,NULL,'RD838','2024-04-06 18:19:10','2024-04-06 18:19:10','00:00:00',2,20,'AMT','Abordo','Sistemas','Aplicación','Tope','Tope',NULL,NULL,'Test Zone 3','06 N',NULL,NULL,NULL,0,'Operator H'),
	 (6677,NULL,NULL,NULL,'DZ300','2024-04-06 18:30:40','2024-04-06 18:33:10','00:02:30',2,230,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 5','06 N',NULL,NULL,NULL,0,'Operator C'),
	 (6680,NULL,NULL,NULL,'DZ300','2024-04-06 19:01:00','2024-04-06 19:02:20','00:01:20',2,140,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Crash Terrain',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,'Operator D'),
	 (6681,NULL,NULL,NULL,'DZ300','2024-04-06 19:29:50','2024-04-06 19:30:50','00:01:00',1,10,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 5','06 N',NULL,NULL,NULL,0,'Operator E'),
	 (6694,NULL,NULL,NULL,'RD786','2024-04-06 23:22:40','2024-04-06 23:24:00','00:01:20',12,1050,'AMT','Abordo','Sistemas','Aplicación','AMT','No pos data in PR2 AMT',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,NULL),
	 (6701,NULL,NULL,NULL,'RD838','2024-04-07 03:16:10','2024-04-07 03:16:10','00:00:00',1,10,'AMT','Abordo','Sistemas','Aplicación','TOPE','Time Synch Tope',NULL,NULL,'Test Zone 6','06 N',NULL,NULL,NULL,0,'Operator G'),
	 (6702,NULL,NULL,NULL,'DZ300','2024-04-07 03:28:10','2024-04-07 03:28:30','00:00:20',1,10,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 10','06 N',NULL,NULL,NULL,0,'Operator E');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6703,NULL,NULL,NULL,'DZ300','2024-04-07 03:29:50','2024-04-07 03:30:50','00:01:00',2,40,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,NULL,'06 N',NULL,NULL,NULL,0,'Operator J'),
	 (6709,NULL,NULL,NULL,'RD788','2024-04-07 07:21:50','2024-04-07 07:24:20','00:02:30',10,1500,'AMT','Abordo','Sistemas','Aplicación','AMT','No pos data in PR2 AMT',NULL,NULL,'Test Zone 3','07 D',NULL,NULL,NULL,0,'Operator B'),
	 (6711,NULL,NULL,NULL,'DZ300','2024-04-07 08:56:50','2024-04-07 09:01:30','00:04:40',3,510,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 2','07 D','Jarrod Ollington',NULL,NULL,0,NULL),
	 (6712,NULL,NULL,NULL,'DZ297','2024-04-07 09:41:40','2024-04-07 09:42:50','00:01:10',1,20,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 10','07 D','Shaun Lake',NULL,NULL,0,'Operator D'),
	 (6717,NULL,NULL,NULL,'RD783','2024-04-07 14:02:10','2024-04-07 14:03:00','00:00:50',8,480,'AMT','Abordo','Sistemas','Aplicación','AMT','CAT Router',NULL,NULL,'Test Zone 6','07 D',NULL,NULL,NULL,0,'Operator J'),
	 (6719,NULL,NULL,NULL,'RD783','2024-04-07 14:08:40','2024-04-07 14:09:10','00:00:30',10,310,'AMT','Abordo','Sistemas','Aplicación','AMT','CAT Router',NULL,NULL,'Test Zone 9','07 D',NULL,NULL,NULL,0,'Operator C'),
	 (6720,NULL,NULL,NULL,'RD785','2024-04-07 16:21:10','2024-04-07 16:23:00','00:01:50',11,1250,'AMT','Abordo','Sistemas','Aplicación','AMT','CAT Router',NULL,NULL,'Test Zone 9','07 D',NULL,NULL,NULL,0,'Operator A'),
	 (6721,NULL,NULL,NULL,'RD785','2024-04-07 16:23:40','2024-04-07 16:25:10','00:01:30',11,1090,'AMT','Abordo','Sistemas','Aplicación','AMT','CAT Router',NULL,NULL,'Test Zone 6','07 D',NULL,NULL,NULL,0,'Operator F');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6601,NULL,NULL,NULL,'AHS27','2024-04-08 01:38:40','2024-04-08 01:38:50','00:00:10',1,10,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,NULL),
	 (6602,NULL,NULL,NULL,'AHS27','2024-04-08 01:39:30','2024-04-08 01:39:40','00:00:10',1,10,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6603,NULL,NULL,NULL,'AHS27','2024-04-08 01:40:20','2024-04-08 01:40:30','00:00:10',2,30,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator K'),
	 (6604,NULL,NULL,NULL,'AHS27','2024-04-08 01:41:10','2024-04-08 01:41:20','00:00:10',2,30,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 2','04 N',NULL,NULL,NULL,0,'Operator F'),
	 (6605,NULL,NULL,NULL,'AHS27','2024-04-08 01:42:00','2024-04-08 01:42:10','00:00:10',2,30,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6606,NULL,NULL,NULL,'AHS27','2024-04-08 01:43:40','2024-04-08 01:43:50','00:00:10',2,20,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 4','04 N',NULL,NULL,NULL,0,'Operator A'),
	 (6607,NULL,NULL,NULL,'AHS27','2024-04-08 01:44:30','2024-04-08 01:44:40','00:00:10',2,20,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6608,NULL,NULL,NULL,'AHS27','2024-04-08 01:46:10','2024-04-08 01:46:20','00:00:10',3,50,'Tope','Externo','RF Cobertura','-','-','Cobertura',NULL,NULL,NULL,'04 N',NULL,NULL,NULL,0,'Operator F'),
	 (6609,NULL,NULL,NULL,'AHS27','2024-04-08 01:47:00','2024-04-08 01:47:10','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator K');
INSERT INTO public.test (rca_id,priority,initial_time,last_updated,machine,"time",end_time,"Duration","Impacted","Total_Impact","Type","Cat_1","Cat_2","Cat_3","Cat_4","Fault","AP_1","AP_2","Area","Shift","Comments",total_impacted,updated_time,update_count,"Operator") VALUES
	 (6610,NULL,NULL,NULL,'AHS27','2024-04-08 01:47:50','2024-04-08 01:48:00','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator H'),
	 (6614,NULL,NULL,NULL,'AHS27','2024-04-08 02:56:10','2024-04-08 02:56:20','00:00:10',3,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 6','04 N',NULL,NULL,NULL,0,'Operator B'),
	 (6615,NULL,NULL,NULL,'AHS27','2024-04-08 03:00:20','2024-04-08 03:00:30','00:00:10',2,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 10','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6616,NULL,NULL,NULL,'AHS27','2024-04-08 03:01:10','2024-04-08 03:01:20','00:00:10',2,40,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator I'),
	 (6617,NULL,NULL,NULL,'AHS27','2024-04-08 03:02:00','2024-04-08 03:02:10','00:00:10',2,30,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 7','04 N',NULL,NULL,NULL,0,'Operator C'),
	 (6618,NULL,NULL,NULL,'AHS27','2024-04-08 03:02:50','2024-04-08 03:03:00','00:00:10',2,20,'Tope','Abordo','UE','Cableado','Cableado','UE Cableado',NULL,NULL,'Test Zone 3','04 N',NULL,NULL,NULL,0,'Operator J'),
	 (6621,NULL,NULL,NULL,'RD838','2024-04-08 03:44:50','2024-04-08 03:44:50','00:00:00',10,100,'AMT','Abordo','Sistemas','G407','-','G407',NULL,NULL,'Test Zone 9','04 N',NULL,NULL,NULL,0,'Operator D'),
	 (6626,NULL,NULL,NULL,'RD837','2024-04-08 12:20:10','2024-04-08 12:20:10','00:00:00',1,10,'AMT','Externo','Red OT','Roaming','-','Roaming / Hand over',NULL,NULL,'Test Zone 2','05 D',NULL,NULL,NULL,0,NULL),
	 (6630,NULL,NULL,NULL,'DZ300','2024-04-08 18:04:10','2024-04-08 18:05:30','00:01:20',1,20,'Terrain','Proceso','Apagado','Aislado','-','Aislado',NULL,NULL,'Test Zone 10','05 N',NULL,NULL,NULL,0,'Operator C'),
	 (6640,NULL,NULL,NULL,'EX62','2024-04-08 22:47:00','2024-04-08 22:47:10','00:00:10',1,10,'Terrain','Abordo','Sistemas','Aplicación','Terrain','Time Synch Terrain',NULL,NULL,'Test Zone 2','05 N',NULL,NULL,NULL,0,'Operator B');

