-------------------------------------------------------------------------------
-- move selection to center
-------------------------------------------------------------------------------
macroScript CenterObj category:"deko" toolTip:"Move Selection to center" buttonText:"to Center"
(
	if selection.count != 0 do 
	(
		selection.pos = [0,0,0]
	)
)

