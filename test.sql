-- this queires a handshake table that is populated with data from multiple sources in the stored 
-- procedure [spICFillMyRecentMatters] 
select m.employee_code, p.employee_name, count(*) as [number of recent matters] from ICMyRecentMatters m
left join adrtsql01.cmsopen.dbo.hbm_persnl p on m.employee_code = p.employee_code 
where m.employee_code in ('X4FA','4FAC',
						'XIAN','IANC', -- result = 7
						'XMKA','MKAP', -- result = 6
						'XMHO','MHOU',
						'XEIH','EIHO', -- result = 3
						'XVFO','VFOR', -- result = 3
						'XMMA','MMAC')
group by m.employee_code, p.employee_name

-- these 8 user accounts are all in the SPUsers table 
select * from spUsers where loginName like '%xian%' or loginname like '%ianc%'
or loginName like '%XMKA%' or loginname like '%MKAP%'
or loginName like '%XEIH%' or loginname like '%EIHO%'
or loginName like '%XVFO%' or loginname like '%VFOR%'

-- 7 of the 8 are active in JS3_SPuserProfiles which joins data from SPUser to HBM_PERSNL 
select p.accountName, p.username, p.LastName, p.firstname, p.status, p.PortalDirectory, p.PortalUser from JS3_SPUserProfile p
where username in ('X4FA','4FAC','XIAN','IANC', 'XMKA','MKAP', 'XMHO','MHOU','XEIH','EIHO', 'XVFO','VFOR', 'XMMA','MMAC') and p.status = 'Active'
and  lastname in ('Iancu','Kaplan', 'Holland', 'Forte') and p.PortalDirectory=1

