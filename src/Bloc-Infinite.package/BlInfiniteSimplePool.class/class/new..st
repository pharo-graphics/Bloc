instance creation
new: anInteger
^ self basicNew setPool: (self arrayType new: anInteger); initialize