require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", :titleize => 'Chef Goldblum', :bake => true) }
  subject { Dessert.new('cookie', 10, chef)}

  describe "#initialize" do
    it "sets a type" do 
      expect(subject.type).to eq('cookie')
    end

    it "sets a quantity" do
      expect(subject.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(subject.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new('cookie', 'all the cookies', chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    before(:each) { subject.add_ingredient('sugar') }

    it "adds an ingredient to the ingredients array" do   
      expect(subject.ingredients.length).to eq(1)
      expect(subject.ingredients.first).to eq('sugar')
    end
  end

  describe "#mix!" do
    original_ingredients = ['sugar', 'flour', 'egg', 'milk']
    let(:cookie) { Dessert.new('cookie', 5, chef) }

    it "shuffles the ingredient array" do
      original_ingredients.each { |ingredient| cookie.add_ingredient(ingredient) }
      cookie.mix!
      expect(cookie.ingredients).to_not be(original_ingredients)
      expect(cookie.ingredients).to match_array(original_ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      subject.eat(5)
      expect( subject.quantity ).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { subject.eat(11) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect( subject.serve ).to eq("Chef Goldblum has made 10 cookies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect( subject.make_more ).to be true
    end
  end
end
