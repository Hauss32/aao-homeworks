require 'sqlite3'
require 'singleton'
require 'plays'

class PlaywrightsDBConnetion < SQLite3::Database
    include Singleton

    def initialize
        super('playwrights.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end


class Playywright
    def initialize(options)
        @id = options['id']
        @name = options['name']
        @birth_year = options['birth_year']     
    end
end