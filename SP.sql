CREATE TABLE result_temp( 
A0 varchar2(100), 
B0 varchar2(100), 
C0 varchar2(100), 
D0 varchar2(100), 
E0 varchar2(100), 
F0 varchar2(100), 
G0 varchar2(100), 
H0 varchar2(100), 
I0 varchar2(100), 
J0 varchar2(100), 
K0 varchar2(100), 
L0 varchar2(100), 
M0 varchar2(100), 
N0 varchar2(100), 
O0 varchar2(100), 
P0 varchar2(100), 
Q0 varchar2(100), 
R0 varchar2(100), 
S0 varchar2(100) 
) 
CREATE OR REPLACE Procedure sp_insert 
   as 
       cursor c1 is 
select 
a.country as A0 , 
a.Total_Cases as B0 , 
' '  as C0, 
' '  as D0, 
c.txt as E0, 
e.txt as F0, 
g.txt as G0, 
h.txt as H0, 
' '  as I0, 
j.txt as J0, 
' '  as K0, 
' '  as L0, 
m.txt as M0, 
n.txt as N0, 
o.txt as O0, 
' ' as P0, 
' ' as Q0, 
b.country as R0 , 
b.Total_Cases as S0 
from 
( 
select rownum sn, Country, Total_Cases 
from 
( 
select Country,Total_Cases 
from covid 
order by 
Total_Cases desc 
) 
where ROWNUM <= 20 
) a 
left join ( 
select rownum sn, Country, Total_Cases 
from 
( 
select Country,Total_Cases 
from covid 
order by 
Total_Cases asc 
) 
where ROWNUM <= 20 
) b 
on a.sn = b.sn 
left join 
( 
select 2 sn,'Total Cases:' txt 
from dual 
union 
select 3, '' || sum(total_cases) 
from covid 
union 
select 9, 'Active:' txt 
from dual 
union 
select 10, 'cases' txt 
from dual 
) c 
on a.sn = c.sn 
left join 
( 
select 14 sn, 
'' || to_char(sum(Total_Cases)- sum(recovered) - sum(deaths) - 22580 - sum(serious),'999,999,999') 
|| ' (' || round((((sum(Total_Cases)- sum(recovered) - sum(deaths) - 22580) - sum(serious))/(sum(Total_Cases)- sum(recovered) - sum(deaths) - 22580))*100,1) 
|| ' %)' txt 
from covid 
union 
select 15, 'in Mild Condition' txt 
from dual 
union 
select 19, 
'Position:' || a.position || ' Total:' || a.total_cases || ' Today:' || a.new_cases || ' Deaths:' || a.deaths || ' Today:' || nvl(a.new_deaths,0) 
from 
( 
select 
country, 
total_cases, 
new_cases, 
deaths, 
new_deaths, 
row_number () over (order by total_Cases desc) as position 
from covid 
)a 
where 
UPPER(Country) = 'NEPAL' 
) e 
on a.sn = e.sn 
left join 
( 
select 10 sn, '' || to_char(sum(Total_Cases),'999,999,999') txt 
from covid 
union 
select 11, 'Currently infected patients' txt 
from dual 
) g 
on a.sn = g.sn 
left join 
( 
select 14 sn, '' || to_char(SUM(SERIOUS),'999,999,999') txt 
from covid 
union 
select 15, 'serious or critical' 
from dual 
) h 
on a.sn = h.sn 
left join 
( 
select 2 sn, 'Deaths:' txt 
from dual 
union 
select 3, '' || to_char(sum(deaths),'999,999,999') 
from covid 
) j 
on a.sn = j.sn 
left join 
( 
select 14 sn, 
'' || to_char(sum(recovered),'999,999,999')||'('||round(sum(recovered)/(sum(deaths)+sum(recovered))*100)||'%)' txt 
from covid 
union 
select 15, 'Recovered/Discharged:' 
from dual 
) m 
on a.sn = m.sn 
left join 
( 
select 2 sn, 'Recovered:' txt 
from dual 
union 
select 3, '' || to_char(sum(Recovered),'999,999,999') 
from covid 
union 
select 8,'Closed Cases:' 
from dual 
union 
select 10 sn, '' || to_char(SUM(Deaths) + sum(Recovered) + sum(New_Deaths),'999,999,999') 
from covid 
union 
select 11,'cases which had an outcome:' 
from dual 
) n 
on a.sn = n.sn 
left join 
( 
select 14 sn, 'Deaths:' txt 
from dual 
union 
select 15 sn, ''|| 
sum(deaths) ||'(' || round(sum(deaths)/(sum(deaths)+sum(recovered))*100) || '%)' 
from covid 
) o 
on a.sn = o.sn 
ORDER BY 
a.SN
