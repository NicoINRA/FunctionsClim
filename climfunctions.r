
#function to convert Mixing ratio to relative humidity 
MIXHR<-function(Tc, PRES=F,M) {
  #function to convert Mixing ratio to relative humidity 
  Mas=28.966 # masse molaire air sec (g/mol)
  Mh2o=18 # masse molaire H2O(g/mol)
  Rgz=8.314472 # %J/mol/K cste gaz parfait
  p_air=101325 #  %en Pa
  
Tc=Tc
Tk=Tc+273.15
if(press) {Dair=((PRES)/(Rgz*(Tk)))*Mas } else {Dair=((p_air)/(Rgz*(Tk)))*Mas} # Calcul de la masse volumique de l'air sec en g.m-3
es=6.108*exp(17.27*Tc/(237.2+Tc))*100 # Pression de vapeur saturante ? la Temp?rature T (en Pa)
#esm=6.108*exp(17.27*Tcm/(237.2+Tcm))*100 # Pression de vapeur saturante ? la Temp?rature T (en Pa)
ea=M*Dair/1000/(Mh2o/1000)*Tk*Rgz
HR=ea/es*100
HR[HR>100]<-100
HR[HR<0]<-0
return(c(HR, ea, es))
}

#Functions to switch from relative humidity to specific humidity
.HSHR<-function(Tc, HS, allowSaturated = FALSE){
  
  
  #-------------------------------------------------------------
  #D?claration des constantes pour le calcul de l'HR et de la T en ?C
  Mas=28.966 # masse molaire air sec (g/mol)
  Mh2o=18 # masse molaire H2O(g/mol)
  Rgz=8.314472 # %J/mol/K cste gaz parfait
  p_air=101325 #  %en Pa
  #-------------------------------------------------------------
  
  #Calcul de l'Humidit? relative bas? sur Hs et Tk
  Tk=Tc+273.15
  Dair=((p_air)/(Rgz*(Tk)))*Mas # Calcul de la masse volumique de l'air sec en g.m-3
  masshum=HS*Dair # Masse d'eau dans l'air g.m-3
  nhum=masshum/Mh2o # en mol.m-3
  ea=nhum*(Rgz*(Tk)) # Pression de vapeur r?elle (en Pa)
  es=6.108*exp(17.27*Tc/(237.2+Tc))*100 # Pression de vapeur saturante ? la Temp?rature T (en Pa)
  HR=ea/es*100 #Calcul de l'HR
  if(!allowSaturated) HR[HR>100]=100 # On ne passe pas audessus de 100
  return(HR)
}

.HRHS<-function(Tc, HR){
  
  #-------------------------------------------------------------
  #D?claration des constantes pour le calcul de l'HR et de la T en ?C
  Mas=28.966 # masse molaire air sec (g/mol)
  Mh2o=18 # masse molaire H2O(g/mol)
  Rgz=8.314472 # %J/mol/K cste gaz parfait
  p_air=101325 #  %en Pa
  #-------------------------------------------------------------
  
  #Calcul de l'Humidit? relative bas? sur Hs et Tk
  Tk=Tc+273.15
  
  Dair=((p_air)/(Rgz*(Tk)))*Mas # Calcul de la masse volumique de l'air sec en g.m-3
  es=6.108*exp(17.27*Tc/(237.2+Tc))*100 # Pression de vapeur saturante ? la Temp?rature T (en Pa)
  ea=HR*es/100 #Calcul de l'ea
  nhum=ea/(Rgz*(Tk)) # Pression de vapeur r?elle (en Pa)
  masshum=nhum*Mh2o # en mol.m-3
  HS=masshum/Dair
  return(HS)
}
