(define (domain onibus-joao)
	(:requirements :typing :equality :fluents :durative-actions)
	(:types
		bus person - movable
		stop - locale
	)

	(:functions
		(total)
		
	(time-person)
		(road-length ?l1 ?l2 - locale)
		(bus-cycle ?b)
		(time-bus ?b)
	)

	(:predicates
		(at ?m - movable ?l - locale)
		(connect ?b - bus ?l1 ?l2 - stop)
	)

	(:action pick-bus
		:parameters (?p - person ?b - bus ?l1 ?l2 - stop)
		:precondition (and 
			(at ?p ?l1)
			(at ?b ?l1)
			(connect ?b ?l1 ?l2)
			(<= (time-person) (time-bus ?b))
		)
		:effect (and
			(not (at ?p ?l1))
			(at ?p ?l2)
			(increase (time-bus ?b) (road-length ?l1 ?l2))
			(assign (time-person) (time-bus ?b))
			(not (at ?b ?l1))
			(at ?b ?l2)
			(increase (total) 1)
		)
	)
	(:action drive
		:parameters (?b - bus ?l1 ?l2 - stop)
		:precondition (and 
			(connect ?b ?l1 ?l2)
			(at ?b ?l1)
		)
		:effect (and
			(increase (time-bus ?b) (road-length ?l1 ?l2))
			(not (at ?b ?l1))
			(at ?b ?l2)
		)
	)
)
