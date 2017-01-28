host space - accessing
icon: aForm
	"Change window icon to the given one"
		
	aForm ifNil: [ ^ self ].
	
	"hostWindow primSetIcon: anIcon"