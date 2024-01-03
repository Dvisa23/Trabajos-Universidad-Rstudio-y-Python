#Gini

#  1. Import libraries

import pandas as pd 
import tkinter as tk
import numpy as np
from tkinter import filedialog
from threading import Thread
 
# 1.1 Method
 
def gini(event=None):
    file = filedialog.askopenfilename()
    db = pd.read_excel(file)
    v=np.array(db.iloc[:,0])
    gini = 0.5 * np.abs(np.subtract.outer(v, v)).mean()/np.mean(v)
    wealth=db.iloc[:,0].sum()
    #mad = np.abs(np.subtract.outer(v, v)).mean()
    #rmad = mad/np.mean(v)
    #gini = 0.5 * rmad
    e1.config(text=f"The gini coefficient is: {gini}")
    e2.config(text=f"The wealth is: {wealth}")
 
# 2. Creating the object
 
ventana = tk.Tk()
ventana.title("Gini coefficient")
ventana.config(width=300,height=160)
 
# 3. Button to undertake the computation
 
b1 = tk.Button(ventana, text='Upload the File',command=gini)
b1.place(x=20,y=20)
 
e1=tk.Label(text="The Gini coefficient: ")
e1.place(x=20,y=50)
 
e2=tk.Label(text="The wealth of the society is: ")
e2.place(x=20,y=70)
 
# Close the loop
 
ventana.mainloop()