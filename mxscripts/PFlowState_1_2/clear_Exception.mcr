/*
-- Additional Macroscript for pFlow State | Clear exception from selected pFLOW systems.
-- Author: deko (function deleteUserProp by Denis Trofimov)
-- Website: lab.deko.lt
*/
macroScript pFlowstate_clear_exception category:"deko.lt" toolTip:"PF_Clear Exception from selected pFlows" buttonText:"Clear exception"
(
	fn deleteUserProp node prop = if getUserProp node prop != undefined do
		(
		 buff = (getUserPropBuffer node) as stringStream 
		 newb = stringStream ""
		 while not eof buff do
						 (
						  str = readLine buff
						  if str != "" and not matchpattern str pattern:("*" + prop + "*=*") do format "%\n" str to:newb
						 )
		 setUserPropBuffer node (replace_LF_with_CRLF (newb as string))
		)
	
		for o in $ where classOf o == PF_Source and getUserProp o "pf_State_Except" != undefined do
		(
			deleteUserProp o "pf_State_Except"
			print ("Exception Deleted: " + o.name)
		)
)