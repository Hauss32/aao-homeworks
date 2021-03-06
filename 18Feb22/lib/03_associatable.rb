require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.to_s.downcase}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    belongs_options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = belongs_options

    define_method(name) do
      fk_id = self.send(belongs_options.foreign_key)
      belongs_table = belongs_options.table_name
      record = DBConnection.execute(<<-SQL, fk_id)
        SELECT *
        FROM #{belongs_table}
        WHERE id = ?
      SQL

      record.empty? ? nil : belongs_options.model_class.new(record.first)
    end
  end

  def has_many(name, options = {})
    many_options = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      many_table = many_options.table_name
      pk_id = self.send(many_options.primary_key)
      fk_field = many_options.foreign_key
      
      records = DBConnection.execute(<<-SQL, pk_id)
        SELECT *
        FROM #{many_table}
        WHERE #{fk_field} = ?
      SQL

      records.map { |record| many_options.model_class.new(record) }
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
