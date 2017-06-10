!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/10/2017 19:44:58'!
test01ANewCartIsEmpty
	| cart |
	cart := Cart new.
	
	self assert: cart empty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/10/2017 19:48:23'!
test02AfterAddingABookACartIsNotEmpty
	| cart book |
	cart := Cart new.
	
	book := Book new.
	
	cart add: book.
	
	self deny: cart empty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/10/2017 20:10:57'!
test03AfterAddingABookTheCartContainsIt
	| cart book |
	cart := Cart new.
	
	book := Book new.
	
	cart add: book.
	
	self assert: (cart includes: book).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/10/2017 20:10:38'!
test04BeforeAddingABookTheCartDoesNotContainsIt
	| cart book |
	cart := Cart new.
	
	book := Book new.
	
	self deny: (cart includes: book).! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'inspecting' stamp: 'DHS 6/10/2017 19:59:48'!
empty
	^content isEmpty! !

!Cart methodsFor: 'inspecting' stamp: 'DHS 6/10/2017 19:57:11'!
initialize
	content := Bag new! !


!Cart methodsFor: 'adding' stamp: 'DHS 6/10/2017 19:57:40'!
add: aBook 
	content add: aBook! !


!Cart methodsFor: 'evaluating' stamp: 'DHS 6/10/2017 20:08:00'!
includes: aBook 
	^content includes: aBook! !
