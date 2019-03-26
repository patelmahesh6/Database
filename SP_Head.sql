CREATE OR REPLACE PACKAGE WEBLISHER.HR_CUST_REPORT AS
TYPE RCT1 IS REF CURSOR;

PROCEDURE GET_STATUS(RC OUT RCT1) ;      
 
PROCEDURE GET_REPORT(
     p_warehouseid NUMBER,
     p_statusid NUMBER,
     p_assign_date_from VARCHAR2,
     p_assign_date_to VARCHAR2,
     p_start NUMBER,
     p_end NUMBER,
     NROWCOUNT IN OUT NUMBER,
     rc OUT rct1
     
);

END HR_CUST_REPORT;
/
