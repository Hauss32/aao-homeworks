require 'rspec'
require 'lrucache'

describe LRUCache do
    subject { LRUCache.new(4) }
    let(:eles) { [1, :some_symbol, "string", { :some_key => "a value" }] }

    describe '#initialize' do
        it 'sets @cache to an empty array' do
            cache_var = subject.instance_variable_get(:@cache)
            expect(cache_var).to be_empty
        end

        it 'sets @limit to argument provided' do
            limit_var = subject.instance_variable_get(:@limit)
            expect(limit_var).to eq(4)
        end
    end

    describe '#count' do
        it 'returns the number of elements in @cache' do
            subject.instance_variable_set(:@cache, eles)
            expect(subject.count).to eq(eles.length)
        end
    end

    describe '#add' do
        context 'when there is room in @cache' do
            it 'adds the element to the end of @cache' do
                subject.add(:some_symbol)
                subject.add("string")
                cache = subject.instance_variable_get(:@cache)
                expect(cache[-1]).to eq("string")
            end
        end

        context 'when the cache is already full' do
            before(:each) { eles.each { |el| subject.add(el) } }

            it 'removes the first item in @cache' do
                second_ele = eles[1]
                subject.add("another_string")
                cache = subject.instance_variable_get(:@cache)
                expect(cache.first).to eq(second_ele)
            end

            it 'adds the new element to the end' do
                new_ele = "another_string"
                subject.add(new_ele)
                cache = subject.instance_variable_get(:@cache)
                expect(cache.last).to eq(new_ele)
            end
        end

        context 'when the element already exists in @cache' do
            before(:each) { eles.each { |el| subject.add(el) } }

            it 'removes the element from @cache and adds it back to the end' do
                existing_el = eles.first
                subject.add(existing_el)
                cache = subject.instance_variable_get(:@cache)
                expect(cache[0]).to_not eq(existing_el)
                expect(cache[-1]).to eq(existing_el)
            end
        end

    end
end