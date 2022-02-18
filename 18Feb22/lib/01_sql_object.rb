require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns 
    
    rows = DBConnection.execute2(<<-SQL)
          SELECT *
          FROM #{self.table_name}
          LIMIT 0
        SQL

    @columns = rows.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { self.attributes[col] }
      define_method(col.to_s + '=') { |val| self.attributes[col] = val }
    end
  end

  def self.table_name=(table_name)
      @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map { |record| self.new(record) }
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE id = ?
    SQL

    results.empty? ? nil : self.new(results.first)
  end

  def initialize(params = {})
    params.each do |attr, val|
      raise "unknown attribute '#{attr}'" unless self.class.columns.include?(attr.to_sym)
      self.send(attr.to_s + '=', val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.attributes.values
  end

  def insert
    columns = self.attributes.keys
    col_strs = columns.map(&:to_s)
    values = self.attribute_values
    query_col_str = "(#{col_strs.join(', ')})"
    q_mark_arr = ['?'] * values.length
    query_val_str = "(#{q_mark_arr.join(', ')})"

    DBConnection.execute(<<-SQL, *values)
      INSERT INTO #{self.class.table_name} #{query_col_str}
      VALUES #{query_val_str}
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    attributes = self.attributes
    id_val = attributes.delete(:id) #id used only in WHERE clause
    columns = attributes.keys
    col_strs = columns.map { |col| col.to_s + ' = ?'}
    values = attributes.values
    values << id_val #id used last
    query_col_str = "#{col_strs.join(', ')}"

    DBConnection.execute(<<-SQL, *values)
      UPDATE #{self.class.table_name} 
      SET #{query_col_str}
      WHERE id = ?
    SQL
  end

  def save
    self.id ? self.update : self.insert
  end
end
