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

class User
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM users
            WHERE id = ?
        SQL

        User.new(user.first)
    end

    def self.find_by_name(first, last)
        user = QuestionsDatabase.instance.execute(<<-SQL, first, last)
            SELECT *
            FROM users
            WHERE fname = ? AND lname = ?
        SQL

        User.new(user)
    end

    attr_accessor :id, :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

class Question
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM questions
            WHERE id = ?
        SQL

        Question.new(question.first)
    end

    attr_accessor :id, :title, :body, :author_id

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = ['author_id']
    end
end

class QuestionFollow
    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM question_follows
            WHERE id = ?
        SQL

        QuestionFollow.new(question_follow.first)
    end

    attr_accessor :id, :question_id, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class QuestionLike
    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM question_likes
            WHERE id = ?
        SQL

        QuestionLike.new(question_like.first)
    end

    attr_accessor :id, :question_id, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class Reply
    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM replies
            WHERE id = ?
        SQL

        Reply.new(reply.first)
    end

    attr_accessor :id, :question_id, :parent_reply_id, :body, :user_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @body = options['body']
        @user_id = ['user_id']
    end
end