Create table FINAL_CPROJ as
Select 
    a.Country as "TOP 20",                                   
    a.Total_cases as "B",                                
    cast(null as number) as "C",                     
    cast(null as number) as "D",                            
    c.txt as "E",                               
    d.txt as "F",            
    e.txt as "G",
    f.txt as "H", 
    cast(null as number) as "I", 
    g.txt as "J",
    cast(null as number) as "K", 
    cast(null as number) as "L", 
    h.txt as "M", 
    i.txt as "N", 
    j.txt as "O", 
    cast(null as number) as "P",
    cast(null as number) as "Q", 
    b.Country as "Bottom 20",
    b.Total_cases as "S"
From
    (Select ROWNUM RN,
            Country,
            to_char(TOTAL_CASES,'999,999,999') Total_Cases
            From
            (SELECT Distinct Country,
                    Total_Cases
                    from CPROJ
                    order by Total_Cases DESC)
                    where ROWNUM < 21) a                    /*Main Table*/
Left Join
    (Select ROWNUM RN,
            Country,
            Total_Cases
            From
            (SELECT Distinct Country,
            Total_Cases
            from CPROJ order by Total_Cases /*ASC*/)
            where ROWNUM < 21) b
on a.RN = b.RN

Left Join
(
Select 2 RN, 'TOTAL CASES' txt from dual
Union
Select 3, to_char(sum(total_cases),'999,999,999') from CPROJ
union
select 9, 'Active' from dual
union
select 10, 'Cases' from dual
) c
on a.RN = c.RN

Left Join
(
select 14 RN, ''||to_char(sum(total_cases)-sum(serious_critical)-sum(deaths)-sum(recovered),'999,999,999')||'('||round((sum(total_cases)-sum(serious_critical)-sum(deaths)-sum(recovered)) / --contd 
               (sum(total_cases)-sum(deaths)-sum(recovered)) * 100,1)||'%)' txt from CPROJ
union
select 15, 'in mild condition' from dual
union 
select 19, Country||' Position:' || a.position || ' Total:' || a.total_cases || ' Today:' || a.new_cases || ' Deaths:' || a.deaths || ' Today:' || nvl(a.new_deaths,0)
        from
            (
            select
            country,
            total_cases,
            new_cases,
            deaths,
            new_deaths,
            row_number () over (order by total_Cases desc) as position
            from  CPROJ
        )a
        where
          UPPER(Country) = 'NEPAL'
) d
on a.RN = d.RN


Left Join
(
Select 10 RN, ''||to_char(sum(Total_Cases) - sum(recovered) - sum(Deaths),'999,999,999') txt From CPROJ 
Union
Select 11, 'Currently infected patients' from dual
) e
on a.RN = e.RN



Left Join
(
Select 14 RN, ''||to_char(sum(Serious_Critical),'999,999,999')||'('||(round((sum(Serious_Critical) / (sum(Total_Cases) - sum(recovered) - sum(Deaths)) * 100) ,1))||'%)' txt From CPROJ 
Union
Select 15, 'Serious or critical' from dual ) f
on a.RN = f.RN               

Left Join
(
Select 2 RN, 'Deaths' txt from dual
union
select 3, ''||to_char(sum(DEATHS),'999,999,999') from CPROJ) g
on a.RN = g.RN

Left Join
(
Select 14 RN, to_char(sum(Recovered),'999,999,999')||'('||round((sum(Recovered)/(sum(Deaths) + sum(Recovered)) * 100))||'%)' txt from CPROJ
union
select 15, 'Reovered/Discharged' from dual
) h
on a.RN = h.RN

Left Join
(
Select 2 RN, 'Recovered:' txt from dual
union
Select 3, to_char(sum(Recovered),'999,999,999') txt from CPROJ
union
select 8, 'Closesd case' from dual
union
select 10, to_char(sum(Deaths) + sum(Recovered),'999,999,999') txt from CPROJ
union
select 11, 'Cases which had an outcome' from dual
) i
on a.RN = i.RN

Left Join
(
Select 14 RN, to_char(sum(Deaths),'999,999,999')||'('||round((sum(Deaths)/(sum(Deaths) + sum(Recovered)) * 100))||'%)' txt from CPROJ
union
Select 15, 'Deaths' from dual
) j
on a.RN = j.RN

ORDER BY
  a.RN;
  
select * from FINAL_CPROJ;
