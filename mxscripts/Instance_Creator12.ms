------------------------------------ 
--Instance creator
-- v 1.2
-- by deko (http://lab.deko.lt)
-- Development begins: 2011.03.14
-- Last check: 2011.03.25
-- Tested on: 3dsmax 2011x64; 2012x64 | Win 7 SP1
-- Maxscript to replace objects with instances.
------------------------------------ 
--VAR
------------------------------------ 
global escapeEnable = true
picked --picked object variable
------------------ 
--GUI
------------------
try(destroyDialog InstRollout)catch()
InstanceDialog = newRolloutFloater "Instance Creator" 200 360

rollout InstRollout "Instance Creator"
(
	GroupBox grp1 "1. Source:" pos:[5,0] width:178 height:160
	radiobuttons rdo_pick "" labels:#("Pick") default:1 pos:[10,20] align: #left 
	label label4 "Pick object from viewport." align: #left 
	pickbutton btn_pick "Pick object" tooltip: "Pick Object To Replace With" enabled: true offset:[0,0] width:140 align: #left 
	button btn_access "=>" tooltip: "Select in viewport" enabled: false across: 1 width:18 align: #right offset:[3,-26]
	
	radiobuttons rdo_random "" labels:#("Random") default:0 align: #left
	label label3 "This will make instances from current selection, source object will be randomly picked." enabled: false align: #left width:160 height:48

	GroupBox grp2 "2. Destination:" pos:[5,170] width:178 height:60 tooltip: "Select some object from viewport"    
	label lbl_selected "---" style_sunkenedge:true tooltip: "Select some object from viewport" height: 18 width: 150 pos:[20,195]
	
	button btn_main "..::Replace::.." tooltip: "Make Happen!" width:170 height:48 offset:[0,30]
	checkbox chkbx_wireclr "Wirecolor" checked:true tooltip: "Change sources wirecolors after replacing"

---------------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------------		
    function selCatch obj = 
    (
	try(lbl_selected.text = (selection.count) as string + " selected")catch()	
    ) -- display what was selected from callback #selectionSetChanged
	
	function Replaceobj = (
				undo on (
				suspendEditing()
				setWaitCursor()		
				with redraw off
					InstanceMgr.MakeObjectsUnique selection #individual 
					case rdo_pick.state of (
					1: srcObj = picked
					0: srcObj = selection[random 1 selection.count]
					)	
					if isValidNode srcObj then (
													max create mode
													count = selection.count
													prcnt = 0
													progressStart ("Creating Instances...")
													for i in 1 to count do
													(	
													try(InstanceReplace selection[i] srcObj)catch()
													prcnt += 1	
													progressUpdate (100 * prcnt / (count + 1) ) 
													)
													progressEnd()
												)
											else messageBox "Error! Pick another object!" title:"Error!" beep:true
				resumeEditing()
				setArrowCursor()	
				--gc()
				--completeredraw()	
				)
	)
	
	function WireColor = (
		colorW = (color (random 0 255) (random 0 255) (random 0 255))
		selection.wirecolor = colorW
	)
	
---------------------------------------------------------------------------------
-- GUI Functions
---------------------------------------------------------------------------------	
		on InstRollout open do 
		(
		/* Realtime scene objects selection catch and display count in label */
		callbacks.addScript #selectionSetChanged "InstRollout.selCatch $" id:#cb1 
		lbl_selected.text = (selection.count) as string + " selected"
			
		/* Try to load previous picked objects */
			if isValidNode picked then (
			--try(btn_pick.text = picked.name)catch() 
			btn_pick.text = picked.name
			btn_access.enabled = true	
			)	
		)
		
		on InstRollout close do 
		(
		callbacks.removescripts #selectionSetChanged id:#cb1
		--clearUndoBuffer()
		)
		
	on rdo_random changed stat do
	(
		rdo_pick.state = 0
		label3.enabled = true
		label4.enabled = false
		btn_pick.enabled = false
		btn_access.enabled = false
	)
	
	on rdo_pick changed stat do
	(
		rdo_random.state = 0
		label3.enabled = false
		label4.enabled = true
		btn_pick.enabled = true
		btn_access.enabled = true
	)
		
    on btn_pick picked objPick do
        (
		btn_pick.text = objPick.name
		btn_pick.tooltip = objPick.name
		btn_access.enabled = true
		picked = objPick
        )
	
    on btn_access pressed do
        (
		if isValidNode picked then	
		(
			select picked
		)
		else messageBox "Pick some object first!" title:"No object picked!" beep:true
		)
		
    on btn_main pressed do
        (
					if selection.count != 0 then 
					(
					Replaceobj()
					if chkbx_wireclr.checked then WireColor()	
					) else messageBox "Select some objects, which will be replaced" title:"No object selected!" beep:true
		)

)
addrollout InstRollout InstanceDialog