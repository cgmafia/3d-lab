-------------------------------------------------------------------------------
-- Modifiers Control_v1.ms
-- by DeKo (www.deko.lt)
-- v 1.0
-- Developing begin: 2005.11.16
-- tested using Max 8.0
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description:
-- Enable, Disable or Remove specific Modifiers from selected objects stack.
-------------------------------------------------------------------------------


------------------ 
--VAR
------------------
global escapeEnable = true
global SelectionGroup
	
------------------ 
--UI
------------------

rollout ModRemover "Modifiers Control" width:200 height:316 category: 0
(
	dropdownList ClassCombo "" pos:[27,105] width:157 height:21 items:#("Affect_Region", "Attribute_Holder", "Bend", "Bevel", "Bevel_Profile", "Camera_Map", "Cap_Holes", "CrossSection", "Delete_Mesh", "Delete_Patch", "Delete_Spline", "Disp_Approx", "Displace", "Displace_Mesh", "Displace_Nurbs", "Edit_Mesh", "Edit_Normals", "Edit_Patch", "Edit_Poly", "Edit_Spline", "Extrude", "Face_Extrude", "FDD", "Fillet/Chamfer", "Flex", "HSDS", "Lathe", "Lattice", "Linked_XForm", "LS_Colors", "LS_Mesh", "MapScaler", "Material", "MaterialbyElement", "Melt", "Mesh_Select", "MeshSmoth", "Mirror", "Morpher", "MultiRes", "Noise", "Normal", "NSurf_Sel", "Normalize_Spline", "Optimize", "Patch_Deform", "Patch_Select", "Physique", "Point_Cache", "Poly_Select", "Preserve", "Projection", "Projection_Holder", "Push", "Relax", "Renderable_Spline", "Ripple", "Select_by_Channel", "Shell", "Skew", "Skin", "Skin_Morph", "Skin Wrap", "Skin_Wrap_Patch", "Slice", "Smooth", "Spherify", "Spline_IK_Control", "Spline_Select", "Squeeze", "STL_Check", "Stretch", "Subdivide", "Substitute", "Surface_Mapper", "Surface", "SurfDeform", "Symmetry", "Taper", "Tesselate", "Trim/Extend", "TurboSmooth", "Turn_To_Mesh", "Turn_To_Patch", "Turn_To_Poly", "Twist", "Unwrap_UVW", "UVW_Map", "UVW_Mapping_Add", "UVW_Mapping_Clear", "UVW_XForm", "Vertex_Paint", "Vertex_Weld", "Volume_Select", "Wave", "XForm") selection:0
	edittext Edit1 "" pos:[92,16] width:92 height:16
	spinner spn5 "" pos:[95,53] width:92 height:16 range:[1,999,1] type:#integer scale:1 toolTip:"Delete modifier, counting from the top of the stack"
	radiobuttons RD_Name "" pos:[9,17] width:85 height:16 labels:#("by Name:") default:1
	radiobuttons RD_Stack "" pos:[9,53] width:82 height:16 labels:#("by Stack:") default:0 toolTip:"Delete modifier, counting from the top of the stack"
	radiobuttons RD_Class "" pos:[9,85] width:84 height:16 labels:#("by Class:") default:0
	GroupBox ActionGroup "Action:" pos:[6,135] width:190 height:95
	radiobuttons ActionRadio "" pos:[15,152] width:174 height:40 labels:#("Enable", "Disable", "Delete", "Select") default:3 columns:3
	button MainBtn "..::Do It::.." pos:[25,191] width:150 height:28 toolTip:"Just do It! To enable/disable, select or delete modifiers in objects"
	GroupBox Opt_group "Options" pos:[5,233] width:191 height:63
	checkbox SelOBJ_checkbx "Process only selected" pos:[14,248] width:130 height:20 checked:true
	checkbox MultiMod_checkbx "Multi modifiers check" pos:[14,271] width:128 height:19
	button HelpBtn "?" pos:[166,245] width:21 height:17
local x = 1  --modifiers select "by name";
local y = 3  --action "delete";
	
	
-------------------------------------------------------------------	
	
		  function ControlModbyName = (
				for obj in selectionGroup do
					for m in obj.modifiers where m.name == Edit1.text do (
							case ActionRadio.state of 
							(
								1: obj.modifiers[m.name].enabled = true
								2: obj.modifiers[m.name].enabled = false
								3: deleteModifier obj m
								4: selectMore obj				
							)							
															)	
								)  --End of ControlMod by Name
								
							
		  function ControlMultiModbyName = (
				for obj in selectionGroup do
					for m = obj.modifiers.count to 1 by -1 where (obj.modifiers[m].name) as string == Edit1.text do (
						
							case ActionRadio.state of 
							(
								1: obj.modifiers[m].enabled = true
								2: obj.modifiers[m].enabled = false
								3: deleteModifier obj m
								4: selectMore obj				
							)
										
										)	
								)  --End of ControlMultiMod by Name
							
-------------------------------------------------------------------														
		function ControlModbyStack = (				for obj in selectionGroup do
					if obj.modifiers.count >= spn5.value then (
							case ActionRadio.state of
							(
								1: obj.modifiers[spn5.value].enabled = true
								2: obj.modifiers[spn5.value].enabled = false
								3:  deleteModifier obj spn5.value
								4: selectMore obj	
							)								
										)
								)  --End of ControlMod by Stack
							
							
-------------------------------------------------------------------	
		  function ControlModbyClass = (
				for obj in selectionGroup do
					for m in obj.modifiers where (classof m) as string == ClassCombo.text do (
							case ActionRadio.state of 
							(
								1: obj.modifiers[m.name].enabled = true
								2: obj.modifiers[m.name].enabled = false
								3: deleteModifier obj m
								4: selectMore obj	
							)
																			)	

								)  --End of ControlMod by Class
							
		  function ControlMultiModbyClass = (
				for obj in selectionGroup do
					 for m = obj.modifiers.count to 1 by -1 where (classof obj.modifiers[m]) as string == ClassCombo.text do (
							case ActionRadio.state of 
							(
								1: obj.modifiers[m].enabled = true
								2: obj.modifiers[m].enabled = false
								3: deleteModifier obj m
								4: selectMore obj	
							)
																			)	

								)  --End of ControlMultiMod by Class								
-------------------------------------------------------------------	

											
	 function CheckRadioButtons = (
	with redraw off
	suspendEditing()
	setWaitCursor()
	
		case ActionRadio.state of 
				(
					4: clearselection()			
				)

	case x of 
		(
			1: if MultiMod_checkbx.checked then ControlMultiModbyName()  else ControlModbyName()
			2: ControlModbyStack()
			3: if MultiMod_checkbx.checked then ControlMultiModbyClass()  else ControlModbyClass()
		)
	resumeEditing()
	setArrowCursor()
							)  ---End of Check RadioButtons
											
---------------------------------------------------------------------------------
-- GUI Functions
---------------------------------------------------------------------------------	
	
				
	on ClassCombo selected sel do
	(
			RD_Name.state = 0
			RD_Stack.state = 0
			RD_Class.state = 1
			x = 3
			MultiMod_checkbx.enabled = true
		)
		
	on ClassCombo entered txt do
		ClassCombo.selected = txt
	
	on Edit1 entered text do
	(
			RD_Name.state = 1
			RD_Stack.state = 0
			RD_Class.state = 0
			x = 1
			MultiMod_checkbx.enabled = true
		)
	on spn5 changed val do
	(
			RD_Name.state = 0
			RD_Stack.state = 1
			RD_Class.state = 0
			x = 2
			MultiMod_checkbx.enabled = false
		)
	on RD_Name changed stat do
	(
			RD_Stack.state = 0
			RD_Class.state = 0
			setFocus ModRemover.Edit1
			x = 1
			MultiMod_checkbx.enabled = true
		)
	on RD_Stack changed stat do
	(
			RD_Name.state = 0
			RD_Class.state = 0
			x = 2
			MultiMod_checkbx.enabled = false
		)
	on RD_Class changed stat do
	(
			RD_Stack.state = 0
			RD_Name.state = 0
			x = 3
			MultiMod_checkbx.enabled = true
					 )
	on HelpBtn pressed do
		messageBox "Process only selected - find modifiers only in selected objects \r\n\r\nMulti modifiers check - check every object for multiple \r\nmodifier copys or instances" beep:false  title:"Options Help"
	
	fn ClassConfirm = (
				if RD_Class.state == 1 and ClassCombo.text == "" then messageBox "No Class selected!" beep:true title:"No Class selected" else CheckRadioButtons()
					)
		
	on MainBtn pressed do
		(
			if SelOBJ_checkbx.checked then  selectionGroup = selection as Array else selectionGroup = objects as Array
			if selectionGroup.count == 0 then  
			(
			if objects.count == 0 then messagebox "No objects in scene!" else messageBox "Please select some objects! \r\nIf you want process all, also not selected objects, check this in options" title:"No object selected!" beep:true
			)	
			else  ClassConfirm()		
		)
	
)

rollout a_About "About" category:1
(
	label lab1 "Modifiers Control 1.0"
	hyperlink lab2_ab "by Valdemaras Dzengo" align:#center address:" mailto:deko@deko.lt" color:(color 0 0 0) hoverColor:(color 255 255 255)
	label lab3_ab "Copyright \xa9 2005 " across:2
	hyperlink lab4_ab "DeKo" align:#center address:"www.deko.lt" color:(color 70 70 255) hoverColor:(color 255 255 255)
)
---------------------------------------------------------------------------------	
rf = newRolloutFloater "Modifiers Ctrl v1" 218 355
addRollout ModRemover rf 
addRollout a_About rf rolledUp:True

setFocus ModRemover.Edit1