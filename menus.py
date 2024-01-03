import pandas as pd
from tkinter import filedialog
import tkinter as tk
import numpy as np


#Create the object

ventana=tk.Tk()
ventana.title('App With Menus')
ventana.config(width=300,height=300)

#Function

def warning():
    l.config(text="OK! This Option is working properly:)")

def warning2():
    l.config(text="Ok! it replaces the previous information:)")

def warning2():
    l.config(text="")


def import_file():
   # Crear una ventana de Tkinter
    root = tk.Tk()
    root.withdraw()
    # Abrir la ventana de selección de archivo
    archivo = filedialog.askopenfilename()
    # Leer el archivo Excel seleccionado
    df = pd.read_excel(archivo)


#Create a new empty label
l=tk.Label(text="")
l.place(x=30,y=30)

#Create the menu bar

menu_bar=tk.Menu(ventana)


#Create Menu options

option1=tk.Menu(menu_bar,tearoff=0)
option1.add_command(label="New Text File",command=warning)
option1.add_command(label="New File")


option2=tk.Menu(menu_bar,tearoff=0)
option2.add_command(label="Undo")
option2.add_command(label="Redo")
option2.add_command(label="Cut")



#menu_bar.add_command(label="File")
#menu_bar.add_command(label="Edit")
#menu_bar.add_command(label="Selection")


menu_bar.add_cascade(label="File",menu=option1)
menu_bar.add_cascade(label="Edit",menu=option2)
ventana.config(menu=menu_bar)
ventana.mainloop()
