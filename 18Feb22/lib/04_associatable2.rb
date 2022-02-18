require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      
      through_table = through_options.table_name
      through_id_val = self.send(through_options.foreign_key)
      fk_field = source_options.foreign_key
      pk_field = source_options.primary_key
      source_table = source_options.table_name

      record = DBConnection.execute(<<-SQL, through_id_val)
        SELECT #{source_table}.*
        FROM #{through_table}
        JOIN #{source_table} 
          ON #{through_table}.#{fk_field} = #{source_table}.#{pk_field}
        WHERE #{through_table}.id = ?
      SQL

      source_options.model_class.new(record.first)
    end
  end

end
