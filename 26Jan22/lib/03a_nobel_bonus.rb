# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT yr
    FROM nobels
    WHERE 
      subject = 'Physics' AND
      yr IN (
        SELECT yr 
        FROM nobels 
        WHERE subject IN ('Physics', 'Chemistry')
        GROUP BY 1
        HAVING COUNT(DISTINCT subject) = 1
      )
    GROUP BY 1
  SQL
end
