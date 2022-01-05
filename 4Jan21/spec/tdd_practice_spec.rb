require 'rspec'
require 'tdd_practice'

describe Array do
    describe '#my_uniq' do
        test_arr = [1, 2, 2, 'a', 'b', 'a']

        it 'returns a new array' do
            expect(test_arr.my_uniq).to be_a(Array)
            expect(test_arr.my_uniq).to_not be(test_arr)
        end

        it 'contains no duplicates of original elements' do
            uniques = test_arr.uniq
            expect(test_arr.my_uniq).to eq(uniques)
        end

        it 'does not change the original array' do
            test_arr_dup = test_arr.dup
            test_arr.my_uniq
            expect(test_arr).to eq(test_arr_dup)
        end

        it 'does not call Array.uniq' do
            expect(test_arr).to_not receive(:uniq)
            test_arr.my_uniq
        end
    end

    describe "#two_sum" do
        # Write a new Array#two_sum method that finds all pairs of positions 
        # where the elements at those positions sum to zero.
        nums_arr = [-1, 0, 2, -2, 1]

        it 'returns a new array' do
            expect(nums_arr.two_sum).to be_a(Array)
            expect(nums_arr.two_sum).to_not be(nums_arr)
        end

        it 'does not change the original array' do
            nums_arr_dup = nums_arr.dup
            nums_arr.two_sum
            expect(nums_arr).to eq(nums_arr_dup)
        end

        it 'throws an error if any elements are not integers' do
            bad_arr = [1, 2, 'str', 4]
            expect { bad_arr.two_sum }.to raise_error("All array elements must be integers.")
        end

        context 'when array has 2 elements that sum to 0' do
            it 'returns an array with each pair of idxs that sum to 2' do
                expect(nums_arr.two_sum).to eq([[0, 4], [2, 3]])
            end
        end

        context 'when array does not have 2 elements that sum to 0' do
            it 'returns an empty array' do
                no_sum_arr = [-1, 2, -3, 4, -5]
                expect(no_sum_arr.two_sum).to be_empty
            end
        end
    end

    describe '#my_transpose' do
        matrix = [
            [1, 2, 3],
            [1, 2, 3],
            [1, 2, 3]
        ]

        it 'returns a new array of the same size' do
            expect(matrix.my_transpose).to_not be(matrix)
            expect(matrix.my_transpose.length).to eq(matrix.length)
        end

        it 'throws an error if elements are not of equal size' do
            uneven_matrix = matrix.dup
            uneven_matrix << [1, 2]
            expect { uneven_matrix.my_transpose }.to raise_error("All elements must be Arrays of the same length.")
        end

        it 'returns an array of column values to transpose rows' do
            transposed = matrix.transpose
            expect(matrix.my_transpose).to eq(transposed)
        end

        it 'does not call Array.transpose' do
            expect(matrix).to_not receive(:transpose)
            matrix.my_transpose
        end
    end
end

describe 'stock_picker' do
    stock_arr = [2, 2, 5, 6, 3, 9, 8, 4, 1, 7, 11, 14, 15, 7, 7]

    it 'accepts an array of numbers as an argument' do
        expect { stock_picker(stock_arr) }.to_not raise_error
    end

    it 'raises an error when argument is not an array of at least 2 numbers' do
        fail_arr = [1]
        expect { stock_picker(fail_arr) }.to raise_error("Argument must be array of at least 2 numbers.")
    end

    it 'returns the idx positions of the greatest positive delta between two values' do
        expect(stock_picker(stock_arr)).to eq([8, 12])
    end
end

describe Tower do
    describe '#initialize' do
        subject { Tower.new }
        it 'initializes with a towers array with 3 sub-arrays' do
            expect(subject.towers).to be_a(Array)
            expect(subject.towers.length).to eq(3)
            is_all_arrs = subject.towers.all? { |el| el.is_a?(Array) }
            expect(is_all_arrs).to be true
        end

        it 'initally has numbers 1-4 in the first tower array' do
            expect(subject.towers[0]).to eq([4,3,2,1])
        end

    end

    describe '#move' do
        it 'accepts an array of 2 numbers (tower idxs)' do
            expect { subject.move([0, 1]) }.to_not raise_error
        end

        it 'raises an error if one or both towers are invalid' do
            expect { subject.move([1, 4]) }.to raise_error("One or both tower idxs provided are not valid.")
        end

        it 'raises an error if move is not allowed' do
            expect { subject.move([2, 1]) }.to raise_error("Move is not valid")
        end

        let(:valid_move) { subject.move([0, 1]) }
        it 'moves the piece to a new tower when move is valid' do
            valid_move
            expect(subject.towers[0]).to eq([4, 3, 2])
            expect(subject.towers[1]).to eq([1])
        end

    end

    describe '#won?' do
        let(:set_won_towers) { subject.instance_variable_set(:@towers, [[], [], [4, 3, 2, 1]]) }
        it 'returns true when all pieces are in order on the final tower' do
            set_won_towers
            expect(subject.won?).to be true
        end

        let(:valid_move) { subject.move([0, 1]) }
        it 'returns false unless all pieces are in order on final tower' do
            valid_move
            expect(subject.won?).to be false
        end
    end
end