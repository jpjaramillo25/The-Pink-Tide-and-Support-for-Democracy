

use "C:\Users\jpjar\Downloads\1626360926english_merge_2010_americasbarometer_v14v3.dta", clear


drop if gob_izquierda == .



ttest demo, by(gob_izquierda)


tabstat demo lnpib_pca gini2 gov_effi tributos_2 izqui_2 conf_gov educacion2 edad_2, by(pais)

tabstat demo lnpib_pca peor_econ_personal, by(pais)


*table 2

sum demo lnpib_pca gini2 gov_effi tributos_2 i.gob_izquierda c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid

sum  i1.etid


*table 1
*model 1 mutilevel

mixed demo lnpib_pca gini2 gov_effi tributos_2 i.gob_izquierda c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid|| pais:, robust


outreg2 using demo.doc, ctitle(demo) replace


*model 2 ols

reg demo lnpib_pca gini2 gov_effi tributos_2 i.gob_izquierda c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid, vce (cluster pais)

vif



outreg2 using demo.doc, ctitle(demo) append


*model 3ols with fixed effects

reg demo lnpib_pca gini2 gov_effi tributos_2 i.gob_izquierda c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid i.pais, vce (cluster pais)



outreg2 using demo.doc, ctitle(demo) drop (i.pais) append



*split 

mixed demo lnpib_pca gini2 gov_effi tributos_2 c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid if gob_izquierda == 1|| pais:, robust

mixed demo lnpib_pca gini2 gov_effi tributos_2 c.izqui_2 c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid if gob_izquierda == 0|| pais:, robust


mixed demo lnpib_pca gini2 gov_effi tributos_2 c.izqui_2##i.gob_izquierda c.conf_gov peor_econ_personal  educacion2 rural mujer edad_2  i.etid || pais:, robust
