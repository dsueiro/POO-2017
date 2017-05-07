!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

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

!OOStackTest methodsFor: 'test' stamp: 'masch 5/7/2017 17:15:41'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'masch 5/7/2017 17:24:49'!
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

!OOStackTest methodsFor: 'test' stamp: 'masch 5/7/2017 17:25:01'!
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
	instanceVariableNames: 'itemsCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifying' stamp: 'masch 5/7/2017 20:33:30'!
pop

	^ itemsCollection removeLast itemValue.! !

!OOStack methodsFor: 'modifying' stamp: 'masch 5/7/2017 20:33:34'!
push: aValue
		
	itemsCollection add: (OOValueStackItem createWithValue: aValue).! !


!OOStack methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:33:06'!
isEmpty
	
	^ (itemsCollection last) hasValue == false.! !

!OOStack methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:33:11'!
size

	^ itemsCollection size - 1.! !

!OOStack methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:33:19'!
top
	
	^ (itemsCollection last) itemValue.! !


!OOStack methodsFor: 'initialization' stamp: 'masch 5/7/2017 20:32:57'!
initialize

	itemsCollection := OrderedCollection with: OOEmptyStackItem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackItem category: #'Stack-Exercise'!
Object subclass: #OOStackItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:24:48'!
hasValue

	^ self subclassResponsibility.! !

!OOStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:24:38'!
itemValue

	^ self subclassResponsibility.! !


!classDefinition: #OOEmptyStackItem category: #'Stack-Exercise'!
OOStackItem subclass: #OOEmptyStackItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:25:06'!
hasValue

	^ false.! !

!OOEmptyStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:21:33'!
itemValue

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOValueStackItem category: #'Stack-Exercise'!
OOStackItem subclass: #OOValueStackItem
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOValueStackItem methodsFor: 'initializing' stamp: 'masch 5/7/2017 20:27:36'!
initialiceWithValue: aValue
	
	^ value := aValue.! !


!OOValueStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:27:26'!
hasValue

	^ true.! !

!OOValueStackItem methodsFor: 'acceding' stamp: 'masch 5/7/2017 20:27:31'!
itemValue

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOValueStackItem class' category: #'Stack-Exercise'!
OOValueStackItem class
	instanceVariableNames: ''!

!OOValueStackItem class methodsFor: 'instance creation' stamp: 'masch 5/7/2017 20:29:09'!
createWithValue: aValue

	| newItem |
	
	newItem := self new.
	newItem initialiceWithValue: aValue .
	
	^ newItem.! !
