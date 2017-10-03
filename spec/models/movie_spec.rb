require 'rails_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'calls Tmdb with title keywords' do
      expect(Tmdb::Movie).to receive(:find).with('Inception')
      Movie.find_in_tmdb('Inception')
    end
  end
end