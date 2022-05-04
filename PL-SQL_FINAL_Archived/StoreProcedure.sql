CREATE TABLE CPROJ_RESULT(
A1 varchar2(100),
B1 varchar2(100),
C1 varchar2(100),
D1 varchar2(100),
E1 varchar2(100),
F1 varchar2(100),
G1 varchar2(100),
H1 varchar2(100),
I1 varchar2(100),
J1 varchar2(100),
K1 varchar2(100),
L1 varchar2(100),
M1 varchar2(100),
N1 varchar2(100),
O1 varchar2(100),
P1 varchar2(100),
Q1 varchar2(100),
R1 varchar2(100),
S1 varchar2(100)
)

CREATE OR REPLACE Procedure SP_CPROJ_INSERT
   as
       cursor C1 is
Select 
    a.Country as "A1",                                   
    a.Total_cases as "B1",                                
    cast(null as number) as "C1",                     
    cast(null as number) as "D1",                            
    c.txt as "E1",                               
    d.txt as "F1",            
    e.txt as "J1",
    f.txt as "I1", 
    cast(null as number) as "J1", 
    g.txt as "K1",
    cast(null as number) as "L1", 
    cast(null as number) as "M1", 
    h.txt as "N1", 
    i.txt as "S1", 
    j.txt as "O1", 
    cast(null as number) as "P1",
    cast(null as number) as "Q1", 
    b.Country as "R1",
    b.Total_cases as "S1"
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
  
c1_A1 varchar2(100);
c1_B1 varchar2(100);
c1_C1 varchar2(100);
c1_D1 varchar2(100);
c1_E1 varchar2(100);
c1_F1 varchar2(100);
c1_G1 varchar2(100);
c1_H1 varchar2(100);
c1_I1 varchar2(100);
c1_J1 varchar2(100);
c1_K1 varchar2(100);
c1_L1 varchar2(100);
c1_M1 varchar2(100);
c1_N1 varchar2(100);
c1_O1 varchar2(100);
c1_P1 varchar2(100);
c1_Q1 varchar2(100);
c1_R1 varchar2(100);
c1_S1 varchar2(100);

v_query varchar2(4000);


BEGIN
    OPEN C1;
    INSERT INTO CPROJ_RESULT VALUES('Top 20',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','Bottom 20',' ');
        LOOP
            FETCH C1 INTO c1_A1,c1_B1,c1_C1,c1_D1,c1_E1,c1_F1,c1_G1,c1_H1,c1_I1,c1_J1,c1_K1,c1_L1,c1_M1,c1_N1,c1_O1,c1_P1,c1_Q1,c1_R1,c1_S1;
            exit when c1%notfound;
            INSERT INTO CPROJ_RESULT VALUES (c1_A1,c1_B1,c1_C1,c1_D1,c1_E1,c1_F1,c1_G1,c1_H1,c1_I1,c1_J1,c1_K1,c1_L1,c1_M1,c1_N1,c1_O1,c1_P1,c1_Q1,c1_R1,c1_S1);
        END LOOP;
    CLOSE C1;
END;

Execute SP_CPROJ_INSERT;

TRUNCATE TABLE CPROJ_RESULT;

Select * from CPROJ_RESULT;
