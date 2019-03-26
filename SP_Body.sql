CREATE OR REPLACE PACKAGE body WEBLISHER.HR_CUST_REPORT AS



PROCEDURE GET_STATUS(RC OUT RCT1) 
AS
BEGIN
     OPEN RC FOR
     SELECT 
        *
     FROM   HR_CUST_STATUS; 
     
END;


PROCEDURE GET_REPORT(
     p_warehouseid NUMBER,
     p_statusid NUMBER,
     p_assign_date_from VARCHAR2,
     p_assign_date_to VARCHAR2,
     p_start NUMBER,
     p_end NUMBER,
     NROWCOUNT IN OUT NUMBER,    
     rc OUT rct1
    
   ) as 
   e_date varchar2(100);
   f_date varchar2(100);
     BEGIN
     
        if p_assign_date_to is null or length(p_assign_date_to)=0 then
          e_date := to_char(sysdate,'DD/MM/YYYY');
          else 
              e_date  :=p_assign_date_to;
        end if;
        OPEN rc FOR
        
        SELECT t.*
            FROM (
            SELECT  ROW_NUMBER() OVER (ORDER BY CT.TRANSACTION_NO desc) num ,CT.TRANSACTION_NO,CS.DESCRIPTION, CT.SUBMIT_DATE ,G.SLM_NAME ,CT.SUBMIT_BY_GRP  
		    FROM HR_CUST_REQUESTS CT ,dp_emp_mv_grp G ,HR_CUST_STATUS CS
            WHERE  CT.SUBMIT_BY_GRP = g.grp_serl_no
            AND CT.STATUS = CS.STATUS_ID
            AND CT.WAREHOUSE_ID = DECODE (p_warehouseid,-1, CT.WAREHOUSE_ID,p_warehouseid)
            AND CT.STATUS = DECODE (p_statusid,-1, CT.STATUS,p_statusid)
            AND TO_DATE(TO_CHAR(CT.SUBMIT_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') BETWEEN TO_DATE(p_assign_date_from,'DD/MM/YYYY') AND TO_DATE(e_date,'DD/MM/YYYY')
            ORDER BY CT.TRANSACTION_NO DESC) t
            WHERE num BETWEEN (p_start-1)* p_end + 1AND (p_start)*p_end ;
                
         SELECT COUNT(*) INTO NROWCOUNT FROM  HR_CUST_REQUESTS CT ,dp_emp_mv_grp G ,HR_CUST_STATUS CS
            WHERE  CT.SUBMIT_BY_GRP = g.grp_serl_no
            AND CT.STATUS = CS.STATUS_ID
            AND CT.WAREHOUSE_ID = DECODE (p_warehouseid,-1, CT.WAREHOUSE_ID,p_warehouseid)
            AND CT.STATUS = DECODE (p_statusid,-1, CT.STATUS,p_statusid)
            AND TO_DATE(TO_CHAR(CT.SUBMIT_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') BETWEEN TO_DATE(p_assign_date_from,'DD/MM/YYYY') AND TO_DATE(e_date,'DD/MM/YYYY')
            ORDER BY CT.TRANSACTION_NO DESC ;     
                
           
     END;  
    
END HR_CUST_REPORT;
/
