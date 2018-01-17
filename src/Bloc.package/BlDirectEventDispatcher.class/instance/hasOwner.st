api - testing
hasOwner
	"Return true if I am attached to a specific owner, false otherwise.
	All added or removed event handlers will receive a hook message (onInstalledIn: onUninstalledIn:) with the owner as argument"
	<return: #Boolean>
	
	^ owner isNotNil