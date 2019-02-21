install.packages("RSQLite")
library(RSQLite)
install.packages("sqldf")
library(sqldf)
install.packages("RODBC")
library(RODBC)
library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(tidyr)


#Create three names for same dataset

a <- read.csv("new_applications.csv")
b <- a
df<- a

#Create unique identifier per professor's instructions

ID = paste0(df$firstname,"_", df$lastname)
df$ID = paste0(ID, "_", df$newssn)

#Create expert variables with SQL 

ssn = sqldf("SELECT a.record,
COUNT(CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_1,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_5,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_7,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_14,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_ssn_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_ssn_diff_address_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_ssn_diff_phone_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_1,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_ssn_diff_dob_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_1,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_ssn_diff_zip_30
from a, b
WHERE a.newssn = b.newssn
GROUP BY 1")



phone = sqldf("SELECT a.record,
COUNT(CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_1,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_3,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_5,
              COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_7,
              COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_14,
              COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_phone_30,
              COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_1, 
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_3,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_5,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_7,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_14,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_phone_diff_address_30,
              COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_phone_diff_ssn_1, 
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_phone_diff_ssn_3,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_phone_diff_ssn_5,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_phone_diff_ssn_7,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_phone_diff_ssn_14,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_phone_diff_ssn_30,
              COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_1, 
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_3,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_5,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_7,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_14,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_30,
              COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_1, 
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_3,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_7,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_5,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_14,
              COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.zip5 ELSE NULL END)  AS same_phone_diff_zip_30
              
from a, b
WHERE a.homephone = b.homephone
GROUP BY 1")

zip = sqldf("SELECT a.record,
COUNT(CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_1,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_5,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_7,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_14,
COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_zip_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_zip_diff_address_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_zip_diff_ssn_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_zip_diff_dob_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_zip_diff_dob_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_phone_diff_dob_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_zip_diff_dob_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newdob ELSE NULL END)  AS same_zip_diff_dob_30,
COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_phone_diff_phone_1, 
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_zip_diff_phone_3,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_zip_diff_phone_7,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_phone_diff_phone_5,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_zip_diff_phone_14,
COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_zip_diff_phone_30

from a, b
WHERE a.zip5 = b.zip5
GROUP BY 1")

nameDOB = sqldf("SELECT a.record,
COUNT(CASE WHEN a.appdate = b.appdate THEN a.record ELSE NULL END)  AS same_nameDOB_1,
                COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_nameDOB_3,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_nameDOB_5,
                COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_nameDOB_7,
                COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_nameDOB_14,
                COUNT(CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN a.record ELSE NULL END)  AS same_nameDOB_30,
                COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_1, 
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_3,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_5,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_7,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_14,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.address ELSE NULL END)  AS same_nameDOB_diff_address_30,
                COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_1, 
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_3,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_5,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_7,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_14,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.newssn ELSE NULL END)  AS same_nameDOB_diff_ssn_30,
                COUNT(DISTINCT CASE WHEN a.appdate = b.appdate AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_nameDOB_diff_phone_1, 
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 2 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_nameDOB_diff_phone_3,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 6 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_nameDOB_diff_phone_7,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 4 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_phone_diff_phone_5,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 13 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_nameDOB_diff_phone_14,
                COUNT(DISTINCT CASE WHEN a.appdate - b.appdate BETWEEN 0 AND 29 AND a.record> b.record THEN b.homephone ELSE NULL END)  AS same_nameDOB_diff_phone_30
                
                from a, b
                WHERE a.lastname = b.lastname
                AND a.newdob=b.newdob
                GROUP BY 1")


#join datasets

df <- inner_join(df, zip, by ="record")
df <- inner_join(df, ssn, by ="record")
df <- inner_join(df, phone, by ="record")
df <- inner_join(df, nameDOB, by ="record")

saveRDS(df, file ="expert variables")


