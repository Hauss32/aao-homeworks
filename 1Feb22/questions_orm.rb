require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class ModelBase
    def self.table_name
        nil
    end

    def self.find_by_id(id)
        record = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM #{self.table_name}
            WHERE id = ?
        SQL

        self.new(record.first)
    end

    def self.all
        records = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT *
            FROM #{self.table_name}
        SQL

        records.map { |record| self.new(record) }
    end

    def self.where(options)
        if options.is_a?(String)
            where_str = options
            vals = []     
        else  
            cols = options.keys.map(&:to_s)
            vals = options.values
            where_arr = []
            (0...cols.length).each { |idx| where_arr << (cols[idx] + ' = ? ') }
            where_str = where_arr.join(" AND ")
        end
        
        records = QuestionsDatabase.instance.execute(<<-SQL, *vals)
            SELECT *
            FROM #{self.table_name}
            WHERE #{where_str}
        SQL

        records.map { |record| self.new(record) }
    end

    def self.find_by(args)
        self.where(args)
    end

    def save
        if @id
            update
        else
            i_vars = self.instance_variables
            i_vars.delete(:@id) #id is auto-generated
            col_names_str = i_vars.map { |var| var.to_s[1..-1]}.join(", ")
            values = i_vars.map { |var| instance_variable_get(var) }
            q_marks = (['?'] * values.length).join(", ")
            
            QuestionsDatabase.instance.execute(<<-SQL, *values)
                INSERT INTO #{self.class.table_name} (#{col_names_str})
                VALUES (#{q_marks})
            SQL

            @id = QuestionsDatabase.instance.last_insert_row_id
        end
    end

    def update
        raise "User does does not exist." unless @id

        i_vars = self.instance_variables
        i_vars.push(i_vars.delete(:@id)) #make sure @id is last for WHERE clause
        col_names_arr = i_vars.map { |var| var.to_s[1..-1] }
        col_names_arr.delete('id') #id will be hard-coded in WHERE clause
        values = i_vars.map { |var| instance_variable_get(var) }
        set_str = col_names_arr.join(" = ?, ") + " = ?"

        QuestionsDatabase.instance.execute(<<-SQL, *values)
            UPDATE #{self.class.table_name}
            SET #{set_str}
            WHERE id = ?
        SQL
    end
end

class User < ModelBase
    def self.table_name
        'users'
    end

    def self.find_by_name(first, last)
        user = QuestionsDatabase.instance.execute(<<-SQL, first, last)
            SELECT *
            FROM users
            WHERE fname = ? AND lname = ?
        SQL

        User.new(user.first)
    end

    attr_accessor :id, :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        raise "User does not exist." unless @id
        Question.find_by_author_id(@id)
    end

    def authored_replies
        raise "User does not exist." unless @id
        Reply.find_by_user_id(@id)
    end

    def followed_questions
        raise "User does not exist." unless @id
        QuestionFollow.followed_questions_for_user_id(@id)
    end

    def count_authored_questions
        raise "User does not exist." unless @id
        Question.count_questions_by_author_id(@id)
    end

    def count_likes_from_authored_questions
        raise "User does not exist." unless @id
        QuestionLike.count_likes_for_author_id(@id)
    end

    def average_karma
        count_questions = count_authored_questions
        return 0 unless count_questions > 0

        count_likes_from_authored_questions / count_questions
    end
end

class Question < ModelBase
    def self.table_name
        'questions'
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT *
            FROM questions
            WHERE author_id = ?
        SQL

        questions.map { |question| Question.new(question) }
    end

    def self.count_questions_by_author_id(author_id)
        count = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT COUNT(*)
            FROM questions
            WHERE author_id = ?
        SQL

        count.first.values.first
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end

    attr_accessor :id, :title, :body, :author_id

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        User.find_by_id(@author_id)
    end

    def replies
        raise "Question does not exist." unless @id
        Reply.find_by_question_id(@id)
    end

    def followers
        raise "Question does not exist." unless @id
        QuestionFollow.followers_for_question_id(@id)
    end

    def likers
        raise "Question does not exist." unless @id
        QuestionLike.likers_for_question_id(@id)
    end

    def num_likes
        raise "Question does not exist." unless @id
        QuestionLike.num_likes_for_question_id(@id)
    end

end

class QuestionFollow < ModelBase
    def self.table_name
        'question_follows'
    end

    def self.followers_for_question_id(question_id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT *
            FROM question_follows
            WHERE question_id = ?
        SQL

        question_follows.map { |follow| User.find_by_id(follow['user_id']) }
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                question_id,
                COUNT(*) as followers
            FROM question_follows
            GROUP BY 1
            ORDER BY followers DESC
            LIMIT ?
        SQL

        questions.map { |question| Question.find_by_id(question['question_id']) }  
    end

    def self.followed_questions_for_user_id(user_id)
        followed_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT *
            FROM question_follows
            WHERE user_id = ?
        SQL

        followed_questions.map { |question| Question.find_by_id(question['question_id']) }
    end

    attr_accessor :id, :question_id, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class QuestionLike < ModelBase
    def self.table_name
        'question_likes'
    end

    def self.likers_for_question_id(question_id)
        question_likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT *
            FROM question_likes
            WHERE question_id = ?
        SQL

        question_likers.map { |like| User.find_by_id(like['user_id']) }
    end

    def self.count_likes_for_author_id(author_id)
        count = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT COUNT(*)
            FROM questions AS q
            JOIN question_likes AS ql ON q.id = ql.question_id
            WHERE q.author_id = ?
        SQL

        count.first.values.first
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                question_id,
                COUNT(*) as likes
            FROM question_likes
            GROUP BY 1
            ORDER BY likes DESC
            LIMIT ?
        SQL

        questions.map { |question| Question.find_by_id(question['question_id']) }  
    end

    def self.liked_questions_for_user_id(user_id)
        liked_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT *
            FROM question_likes
            WHERE user_id = ?
        SQL

        liked_questions.map { |question| Question.find_by_id(question['question_id']) }
    end

    def self.num_likes_for_question_id(question_id)
        num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT COUNT(*)
            FROM question_likes
            WHERE question_id = ?
        SQL

        num_likes.first.values.first
    end

    attr_accessor :id, :question_id, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class Reply < ModelBase
    def self.table_name
        'replies'
    end

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT *
            FROM replies
            WHERE user_id = ?
        SQL

        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT *
            FROM replies
            WHERE question_id = ?
        SQL

        replies.map { |reply| Reply.new(reply) }
    end

    attr_accessor :id, :question_id, :parent_reply_id, :body, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @body = options['body']
        @user_id = options['user_id']
    end

    def author
        User.find_by_id(@user_id)
    end

    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        return nil unless @parent_reply_id
        Reply.find_by_id(@parent_reply_id)
    end

    def child_replies
        raise "Reply does not exist." unless @id
        replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
            SELECT *
            FROM replies
            WHERE parent_reply_id = ?
        SQL

        replies.map { |reply| Reply.new(reply) }
    end
end