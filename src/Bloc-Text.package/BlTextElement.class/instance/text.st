accessing
text
	"Return the text I currently represent.
	Note, that I work with immutable text (BrText), so if you want to change or style text
	you have to set manually sending #text: message with new styled text model"
	<return: #BrText>
	
	^ text