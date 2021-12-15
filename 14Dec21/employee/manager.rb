require_relative "employee"

class Manager < Employee
    attr_accessor :employees
    def initialize(name, title, salary, boss)
        super
        @employees = []
    end

    def bonus(multiplier)
        sum_employee_salaries = self.find_total_salary_sum(@employees)
        bonus = sum_employee_salaries * multiplier

        bonus
    end

    def find_total_salary_sum(employees)
        return 0 if employees.empty?

        salary_sum = 0

        employees.each do |emp|
            salary_sum += emp.salary
            employees = emp.is_a?(Manager) ? emp.employees : []
            salary_sum += self.find_total_salary_sum(employees)
        end

        salary_sum
    end
end

f = Manager.new('Ned', 'Founder', 1000000, nil)
m1 = Manager.new('Darren', 'TA Manager', 78000, f)
e1 = Employee.new('David', 'TA', 10000, m1)
e2 = Employee.new('Shawna', 'TA', 12000, m1)

m1.employees += [e1, e2]
f.employees << m1

p f.bonus(5) # => 500_000
p m1.bonus(4) # => 88_000
p e1.bonus(3) # => 30_000