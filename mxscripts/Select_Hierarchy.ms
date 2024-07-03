function selectHierarchy =
(
	for p in selection do
	(
	if p.children != undefined do
		(
		selectmore p.children
		)
	)
)
selectHierarchy()