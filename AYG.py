import pandas as pd
from tkinter import filedialog
import tkinter as tk
import numpy as np

def atkinson_y_gini():
   # Crear una ventana de Tkinter
    root = tk.Tk()
    root.withdraw()
    # Abrir la ventana de selección de archivo
    archivo = filedialog.askopenfilename()
    # Leer el archivo Excel seleccionado
    df = pd.read_excel(archivo)
    ncol= int(caja2.get())    
    income=df.iloc[:,ncol]
    media_income= income.mean()
    epsilon= float(caja1.get())


    if epsilon != 1 :

        potencia=float(1-epsilon)
        income_ep= income**potencia
        sumincome_ep= income_ep.sum()
        yede= ((1/len(income))*sumincome_ep)**(1/potencia)
        atkinson=1-(yede/media_income)

    
    else:

        potencia=float(1-epsilon)
        income_ep= income**(1/len(income))
        yede= sumincome_ep= income_ep.prod()
        atkinson=1-(yede/media_income)


    v=np.array(df.iloc[:,ncol])
    gini = 0.5 * np.abs(np.subtract.outer(v, v)).mean()/np.mean(v)
    wealth=df.iloc[:,ncol].sum()
    #mad = np.abs(np.subtract.outer(v, v)).mean()
    #rmad = mad/np.mean(v)
    #gini = 0.5 * rmad
    e1.config(text=f"The gini coefficient is: {gini}")
    e2.config(text=f"The wealth is: {wealth}")
 




    eal.config(text=f"El calculo de atkinson es : {atkinson}")
   


ventana=tk.Tk()
ventana.config(width=300,height=300)

ba=tk.Label(text="Valor Epsilon:")
ba.place(x=20,y=50)

caja1=tk.Entry() #Boton del atkinson
caja1.place(x=130,y=50,width=50)


bcol=tk.Label(text="Numero Columna:") 
bcol.place(x=20,y=20)
caja2=tk.Entry()
caja2.place(x=130,y=20,width=50)#Numero de columna



b1=tk.Button(text="cargar archivo",command=atkinson_y_gini)
b1.place(x=140,y=150)

eal=tk.Label(text="El calculo es :") #Calculo del atkinson
eal.place(x=20,y=120)
 
e1=tk.Label(text="The Gini coefficient: ") # Calculo del Gini
e1.place(x=20,y=80)
 
e2=tk.Label(text="The wealth of the society is: ") #Calculo del Wealth
e2.place(x=20,y=100)

ventana.mainloop()