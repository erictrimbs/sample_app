class User
    attr_accessor :name, :email
    # equivalent: getters and setters for :name, :email
    # instance variables are accessible in other classes/views

    def initialize(attributes = {}) # executed on User.new call
        @name  = attributes[:name]
        @email = attributes[:email]
        # equivalent: attr_accessor[:name] = attributes[:name]
    end

    def formatted_email
        "#{@name} <#{@email}>"
    end
end