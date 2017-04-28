from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import numpy as np

import sys

job_data=[]
conn = psycopg2.connect(database="finalproject", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
cur.execute("SELECT * from cleaned_jobs94_14")
records=cur.fetchall()
for rec in records:
    job_data.append([int(rec[0]), int(rec[2]), int(rec[3])])
job_data=np.array(job_data)

u= np.unique(job_data[:,0])
slope=[]
for i in u:
    temp_min=0
    temp_max=0
    z = np.polyfit(job_data[job_data[:,0]==i][:,2], job_data[job_data[:,0]==i][:,1], 1)
    temp_min=job_data[job_data[:,0]==i][:,1][np.argmin(job_data[job_data[:,0]==i][:,1])]
    temp_max=job_data[job_data[:,0]==i][:,1][np.argmax(job_data[job_data[:,0]==i][:,1])]
    cur.execute("INSERT INTO regression (zip, slope) VALUES (%s, %s)", (i, z[0]/(temp_max-temp_min)))
    conn.commit()
conn.close()
