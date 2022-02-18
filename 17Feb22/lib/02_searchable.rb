require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_cols = params.keys.map { |col| col.to_s + ' = ?' } 
    where_str = where_cols.join(' AND ')
    values = params.values

    records = DBConnection.execute(<<-SQL, *values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_str}
    SQL

    records.map { |record| self.new(record) }
  end
end

class SQLObject
  extend Searchable
end
