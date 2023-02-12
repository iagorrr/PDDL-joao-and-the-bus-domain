using PDDL, SymbolicPlanners, ArgParse

function parse_commandline()
    s  = ArgParseSettings()
    @add_arg_table s begin
        "--domain"
            arg_type = String
            default = "" 
        "--instance"
            arg_type = String
            default = "" 
    end
    return parse_args(s)
end

function run_solver(domain_path, instance_path)
    domain = load_domain(domain_path)
    problem = load_problem(instance_path)
    state = initstate(domain, problem)
    goal = PDDL.get_goal(problem)
    spec = MinStepsGoal(problem)
    planner = ForwardPlanner(heuristic=HAdd())
    sol = planner(domain, state, spec)
    print(sol)
end

function main()
    @show parsed_args = parse_commandline()

    domain_path = parsed_args["domain"]
    instance_path = parsed_args["instance"]

    @show run_solver(domain_path, instance_path) 
end

main()