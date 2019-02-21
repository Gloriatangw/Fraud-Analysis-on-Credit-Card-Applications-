# -*- coding: utf-8 -*-
"""
Created on Mon Mar 26 18:35:16 2018

@author: alok_
"""

import numpy as np
import pandas as pd
import sklearn as sk
import seaborn as sbrn
import matplotlib.pyplot as plt
import pylab
from datetime import datetime


App_Exprt_DF_ALL = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/Application_data_with_expert_variables.csv')
App_Exprt_DF_KS_ALL = App_Exprt_DF_ALL[['fraud','same_zip_5.x','same_ssn_5.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_phone_diff_ssn_1.x','same_ssn_diff_zip_3.x','same_ssn_diff_address_3.x','same_ssn_diff_dob_3.x','same_ssn_3.x','same_ssn_diff_dob_5.x','same_phone_diff_dob_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_dob_7.x','same_ssn_diff_address_5.x','same_ssn_diff_zip_5.x','same_ssn_diff_phone_7.x','same_zip_diff_address_1.x','same_zip_1.x','same_zip_diff_ssn_1.x','same_phone_diff_phone_1.x','same_phone_diff_dob_1.x','same_phone_diff_zip_3.x','same_phone_diff_dob_1.x.x','same_ssn_diff_zip_7.x','same_phone_diff_ssn_3.x','same_ssn_diff_dob_30.x','same_ssn_diff_dob_14.x','same_ssn_7.x','same_ssn_diff_address_7.x','same_ssn_1.x','same_phone_diff_dob_7.x','same_phone_3.x','same_phone_diff_address_3.x','same_ssn_diff_phone_30.x','same_ssn_diff_phone_14.x','same_phone_diff_zip_5.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_phone_diff_ssn_5.x','same_nameDOB_diff_address_7.x']]
App_Exprt_DF_Train = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/Train_App_data_with_xprt_var.csv')
App_Exprt_DF_Train_KS = App_Exprt_DF_Train[['fraud','same_zip_5.x','same_ssn_5.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_phone_diff_ssn_1.x','same_ssn_diff_zip_3.x','same_ssn_diff_address_3.x','same_ssn_diff_dob_3.x','same_ssn_3.x','same_ssn_diff_dob_5.x','same_phone_diff_dob_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_dob_7.x','same_ssn_diff_address_5.x','same_ssn_diff_zip_5.x','same_ssn_diff_phone_7.x','same_zip_diff_address_1.x','same_zip_1.x','same_zip_diff_ssn_1.x','same_phone_diff_phone_1.x','same_phone_diff_dob_1.x','same_phone_diff_zip_3.x','same_phone_diff_dob_1.x.x','same_ssn_diff_zip_7.x','same_phone_diff_ssn_3.x','same_ssn_diff_dob_30.x','same_ssn_diff_dob_14.x','same_ssn_7.x','same_ssn_diff_address_7.x','same_ssn_1.x','same_phone_diff_dob_7.x','same_phone_3.x','same_phone_diff_address_3.x','same_ssn_diff_phone_30.x','same_ssn_diff_phone_14.x','same_phone_diff_zip_5.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_phone_diff_ssn_5.x','same_nameDOB_diff_address_7.x']]
App_Exprt_DF_Test = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/Test_App_data_with_xprt_var.csv')
App_Exprt_DF_Test_KS = App_Exprt_DF_Test[['fraud','same_zip_5.x','same_ssn_5.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_phone_diff_ssn_1.x','same_ssn_diff_zip_3.x','same_ssn_diff_address_3.x','same_ssn_diff_dob_3.x','same_ssn_3.x','same_ssn_diff_dob_5.x','same_phone_diff_dob_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_dob_7.x','same_ssn_diff_address_5.x','same_ssn_diff_zip_5.x','same_ssn_diff_phone_7.x','same_zip_diff_address_1.x','same_zip_1.x','same_zip_diff_ssn_1.x','same_phone_diff_phone_1.x','same_phone_diff_dob_1.x','same_phone_diff_zip_3.x','same_phone_diff_dob_1.x.x','same_ssn_diff_zip_7.x','same_phone_diff_ssn_3.x','same_ssn_diff_dob_30.x','same_ssn_diff_dob_14.x','same_ssn_7.x','same_ssn_diff_address_7.x','same_ssn_1.x','same_phone_diff_dob_7.x','same_phone_3.x','same_phone_diff_address_3.x','same_ssn_diff_phone_30.x','same_ssn_diff_phone_14.x','same_phone_diff_zip_5.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_phone_diff_ssn_5.x','same_nameDOB_diff_address_7.x']]
App_Exprt_DF_OOT = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/OOT_App_data_with_xprt_var.csv')
App_Exprt_DF_OOT_KS = App_Exprt_DF_OOT[['fraud','same_zip_5.x','same_ssn_5.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_phone_diff_ssn_1.x','same_ssn_diff_zip_3.x','same_ssn_diff_address_3.x','same_ssn_diff_dob_3.x','same_ssn_3.x','same_ssn_diff_dob_5.x','same_phone_diff_dob_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_dob_7.x','same_ssn_diff_address_5.x','same_ssn_diff_zip_5.x','same_ssn_diff_phone_7.x','same_zip_diff_address_1.x','same_zip_1.x','same_zip_diff_ssn_1.x','same_phone_diff_phone_1.x','same_phone_diff_dob_1.x','same_phone_diff_zip_3.x','same_phone_diff_dob_1.x.x','same_ssn_diff_zip_7.x','same_phone_diff_ssn_3.x','same_ssn_diff_dob_30.x','same_ssn_diff_dob_14.x','same_ssn_7.x','same_ssn_diff_address_7.x','same_ssn_1.x','same_phone_diff_dob_7.x','same_phone_3.x','same_phone_diff_address_3.x','same_ssn_diff_phone_30.x','same_ssn_diff_phone_14.x','same_phone_diff_zip_5.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_phone_diff_ssn_5.x','same_nameDOB_diff_address_7.x']]


