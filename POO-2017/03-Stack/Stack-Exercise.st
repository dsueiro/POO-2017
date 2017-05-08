!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test'!
test01StackShouldBeEmptyWhenCreated
	| temp1 |
	self break.
	temp1 _ OOStack new.
	self assert: temp1 isEmpty.! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 22:48:12'!
initialize
	top := OOStackEmptyNode new! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 22:51:47'!
isEmpty
	^top isEmpty! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:39:13'!
pop
	|anObject|
	anObject := top value.
	top := top next.
	^anObject
		! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:36:54'!
push: anObject
	
	top := (OOStackNotEmptyNode new value: anObject; next: top)
		! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:41:05'!
size
	^top size	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:40:05'!
top
	^top value	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 22:44:58'!
isEmpty
	self subClassResponsability! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:36:01'!
next
	self subClassResponsability! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:41:14'!
size
	self subClassResponsability! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:36:03'!
value
	self subClassResponsability! !


!classDefinition: #OOStackEmptyNode category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackEmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 22:50:55'!
isEmpty
	^true! !

!OOStackEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:34:57'!
next
	self error: OOStack stackEmptyErrorDescription! !

!OOStackEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:41:35'!
size
	^0! !

!OOStackEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:35:21'!
value
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackNotEmptyNode category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackNotEmptyNode
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:01:15'!
isEmpty
	^false! !

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:12:33'!
next
	^next! !

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:12:20'!
next: anOOStackNode
	next := anOOStackNode! !

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:41:51'!
size
	^1+next size! !

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:12:46'!
value
	^value! !

!OOStackNotEmptyNode methodsFor: 'as yet unclassified' stamp: 'pp 5/7/2017 23:12:05'!
value: anObject
	value := anObject! !
