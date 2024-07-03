/*
-- Additional Macroscript for pFlow State | SELECT pFLOW systems who marked as exceptions
-- Author: deko (function deleteUserProp by Denis Trofimov)
-- Website: lab.deko.lt
*/
macroScript pFlowstate_select_exception category:"deko.lt" toolTip:"PF_SELECT pFLOW systems who marked as exception" buttonText:"Select exception"
(
	clearselection()
	for o in objects where classOf o == PF_Source and getUserProp o "pf_State_Except" != undefined do
	(
		selectMore o
		print o.name
	)
)