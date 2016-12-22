instance creation
onBindHolder: anElementHolder at: aPosition
	"Update holder's model"
	anElementHolder text: (SpText fromRope: (self lineAt: aPosition))