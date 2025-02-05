--HomeTask11

create table StrTest([Payment Details] varchar(max))
insert into StrTest values ('Full Name = Abdullayev Shoxruh Account = 20201123456789790001 CorrAccount = 105USD777132005'),
              ('Full Name = Alimboev Hamid Account = 20001123459872543510 CorrAccount = 110USD000177007')
select *,
	SUBSTRING([Payment Details], 
              CHARINDEX('Full Name = ', [Payment Details]) + 11, 
              CHARINDEX(' Account =', [Payment Details]) - CHARINDEX('Full Name = ', [Payment Details]) - 11) 
              AS FullName,
	SUBSTRING([Payment Details], 
              CHARINDEX('Account = ', [Payment Details]) + 10, 
              CHARINDEX(' CorrAccount =', [Payment Details]) - CHARINDEX('Account = ', [Payment Details]) - 10) 
              AS Account,
	SUBSTRING([Payment Details], 
              CHARINDEX('CorrAccount = ', [Payment Details]) + 14, 15)
              AS CorrAccount
from StrTest