!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'masch 5/9/2017 21:14:35'!
test01AliveCellWithLessThanTwoAliveNeighDies
	
	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: {1@1}.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1)! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'masch 5/9/2017 21:16:31'!
test02AliveCellWithTwoNeighsStaysAlive
	
	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: {1@1. 2@1. 1@0}.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1)! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'masch 5/9/2017 21:03:19'!
test03
	
	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: {1@1. 2@1. 1@0. 0@0. 0@1}.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1)! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'masch 5/9/2017 21:47:03'!
nextGeneration
	aliveCells := aliveCells select: [:aCell | (self aliveNeibo: aCell) = 2]! !


!GameOfLife methodsFor: 'accessing' stamp: 'masch 5/9/2017 21:33:26'!
aliveNeibo: aPoint

	^(aPoint eightNeighbors intersection: aliveCells) size ! !

!GameOfLife methodsFor: 'accessing' stamp: 'masch 5/9/2017 20:53:33'!
initializeWith: anArray

	aliveCells := anArray! !

!GameOfLife methodsFor: 'accessing' stamp: 'masch 5/9/2017 21:39:28'!
isDeadAt: aPoint 
	^(aliveCells includes: aPoint) not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'masch 5/9/2017 20:52:45'!
withLiveCells: anArray	

	^ self new initializeWith: anArray.! !
