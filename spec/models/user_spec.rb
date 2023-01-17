require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Espero validar os campos obrigatórios' do
    it 'Validar se o campo nome está presente' do
      user = build(:user)

      expect(user.valid?).to eq(true)
    end
    it 'Validar se o campo nome não está presente'
  end
end
