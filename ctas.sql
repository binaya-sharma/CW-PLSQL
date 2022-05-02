create table final_table  
as select 
  a.country as "Top20" , 
  a.Total_Cases as "tC" , 
  cast(null as number) as "1", 
  cast(null as number) as "2", 
  c.txt as "t1", 
  e.txt as "t2", 
  g.txt as "t4", 
  h.txt as "t5", 
  cast(null as number) as "10", 
  j.txt as "t6", 
  cast(null as number) as "12", 
  cast(null as number) as "13", 
  m.txt as "t7", 
  n.txt as "t8", 
  o.txt as "t9", 
  cast(null as number) as "p", 
  cast(null as number) as "q", 
  b.country as "Bottom20" , 
  b.Total_Cases as "tt"  
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
        select 10,  'cases' txt 
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
            from  covid 
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
     sum(deaths) ||'(' ||  round(sum(deaths)/(sum(deaths)+sum(recovered))*100) || '%)' 
       from covid 
  ) o  
  on a.sn = o.sn 
  ORDER BY 
  a.SN
