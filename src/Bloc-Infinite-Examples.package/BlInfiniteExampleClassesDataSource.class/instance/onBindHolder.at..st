instance creation
onBindHolder: anElementHolder at: aPosition
	"Update holder's model"
	anElementHolder class: (classes at: aPosition)