-------------------------------------------------------------------------------
-- Macro Script viewport 'toggle' of Frost objects.
-------------------------------------------------------------------------------
macroScript FrostState category:"deko" toolTip:"Turn On/Off Viewport Frost" buttonText:"Frost On/Off"
(
	global frost_state=true
	on isChecked return not frost_state
	on execute do 
	(
		for o in objects where classOf o == Frost do
				(
				o.enableViewportMesh = frost_state
				)
		frost_state = not frost_state
	)
)