App_Exprt_DF_KS_ALL.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_KS.csv', encoding='utf-8')
App_Exprt_DF_Train_KS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Train_KS.csv', encoding='utf-8')
App_Exprt_DF_Test_KS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Test_KS.csv', encoding='utf-8')
App_Exprt_DF_OOT_KS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_OOT_KS.csv', encoding='utf-8')

App_Exprt_DF_KS_ALL = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_KS.csv')
App_Exprt_DF_KS_SS_ALL = App_Exprt_DF_KS_ALL[['fraud','same_zip_1.x','same_zip_5.x','same_ssn_5.x','same_ssn_3.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_phone_7.x','same_ssn_diff_address_5.x','same_ssn_diff_address_7.x','same_ssn_diff_dob_14.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_ssn_diff_zip_7.x','same_zip_diff_address_1.x','same_zip_diff_ssn_1.x','same_phone_diff_zip_3.x','same_phone_diff_zip_5.x','same_phone_diff_dob_7.x','same_phone_diff_dob_1.x','same_phone_diff_ssn_3.x']]
App_Exprt_DF_Train_KS = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Train_KS.csv')
App_Exprt_DF_Train_KS_SS = App_Exprt_DF_Train_KS[['fraud','same_zip_1.x','same_zip_5.x','same_ssn_5.x','same_ssn_3.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_phone_7.x','same_ssn_diff_address_5.x','same_ssn_diff_address_7.x','same_ssn_diff_dob_14.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_ssn_diff_zip_7.x','same_zip_diff_address_1.x','same_zip_diff_ssn_1.x','same_phone_diff_zip_3.x','same_phone_diff_zip_5.x','same_phone_diff_dob_7.x','same_phone_diff_dob_1.x','same_phone_diff_ssn_3.x']]
App_Exprt_DF_Test_KS = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Test_KS.csv')
App_Exprt_DF_Test_KS_SS = App_Exprt_DF_Test_KS[['fraud','same_zip_1.x','same_zip_5.x','same_ssn_5.x','same_ssn_3.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_phone_7.x','same_ssn_diff_address_5.x','same_ssn_diff_address_7.x','same_ssn_diff_dob_14.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_ssn_diff_zip_7.x','same_zip_diff_address_1.x','same_zip_diff_ssn_1.x','same_phone_diff_zip_3.x','same_phone_diff_zip_5.x','same_phone_diff_dob_7.x','same_phone_diff_dob_1.x','same_phone_diff_ssn_3.x']]
App_Exprt_DF_OOT_KS = pd.read_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_OOT_KS.csv')
App_Exprt_DF_OOT_KS_SS = App_Exprt_DF_OOT_KS[['fraud','same_zip_1.x','same_zip_5.x','same_ssn_5.x','same_ssn_3.x','same_nameDOB_5.x','same_ssn_diff_phone_3.x','same_ssn_diff_phone_5.x','same_ssn_diff_phone_7.x','same_ssn_diff_address_5.x','same_ssn_diff_address_7.x','same_ssn_diff_dob_14.x','same_ssn_diff_zip_30.x','same_ssn_diff_zip_14.x','same_ssn_diff_zip_7.x','same_zip_diff_address_1.x','same_zip_diff_ssn_1.x','same_phone_diff_zip_3.x','same_phone_diff_zip_5.x','same_phone_diff_dob_7.x','same_phone_diff_dob_1.x','same_phone_diff_ssn_3.x']]

App_Exprt_DF_KS_SS_ALL.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_KS_SS_ALL.csv', encoding='utf-8')
App_Exprt_DF_Train_KS_SS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Train_KS_SS.csv', encoding='utf-8')
App_Exprt_DF_Test_KS_SS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_Test_KS_SS.csv', encoding='utf-8')
App_Exprt_DF_OOT_KS_SS.to_csv('C:/Users/alok_/Google Drive/Fraud Analytics Projects/Project Two/Reg Subset forward Selection/App_Exprt_DF_OOT_KS_SS.csv', encoding='utf-8')



