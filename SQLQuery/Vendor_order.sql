update dt_ibm_shipment set `COMINV_status` = 1, `COMINV_DOC_status` = 0, `COMINV_proces_date` = null, `COMINV_DOC_proces_date` = null, `COMINV_retry_count` = 0, `COMINV_DOC_retry_count` = 0, shipment_id='8726826161', `invoice_number`='INV0811005', `file_names` = '94023B0967-1689356118357.pdf' where id =3;

update dt_ibm_shipment set `COMINV_status` = 1, `COMINV_DOC_status` = 0, `COMINV_proces_date` = null, `COMINV_DOC_proces_date` = null, `COMINV_retry_count` = 0, `COMINV_DOC_retry_count` = 0, shipment_id='1184834453', `invoice_number`='INV0810002', `file_names` = 'AWB3641760496INV94023A9385.pdf' where id =2;

update dt_ibm_shipment set `COMINV_status` = 1, `COMINV_DOC_status` = 0, `COMINV_proces_date` = null, `COMINV_DOC_proces_date` = null, `COMINV_retry_count` = 0, `COMINV_DOC_retry_count` = 0, shipment_id='20230810001', `invoice_number`='INV0810001', `file_names` = 'AWB3641776095Inv94023C7585.pdf' where id =3;

update dt_ibm_shipment set `COMINV_DOC_retry_count` = 0;

update dt_ibm_shipment set COMINV_status = 0, COMINV_retry_count=0, COMINV_DOC_status  = 0, COMINV_DOC_retry_count =0 where id in (12,13);