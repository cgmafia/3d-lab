/*
-- Additional Macroscript for pFlow State | Add exception.
-- Author: deko
-- Website: lab.deko.lt
*/
macroScript pFlowstate_add_exception category:"deko.lt" toolTip:"PF_Add Exception" buttonText:"Add exception"
(
	--Add Pflow State Exception to SELECTED pFLOW systems
	for o in $ where classOf o == PF_Source do
	(
		setUserProp o "pf_State_Except" True
		print ("Exception Added: " + o.name)
	)	
)