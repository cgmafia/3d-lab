 ------select object!

obj = selection[1]
for p = polyop.getNumFaces obj to 1 by -1 do 
polyOp.detachFaces obj #{p} delete: true asNode:true name:"Object"
