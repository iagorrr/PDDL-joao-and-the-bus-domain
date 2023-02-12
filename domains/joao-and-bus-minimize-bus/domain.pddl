(define (domain joao-and-the-bus)
	(:requirements :typing :equality :fluents :durative-actions :conditional-effects :negative-preconditions :disjunctive-preconditions)
	(:types
		bus person - movable
		stop - locale
	)
	(:functions
		(total-cost)
		(time-person)
		(road-length ?l1 ?l2 - locale ?b - bus)
		(time-bus ?b - bus)
	)

	(:predicates
		(at ?m - movable ?l - locale)
		(connect ?l1 ?l2 - stop ?b - bus)
		(in-bus ?b)
	)
	(:action pick-bus
		:parameters (?p - person ?b - bus ?l1 ?l2 - stop)
		:precondition (and
			(at ?p ?l1)
			(at ?b ?l1)
			(connect ?l1 ?l2 ?b)
			(or
				(< (time-person) (time-bus ?b))	
				(= (time-person) (time-bus ?b))	
			)
			(or
				(in-bus ?b)
				(forall (?b1 - bus)
					(not (in-bus ?b1))
				)
			)
		)
		:effect (and
			(not (at ?p ?l1))
			(at ?p ?l2)
			(increase (time-bus ?b) (road-length ?l1 ?l2 ?b))
			(assign (time-person) (+ (time-bus ?b) (road-length ?l1 ?l2 ?b)))
			(not (at ?b ?l1))
			(at ?b ?l2)

			(when 
				(not (in-bus ?b))
				(and
					(increase (total-cost) 1)
					(in-bus ?b)
				)
			)
		)
	)
	(:action drop-bus
		:parameters (?b - bus)
		:precondition (and 
			(in-bus ?b)
		)
		:effect (and 
			(not (in-bus ?b))
			(increase (total-cost) 1)
		)
	)
	(:action drive
		:parameters (?b - bus ?l1 ?l2 - stop)
		:precondition (and
			(connect ?l1 ?l2 ?b)
			(at ?b ?l1)
		)
		:effect (and
			(increase (time-bus ?b) (road-length ?l1 ?l2 ?b))
			(not (at ?b ?l1))
			(at ?b ?l2)
		)
	)
)