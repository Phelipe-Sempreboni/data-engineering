-------------------------------------------------------------------------------------------------------------------------------------- #

-- criação do database.

create database customersuccess;
go

-------------------------------------------------------------------------------------------------------------------------------------- #

-- caso queira excluir o database criado.

use master;
go

drop database customersuccess;
go

-------------------------------------------------------------------------------------------------------------------------------------- #

-- criação do schema.

use customersuccess;
go

create schema marketing;
go

-- caso queira excluir o schema criado.

use customersuccess;
go

drop schema marketing;
go

-------------------------------------------------------------------------------------------------------------------------------------- #

-- criação da tabela.

use customersuccess;
go

create table [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign] (
	 id int -- tipo do dado da coluna validado.
	,year_birth float -- tipo do dado da coluna validado.
	,education varchar (20) -- tipo do dado da coluna validado.
	,marital_status varchar (20) -- tipo do dado da coluna validado.
	,income float -- tipo do dado da coluna validado.
	,kidhome float -- tipo do dado da coluna validado.
	,teenhome float -- tipo do dado da coluna validado.
	,dt_customer date -- tipo do dado da coluna validado.
	,recency float -- tipo do dado da coluna validado.
	,mnt_wines float -- tipo do dado da coluna validado.
	,mnt_fruits float -- tipo do dado da coluna validado.
	,mnt_meat_products float -- tipo do dado da coluna validado.
	,mnt_fish_products float -- tipo do dado da coluna validado.
	,mnt_sweet_products float -- tipo do dado da coluna validado.
	,mnt_gold_prods float -- tipo do dado da coluna validado.
	,num_deals_purchases float -- tipo do dado da coluna validado.
	,num_web_purchases float -- tipo do dado da coluna validado.
	,num_catalog_purchases float -- tipo do dado da coluna validado.
	,num_store_purchases float -- tipo do dado da coluna validado.
	,num_web_visits_month float -- tipo do dado da coluna validado.
	,accepted_cmp3 float -- tipo do dado da coluna validado.
	,accepted_cmp4 float -- tipo do dado da coluna validado.
	,accepted_cmp5 float -- tipo do dado da coluna validado.
	,accepted_cmp1 float -- tipo do dado da coluna validado.
	,accepted_cmp2 float -- tipo do dado da coluna validado.
	,complain float -- tipo do dado da coluna validado.
	,z_cost_contact float -- tipo do dado da coluna validado.
	,z_revenue float -- tipo do dado da coluna validado.
	,response float -- tipo do dado da coluna validado.
	,constraint pk_id primary key clustered (id) -- chave primária criada para não duplicar dados e facilitar em buscas com índice clusterizado.
);
go

use [customersuccess];
go

-- verificar informações da tabela, onde, a principal verificada neste caso, seria a (column_name) e (data_type) para validar os tipos dos dados na criação da tabela.
select * from information_schema.columns where table_name = 'tb_customersuccess_sot_marketing_campaign';
go

-- verificar se informações da tabela, onde, a principal verificada neste caso, seria se a tabela possuí uma chave primária, visando não duplicar registros.
select * from information_schema.table_constraints where table_name = 'tb_customersuccess_sot_marketing_campaign';
go

-- caso queria excluir a tabela criada.

drop table [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign];
go

-- caso queira deletar dados da tabela criada.
delete from [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign] where id = 1;
go

--caso queira truncar dados da tabela criada.
truncate table [customersuccess].[marketing].[tb_customersuccess_sot_marketing_campaign];
go

-------------------------------------------------------------------------------------------------------------------------------------- #