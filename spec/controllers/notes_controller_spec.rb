require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  
  describe '#create' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let!(:recipe) { FactoryGirl.create :recipe_with_ingredients }

    let(:params) do
      {
        note: {
          body: 'Nice recipe'
        },
        recipe_id: recipe.id
      }
    end

    context 'happy path' do
      it 'creates a note' do
        expect {
          post :create, params: params
        }.to change(Note, :count).from(0).to(1)
      end

      it 'redirects to the recipe page' do
        post :create, params: params

        expect(response).to redirect_to "http://test.host/recipes/1#comments"
      end
    end

    context 'invalid data' do
      before do
        params[:note][:body] = nil
      end

      it 'does NOT create a recipe' do
        expect {
          post :create, params: params
        }.to_not change(Note, :count)
      end
    end
  end

  describe '#destroy' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let!(:recipe) { FactoryGirl.create :recipe_with_ingredients }
    let!(:note) { FactoryGirl.create :note, recipe_id: recipe.id }

    it 'destroys the note' do
      expect{delete :destroy, params: { recipe_id: recipe.id, id: note.id }}.to change(Note, :count).by(-1)
    end

    it 'redirects to the recipe page' do
      delete :destroy, params: { recipe_id: recipe.id, id: note.id }

      expect(response).to redirect_to(recipe)
    end

    it 'displays a flash message' do
      delete :destroy, params: { recipe_id: recipe.id, id: note.id }

      expect(flash[:notice]).to match(/^Note successfully deleted/)
    end
  end

end
