require 'spec_helper'

describe SimpleEnum::Scopes, active_record: true do

  fake_active_record(:klass) do
    as_enum :state, [:very_bad, :bad, :good, :very_good]
  end

  context 'generate_enum_scopes_extension_for' do
    context 'define_range_scope_method' do
      context 'gem query' do
        context 'objects are in range' do
          let!(:bad)       { klass.create(state: :bad) }
          let!(:good)      { klass.create(state: :good) }

          it 'returns the object in range' do
            objects = klass.state_between(:bad, :very_good)
            expect(objects.count).to eq(2)
            expect(objects.map(&:state)).to eq %i(bad good)
          end
        end

        context 'object is out of range' do
          let!(:very_good)      { klass.create(state: :very_good) }

          it 'returns no object' do
            objects = klass.state_between(:very_bad, :good)
            expect(objects).to be_empty
          end
        end
      end
    end

    context 'define_multiple_values_scope_method' do
      let!(:very_bad)  { klass.create(state: :very_bad) }
      let!(:bad)       { klass.create(state: :bad) }
      let!(:good)      { klass.create(state: :good) }
      let!(:very_good) { klass.create(state: :very_good) }

      context 'gem query' do
        it 'returns equivalent of ActiveRecord query' do
          objects = klass.states_as(:bad)
          expect(objects.count).to eq(1)
          expect(objects.first).to be_bad
        end

        it 'returns equivalent of ActiveRecord query' do
          statees = %i(very_bad bad)
          objects = klass.states_as(statees)
          expect(objects.count).to eq(2)
          expect(objects.map(&:state)).to eq(statees)
        end
      end
    end
  end
end
