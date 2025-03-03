/* code to find expsnsions with missing child views */
select e.ChildViewUno, e.Name, e.Title, v.Title, cv.RowUno [childViewUno], cv.Title [childViewTitle]
from HSExpansionFields e 
left join HSViews v on v.RowUno = e.ViewUno 
left join HSViews cv on cv.RowUno = e.ChildViewUno 
where cv.RowUno is null --and e.ChildViewUno > 0
