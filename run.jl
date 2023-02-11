using PDDL, SymbolicPlanners

domain = load_domain("./PDDL-Bus/domain.pddl")
problem = load_problem("./PDDL-Bus/instance.pddl")
goal = PDDL.get_goal(problem)

c_domain, c_problem= compiled(domain, problem)
spec = MinStepsGoal(PDDL.get_goal(problem))
planner = AStarPlanner(HAdd())

sol = planner(c_domain, c_problem, spec)
print(sol)
