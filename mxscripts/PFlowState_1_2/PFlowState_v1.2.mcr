/*
-- Macroscript to turn ON / OFF Particle Flow Emission
-- Version 1.2
-- Last Update: 2010.06.24
-- Author: deko
-- Website: http://lab.deko.lt
*/
macroScript pFlowstate category:"deko.lt" toolTip:"Turn On/Off PFlow" buttonText:"PFlow On/Off" Icon:#("Particles",6)
(
	global pf_state=true
	on isChecked return not pf_state
				
	on execute do 
		(
			for o in objects where classOf o == PF_Source and getUserProp o "pf_State_Except" == undefined do
			(
				 o.Enable_Particles = pf_state
			)
		pf_state = not pf_state
		)	
)